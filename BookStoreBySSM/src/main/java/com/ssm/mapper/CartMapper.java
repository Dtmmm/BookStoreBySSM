package com.ssm.mapper;

import java.util.List;

import com.ssm.pojo.Cart;

public interface CartMapper {
	
	//创建用户购物车表
	void createUserCartDao(String tableName);
	
	//查询用户购物车信息
	List<Cart> queryUserCartDao(String tableName);
	
	//更新用户购物车信息：当用户购物车中已经有该书时,改变用户购物车中书的数量
	boolean updateCartDao(Cart cart);
	
	//更新用户购物车信息：当用户购物车中没有该书时,向用户购物车中增加书
	boolean insterCartDao(Cart cart);
	
	//从用户购物车中删除书
	boolean deleteCartDao(Cart cart);
	
	//清空用户购物车
	boolean clearCartDao(String tableName);
	
	//删除用户购物车表
	void deleteUserCartDao(String tableName);
	
}
