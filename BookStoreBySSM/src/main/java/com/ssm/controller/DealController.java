package com.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssm.pojo.Book;
import com.ssm.pojo.Deal;
import com.ssm.service.DealService;

@Controller("dealController")
@RequestMapping("/dealController")
public class DealController {
	//生成service层对象
	@Autowired
	@Qualifier("dealService")
	private DealService dealService;
	
	
	//查询所有订单
	@RequestMapping("/queryAllDeals")
	public String queryAllDeals(Model model){
		List<Deal> allDeals = dealService.queryAllDeals();
		model.addAttribute("allDeals", allDeals);
		return "DealManager";
	}
	
	
	//查询用户订单
	@RequestMapping("/queryUserDeal")
	public String queryUserDeal(@RequestParam("id") String id, Model model){
		List<Deal> userDeals = dealService.queryUserDeal(id);
		model.addAttribute("userDeals", userDeals);
		return "UserDeal";
	}
	
	
	//根据账户、编号、时间、地址模糊查询订单
	@RequestMapping("/searchUserDeal")
	public String searchUserDeal(
			@RequestParam("id") String id, 
			@RequestParam("bookId") String bookId, 
			@RequestParam("time") String time, 
			@RequestParam("address") String address, Model model){
		//封装模糊查询的条件
		Deal deal = new Deal();
		deal.setId(id);
		deal.setBookId(bookId);
		deal.setTime(time);
		deal.setAddress(address);
		
		List<Deal> searchedDeal = dealService.searchUserDeal(deal);
		model.addAttribute("allDeals", searchedDeal);
		return "DealManager";
	}
	
	
	//查询所有图书销售信息
	@RequestMapping("/queryAllBookSaleInfo")
	public String queryAllBookSaleInfo(Model model){
		List<Book> allBookSaleInfos = dealService.queryAllBookSaleInfo();
		model.addAttribute("allBookSaleInfos", allBookSaleInfos);
		//标志(true:所有书  false:某本书)
		boolean flag = true;
		model.addAttribute("flag", flag);
		
		return "BookSaleInfos";
	}
	
	//查询图书销售信息
	@RequestMapping("/queryBookSaleInfo")
	public String queryBookSaleInfo(@RequestParam("bookId")String bookId, Model model){
		Book bookTotalSaleNumber = dealService.queryBookSaleInfo(bookId);
		model.addAttribute("bookTotalSaleNumber", bookTotalSaleNumber);
		//标志(true:所有书  false:某本书)
		boolean flag = false;
		model.addAttribute("flag", flag);
		
		return "BookSaleInfos";
	}
	
	
}
