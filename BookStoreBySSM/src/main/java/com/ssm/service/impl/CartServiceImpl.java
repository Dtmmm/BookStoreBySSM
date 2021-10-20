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
	Jedis jedis = jedisPoolInstance.getResource();
	
	
	/**
	 * 创建用户购物车表
	 */
	@Override
	public void createUserCart(String tableName) {
		cartMapper.createUserCartDao(tableName);
	}
	
	
	/**
	 * 查询用户购物车信息
	 */
	@Override
	public List<Cart> queryUserCart(String tableName) {
		List<Cart> userCart = new ArrayList<Cart>();
		
		//从Redis中获取所有的bookId
		Set<String> hkeys = jedis.hkeys(tableName);
		if( (null!=hkeys) && (!hkeys.isEmpty()) ) {
			for(String bookId : hkeys) {	//取出每本书对应的数量
				int number = Integer.parseInt(jedis.hget(tableName, bookId));
				
				userCart.add(new Cart(bookId,number));
			}
		}
		return userCart;
	}
	
	
	/**
	 * 更新用户购物车信息
	 */
	@Override
	public boolean updateUserCart(String tableName, String bookId, int number) {
		//获取该用户购物车信息
		List<Cart> userCart = queryUserCart(tableName);
		
		//遍历用户的购物车
		for(Cart cart : userCart) {
			//如果该书已经在用户的购物车中
			if(cart.getBookId().equals(bookId)){
				//更新缓存中的数量
				Long result = jedis.hset(tableName, bookId,
						String.valueOf(number+cart.getNumber()));	//应该返回0

				return 0==result?true:false;
			}
		}
		
		//如果该书没有在用户的购物车中
		//更新缓存中的数量
		Long result = jedis.hset(tableName, bookId, String.valueOf(number));	//应该返回1
		
		return result==1?true:false;
	}
	
	
	/**
	 * 从用户购物车中删除书
	 */
	@Override
	public boolean deleteCart(String tableName, String bookId) {
		Long result1 = 0L ;
		boolean result2 = false;
		int number = 0;
		
		//获取该用户购物车信息
		List<Cart> userCart = queryUserCart(tableName);
		for(Cart cart : userCart) {
			if(bookId.equals(cart.getBookId())) {
				number = cart.getNumber();	//该书在购物车中的数量
				result1 = jedis.hdel(tableName, bookId);
			}
		}
		
		//增加书的库存
		if(result1==1) {
			int inventory = bookMapper.queryBookByBookIdDao(bookId).getInventory();
			Book book = new Book();
			book.setBookId(bookId);
			book.setInventory(inventory+number);
			result2 = bookMapper.updateBookInventoryDao(book);
		}
		return result2;
	}
	
	
	/**
	 * 更新用户购物车中书的数量
	 */
	@Override
	public boolean updateUserCartNumber(String tableName, String bookId, int number ,int afterNumber) {
		boolean result = false;
		
		if(afterNumber>number) {	//增加图书到购物车
			//更新购物车中书的数量
			Long hset = jedis.hset(tableName, bookId, String.valueOf(afterNumber));	//应该返回0
			
			//更新书的库存
			int inventory = bookMapper.queryBookByBookIdDao(bookId).getInventory();
			if(inventory>(afterNumber-number)) {
				Book book = new Book();
				book.setBookId(bookId);
				book.setInventory(inventory-(afterNumber-number));
				result = bookMapper.updateBookInventoryDao(book);
			}else {
				System.out.println("图书库存不足");
				return false;
			}
			
			if((hset==0) && result) return true;
			else return false;
			
		}else if(afterNumber<number) {	//从购物车中减少图书
			//更新购物车中书的数量
			Long hset = jedis.hset(tableName, bookId, String.valueOf(afterNumber));	//应该返回0

			//更新书的库存
			int inventory = bookMapper.queryBookByBookIdDao(bookId).getInventory();
			Book book = new Book();
			book.setBookId(bookId);
			book.setInventory(inventory+(number-afterNumber));
			result = bookMapper.updateBookInventoryDao(book);
			
			if((hset==0) && result) return true;
			else return false;
			
		}else {	//数量不变
			return true;
		}
	}
	
	
	/**
	 * 加入购物车操作
	 */
	@Override
	public boolean buy(String tableName, String bookId, int number) {
		boolean cartResult = false;
		boolean bookResult = false;
		
		//更新购物车
		cartResult = updateUserCart(tableName,bookId,number);
		
		//更新库存
		int inventory = bookMapper.queryBookByBookIdDao(bookId).getInventory();
		if(inventory>=number) {
			Book book = new Book();
			book.setBookId(bookId);
			book.setInventory(inventory-number);
			bookResult = bookMapper.updateBookInventoryDao(book);
		}
		
		if(cartResult&&bookResult) return true;
		else return false;
	}
	
	
	/**
	 * 结账操作
	 */
	@Override
	public boolean pay(String id, String address, String payWay) {
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
				return false;
			} 
		}
		
		//清空用户购物车
		Long del = jedis.del("User"+id);
		
		if(dealResult && (del==1)) return true;
		else return false;
	}
	
	
	/**
	 * 删除用户购物车表
	 */
	@Override
	public void deleteUserCart(String tableName) {
		cartMapper.deleteUserCartDao(tableName);
	}
	
	
	
}
