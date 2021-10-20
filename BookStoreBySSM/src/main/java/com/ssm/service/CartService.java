package com.ssm.service;

import java.util.List;

import com.ssm.pojo.Cart;

public interface CartService {
	
	//创建用户购物车表
//	void createUserCart(String tableName);
	
	//查询用户购物车信息
	List<Cart> queryUserCart(String tableName);
	
	//更新用户购物车信息
	boolean updateUserCart(String tableName, String bookId, int number);

	//从用户购物车中删除书
	boolean deleteCart(String tableName, String bookId);
	
	//删除用户购物车表
//	void deleteUserCart(String tableName);
	
	//更新用户购物车中书的数量
	public boolean updateUserCartNumber(String id, String bookId, int number ,int afterNumber);

	//加入购物车
	boolean buy(String tableName, String bookId, int number);

	//结账
	boolean pay(String id, String address, String payWay);
	
}
