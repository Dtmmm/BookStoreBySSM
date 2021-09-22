package com.ssm.mapper;

import java.util.List;

import com.ssm.pojo.Deal;

public interface DealMapper {

	//添加订单
	boolean addDealDao(Deal deal);
	
	//查询所有订单
	List<Deal> queryAllDealsDao();
	
	//查询用户订单
	List<Deal> queryUserDealDao(String id);
	
	//根据账户、编号、时间、地址模糊查询订单
	List<Deal> searchUserDealDao(Deal deal);
	
	//查询图书销售信息
	List<Deal> queryBookSaleInfoDao(String bookId);
	
	
}
