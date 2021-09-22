package com.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssm.pojo.Cart;
import com.ssm.service.CartService;

@Controller("cartController")
@RequestMapping("/cartController")
public class CartController {
	//生成service层对象
	@Autowired
	@Qualifier("cartService")
	private CartService cartService;
	
	
	//查询用户购物车信息
	@RequestMapping("/queryUserCart")
	public String queryUserCart(@RequestParam("tableName") String tableName, Model model) {
		List<Cart> userCart = cartService.queryUserCart(tableName);
		model.addAttribute("userCart", userCart);
		return "UserCart";
	}
	
	
	//加入购物车
	@RequestMapping("/buy")
	public String buy(
			@RequestParam("id") String id, 
			@RequestParam("bookId") String bookId, 
			@RequestParam("number") int number, Model model) {
		
		if(id.equals("null")) {
			return "NeedLogin";
		}else {
			boolean result = cartService.buy("User"+id, bookId, number);
			if(result) return "JoinCartSuccess";
		}
		
		return "JoinCartFalse";
	}
	
	
	//从用户购物车中删除书
	@RequestMapping("/deleteCart")
	public String deleteCart(
			@RequestParam("tableName") String tableName, 
			@RequestParam("bookId") String bookId, Model model) {
		
		boolean result = cartService.deleteCart(tableName, bookId);
		if(result) {
			List<Cart> userCart = cartService.queryUserCart(tableName);
			model.addAttribute("userCart", userCart);
			return "UserCart";
		}
		return "error";
	}
	
	
	//更新用户购物车中书的数量
	@RequestMapping("/updateUserCartNumber")
	public String updateUserCartNumber(
			@RequestParam("id") String id, 
			@RequestParam("bookId") String bookId, 
			@RequestParam("number") int number, 
			@RequestParam("afterNumber") int afterNumber, Model model) {
		String tableName = "User"+id;
		boolean result = cartService.updateUserCartNumber(tableName, bookId, number, afterNumber);
		if(result) {
			List<Cart> userCart = cartService.queryUserCart(tableName);
			model.addAttribute("userCart", userCart);
			return "UserCart";
		}
		return "error";
	}
	
	
	//结账
	@RequestMapping("/pay")
	public String pay(
			@RequestParam("id") String id, 
			@RequestParam("address") String address, 
			@RequestParam("payWay") String payWay, Model model) {
		
		boolean result = cartService.pay(id, address, payWay);
		if(result) return "PaySuccess";
		return "error";
	}
	
	
}
