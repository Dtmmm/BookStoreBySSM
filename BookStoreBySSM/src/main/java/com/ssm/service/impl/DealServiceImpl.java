package com.ssm.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssm.mapper.BookMapper;
import com.ssm.mapper.DealMapper;
import com.ssm.pojo.Book;
import com.ssm.pojo.Deal;
import com.ssm.service.DealService;

@Service("dealService")
public class DealServiceImpl implements DealService{
	//生成dao层对象
	@Autowired
	@Qualifier("dealMapper")
	private DealMapper dealMapper;
	
	@Autowired
	@Qualifier("bookMapper")
	private BookMapper bookMapper;
	
	
	//添加订单
	@Override
	public boolean addDeal(Deal deal) {
		boolean result = dealMapper.addDealDao(deal);
		return result;
	}
	
	//查询所有订单
	@Override
	public List<Deal> queryAllDeals() {
		List<Deal> allDeals = dealMapper.queryAllDealsDao();
		return allDeals;
	}
	
	//查询用户订单
	@Override
	public List<Deal> queryUserDeal(String id) {
		List<Deal> deals = dealMapper.queryUserDealDao(id);
		return deals;
	}
	
	//根据账户、编号、时间、地址模糊查询订单
	@Override
	public List<Deal> searchUserDeal(Deal deal) {
		List<Deal> dels = dealMapper.searchUserDealDao(deal);
		return dels;
	}
	
	//查询所有图书销售信息
	@Override
	public List<Book> queryAllBookSaleInfo() {
		List<Book> allBooks = bookMapper.queryAllBooksDao();
		List<Book> allBookTotalSaleNumbers = new ArrayList<Book>();
		
		for(Book book : allBooks) {
			//总销售价
  			int totalSaleNumber = 0;
  			List<Deal> bookSaleInfos = dealMapper.queryBookSaleInfoDao(book.getBookId());
  			for(Deal deal : bookSaleInfos) {
  				totalSaleNumber = totalSaleNumber + deal.getNumber();
  			}
  			Book bookTotalSaleNumber = new Book();
  			bookTotalSaleNumber.setBookId(book.getBookId());
  			bookTotalSaleNumber.setTotalSaleNumber(totalSaleNumber);
  			
  			allBookTotalSaleNumbers.add(bookTotalSaleNumber);
  		}
  		return allBookTotalSaleNumbers;
	}
	
	//查询图书销售信息
	@Override
  	public Book queryBookSaleInfo(String bookId) {
  		//总销售价
  		int totalSaleNumber = 0;
  		List<Deal> bookSaleInfos = dealMapper.queryBookSaleInfoDao(bookId);
  		if(bookSaleInfos.isEmpty()||bookSaleInfos==null) return null;
  		for(Deal deal : bookSaleInfos) {
  			totalSaleNumber = totalSaleNumber + deal.getNumber();
  		}
  		Book bookTotalSaleNumber = new Book();
		bookTotalSaleNumber.setBookId(bookId);
		bookTotalSaleNumber.setTotalSaleNumber(totalSaleNumber);
  		return bookTotalSaleNumber;
  	}
	
		
}
