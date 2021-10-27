package com.ssm.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssm.util.JedisPoolUtil;
import com.ssm.mapper.BookMapper;
import com.ssm.mapper.CartMapper;
import com.ssm.mapper.DealMapper;
import com.ssm.pojo.Book;
import com.ssm.pojo.Cart;
import com.ssm.pojo.Deal;
import com.ssm.service.CartService;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

@Service("cartService")
public class CartServiceImpl implements CartService{
	
	//生成dao层对象
	@Autowired
	@Qualifier("cartMapper")
	private CartMapper cartMapper;
	
	@Autowired
	@Qualifier("bookMapper")
	private BookMapper bookMapper;
	
	@Autowired
	@Qualifier("dealMapper")
	private DealMapper dealMapper;
	
	
	//通过连接池得到jedis对象
	JedisPool jedisPoolInstance = JedisPoolUtil.getJedisPoolInstance();
	Jedis jedis = null;
	
	
	/**
	 * 查询用户购物车信息
	 */
	@Override
	public List<Cart> queryUserCart(String cartName) {
		jedis = jedisPoolInstance.getResource();
		
		List<Cart> userCart = new ArrayList<Cart>();
		
		//从Redis中获取所有的bookId
		Set<String> hkeys = jedis.hkeys(cartName);
		if( (null!=hkeys) && (!hkeys.isEmpty()) ) {
			for(String bookId : hkeys) {	//取出每本书对应的数量
				int number = Integer.parseInt(jedis.hget(cartName, bookId));
				
				userCart.add(new Cart(bookId,number));
			}
		}
		
		jedis.close();
		return userCart;
	}
	
	
	/**
	 * 更新用户购物车信息
	 */
	@Override
	public boolean updateUserCart(String cartName, String bookId, int number) {
		jedis = jedisPoolInstance.getResource();
		
		//获取该用户购物车信息
		List<Cart> userCart = queryUserCart(cartName);
		
		//遍历用户的购物车
		for(Cart cart : userCart) {
			//如果该书已经在用户的购物车中
			if(cart.getBookId().equals(bookId)){
				//更新缓存中的数量
				Long result = jedis.hset(cartName, bookId,
						String.valueOf(number+cart.getNumber()));	//应该返回0
				
				jedis.close();
				return 0==result?true:false;
			}
		}
		
		//如果该书没有在用户的购物车中
		//更新缓存中的数量
		Long result = jedis.hset(cartName, bookId, String.valueOf(number));	//应该返回1
		
		jedis.close();
		return result==1?true:false;
	}
	
	
	/**
	 * 从用户购物车中删除书
	 */
	@Override
	public boolean deleteCart(String cartName, String bookId) {
		jedis = jedisPoolInstance.getResource();
		
		Long delResult = 0L ;
		int number = 0;
		
		//获取该用户购物车信息
		List<Cart> userCart = queryUserCart(cartName);
		for(Cart cart : userCart) {
			if(bookId.equals(cart.getBookId())) {
				number = cart.getNumber();	//该书在购物车中的数量
				delResult = jedis.hdel(cartName, bookId);
			}
		}
		
		if(delResult==1) {
			//增加书的库存
			Long redisResult = jedis.hincrBy("booksInventory", bookId, number);
			if(redisResult>=0) {
				//更新数据库的信息，将Redis中的库存回写到数据库中
				Book book = new Book();
				book.setBookId(bookId);
				book.setInventory(redisResult.intValue());
				boolean bookResult = bookMapper.updateBookInventoryDao(book);
				
				if(bookResult) {
					jedis.close();
					return true;
				}	
			}
		}
		jedis.close();
		return false;
	}
	
	
	/**
	 * 更新用户购物车中书的数量
	 */
	@Override
	public boolean updateUserCartNumber(String cartName, String bookId, int number ,int afterNumber) {
		jedis = jedisPoolInstance.getResource();
		
		boolean result = false;
		
		//获取Redis中的库存
		int inventory =Integer.parseInt(jedis.hget("booksInventory", bookId));
		//更新购物车中书的数量
		Long hset = jedis.hset(cartName, bookId, String.valueOf(afterNumber));	//应该返回0
		
		if(afterNumber>number) {	//增加图书到购物车
			
			if(inventory>(afterNumber-number)) {	//库存足够
				//减少库存
				Long redisResult = jedis.hincrBy("booksInventory", bookId, -(afterNumber-number));
				
				if(redisResult==inventory-(afterNumber-number)) {
					//更新数据库的信息，将Redis中的库存回写到数据库中
					Book book = new Book();
					book.setBookId(bookId);
					book.setInventory(inventory-(afterNumber-number));
					result = bookMapper.updateBookInventoryDao(book);
				}
			}else {
				System.out.println("图书库存不足");
				jedis.hset(cartName, bookId, String.valueOf(number));	//取消更新购物车中书的数量
				
				jedis.close();
				return false;
			}
			
			if((hset==0) && result) return true;	//当购物车更新成功、数据库回写成功，才返回true
			
			
		}else if(afterNumber<number) {	//从购物车中减少图书
			//增加库存
			Long redisResult = jedis.hincrBy("booksInventory", bookId, -(afterNumber-number));

			if(redisResult==inventory+(number-afterNumber)) {
				//更新数据库的信息，将Redis中的库存回写到数据库中
				Book book = new Book();
				book.setBookId(bookId);
				book.setInventory(inventory+(number-afterNumber));
				result = bookMapper.updateBookInventoryDao(book);
			}
			
			if((hset==0) && result) {
				jedis.close();
				return true;
			}	//当购物车更新成功、数据库回写成功，才返回true
			
		}else {	//数量不变
			jedis.close();
			return true;
		}
		
		jedis.close();
		return false;
	}
	
	
	/**
	 * 加入购物车操作
	 */
	@Override
	public boolean buy(String cartName, String bookId, int number) {
		jedis = jedisPoolInstance.getResource();
		//更新库存
		//获取Redis中的库存
		int inventory =Integer.parseInt(jedis.hget("booksInventory", bookId));
		if(inventory<number) return false;	//库存不够
		
		//更新购物车（更新Redis缓存中图书的数量）
		boolean cartResult = updateUserCart(cartName,bookId,number);
		
		if(cartResult) {
			//减少库存
			Long redisResult = jedis.hincrBy("booksInventory", bookId, -number);
			
			if(redisResult==inventory-number) {
				//更新数据库的信息，将Redis中的库存回写到数据库中
				Book book = new Book();
				book.setBookId(bookId);
				book.setInventory(redisResult.intValue());
				boolean bookResult = bookMapper.updateBookInventoryDao(book);
				
				if(bookResult)	return true;
			}
		}

		return false;
	}
	
	
	/**
	 * 结账操作
	 */
	@Override
	public boolean pay(String id, String address, String payWay) {
		jedis = jedisPoolInstance.getResource();
		
		List<Deal> deals = new ArrayList<Deal>();
		//获取时间
		Calendar cal=Calendar.getInstance();
		int year=cal.get(Calendar.YEAR);      
		int month=cal.get(Calendar.MONTH)+1;      
		int day=cal.get(Calendar.DATE);    
		String time = year+"-"+month+"-"+day;
		
		//获取用户购物车信息
		List<Cart> userCart = queryUserCart("User"+id);
		
		//遍历购物车，生成Deal对象
		for(Cart cart : userCart) {
			String bookId = cart.getBookId();
			int number = cart.getNumber();
			float price = bookMapper.queryBookByBookIdDao(bookId).getPrice();
			Deal deal = new Deal(id, bookId, number, price, time, address, payWay);
			deals.add(deal);
		}
		
		boolean dealResult = false;
		//写入订单表
		for(Deal deal : deals) {
			dealResult = dealMapper.addDealDao(deal);
			if(!dealResult) {
				
				jedis.close();
				return false;
			} 
		}
		
		//清空用户购物车
		Long del = jedis.del("User"+id);
		
		if(dealResult && (del==1)) {
			jedis.close();
			return true;
		} else {
			jedis.close();
			return false;
		}
	}
	
}
