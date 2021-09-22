package com.ssm.service;

import java.util.List;

import com.ssm.pojo.Book;
import com.ssm.pojo.Deal;

public interface DealService {

	//添加订单
	boolean addDeal(Deal deal);
	
	//查询所有订单
	List<Deal> queryAllDeals();
	
	//查询用户订单
	List<Deal> queryUserDeal(String id);
	
	//根据账户、编号、时间、地址模糊查询订单
	List<Deal> searchUserDeal(Deal deal);
	
	//查询所有图书销售信息
	List<Book> queryAllBookSaleInfo();

	//查询图书销售信息
	Book queryBookSaleInfo(String bookId);
	
}
