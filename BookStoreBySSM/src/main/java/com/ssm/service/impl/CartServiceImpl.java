package com.ssm.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssm.mapper.BookMapper;
import com.ssm.mapper.CartMapper;
import com.ssm.mapper.DealMapper;
import com.ssm.pojo.Book;
import com.ssm.pojo.Cart;
import com.ssm.pojo.Deal;
import com.ssm.service.CartService;

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
	
	
	//创建用户购物车表
	@Override
	public void createUserCart(String tableName) {
		cartMapper.createUserCartDao(tableName);
	}
	
	
	//查询用户购物车信息
	@Override
	public List<Cart> queryUserCart(String tableName) {
		List<Cart> userCart = cartMapper.queryUserCartDao(tableName);
		return userCart;
	}
	
	
	//更新用户购物车信息
	@Override
	public boolean updateUserCart(String tableName, String bookId, int number) {
		//获取该用户购物车信息
		List<Cart> userCart = cartMapper.queryUserCartDao(tableName);
		//遍历用户的购物车
		for(Cart cart : userCart) {
			//如果该书已经在用户的购物车中
			if(cart.getBookId().equals(bookId)){
				//封装更新的信息
				Cart newCart = new Cart(bookId, number+cart.getNumber(), tableName);
				
				boolean result = cartMapper.updateCartDao(newCart);
				return result;
			}
		}
		//如果该书没有在用户的购物车中
		//封装更新的信息
		Cart newCart = new Cart(bookId, number, tableName);
		boolean result = cartMapper.insterCartDao(newCart);
		return result;
	}
	
	
	//从用户购物车中删除书
	@Override
	public boolean deleteCart(String tableName, String bookId) {
		boolean result1 = false;
		boolean result2 = false;
		int number = 0;
		
		List<Cart> userCart = cartMapper.queryUserCartDao(tableName);
		for(Cart cart : userCart) {
			if(bookId.equals(cart.getBookId())) {
				number = cart.getNumber();
				//封装删除条件
				Cart cartCondition = new Cart();
				cartCondition.setBookId(bookId);
				cartCondition.setTableName(tableName);
				//从购物车中删除书
				result1 = cartMapper.deleteCartDao(cartCondition);
			}
		}
		
		//增加书的库存
		if(result1) {
			int inventory = bookMapper.queryBookByBookIdDao(bookId).getInventory();
			Book book = new Book();
			book.setBookId(bookId);
			book.setInventory(inventory+number);
			result2 = bookMapper.updateBookInventoryDao(book);
		}
		
		return result2;
	}
	
	
	//更新用户购物车中书的数量
	@Override
	public boolean updateUserCartNumber(String tableName, String bookId, int number ,int afterNumber) {
		boolean result1 = false;
		boolean result2 = false;
		
		if(afterNumber>number) {//增加图书到购物车
			//更新购物车中书的数量
			Cart cart = new Cart(bookId, afterNumber, tableName);
			result1 = cartMapper.updateCartDao(cart);
			//更新书的库存
			int inventory = bookMapper.queryBookByBookIdDao(bookId).getInventory();
			if(inventory>(afterNumber-number)) {
				Book book = new Book();
				book.setBookId(bookId);
				book.setInventory(inventory-(afterNumber-number));
				result2 = bookMapper.updateBookInventoryDao(book);
			}else {
				System.out.println("图书库存不足");
				return false;
			}
			
			if(result1==true&&result2==true) return true;
			else return false;
			
		}else if(afterNumber<number) {//从购物车中减少图书
			//更新购物车中书的数量
			Cart cart = new Cart(bookId, afterNumber, tableName);
			result1 = cartMapper.updateCartDao(cart);
			//更新书的库存
			int inventory = bookMapper.queryBookByBookIdDao(bookId).getInventory();
			Book book = new Book();
			book.setBookId(bookId);
			book.setInventory(inventory+(number-afterNumber));
			result2 = bookMapper.updateBookInventoryDao(book);
			
			if(result1==true&&result2==true) return true;
			else return false;
			
		}else {//数量不变
			return true;
		}
	}
	
	//加入购物车
	@Override
	public boolean buy(String tableName, String bookId, int number) {
		boolean cartResult = false;
		boolean bookResult = false;
		
		//更新购物车
		cartResult = updateUserCart(tableName,bookId,number);
		//更新库存
		int inventory = bookMapper.queryBookByBookIdDao(bookId).getInventory();
		if(inventory>number) {
			Book book = new Book();
			book.setBookId(bookId);
			book.setInventory(inventory-number);
			bookResult = bookMapper.updateBookInventoryDao(book);
		}
		
		if(cartResult&&bookResult) return true;
		else return false;
	}
	
	//结账
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
		List<Cart> userCart = cartMapper.queryUserCartDao("User"+id);
		
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
		boolean cartResult = cartMapper.clearCartDao("User"+id);
		
		if(dealResult&&cartResult) return true;
		else return false;
	}
	
	
	
	//删除用户购物车表
	@Override
	public void deleteUserCart(String tableName) {
		cartMapper.deleteUserCartDao(tableName);
	}
	
	
	
}
