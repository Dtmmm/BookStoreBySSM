package com.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.ssm.pojo.User;
import com.ssm.service.UserService;

@Controller("userController")
@RequestMapping("/userController")
@SessionAttributes(value = "id")
public class UserController {
	//生成service层对象
	@Autowired
	@Qualifier("userService")
	private UserService userService;
	
	
	//查询所有用户
	@RequestMapping("/queryAllUsers")
	public String queryAllUsers(Model model) {
		List<User> allUsers = userService.queryAllUsers();
		model.addAttribute("allUsers", allUsers);
		return "UserManager";
	}
	
	
	//根据id查询用户
	@RequestMapping("/queryUserById")
	public String queryUserById(@RequestParam("id") String id, Model model) {
		User user = userService.queryUserById(id);
		model.addAttribute("user", user);
		return "UpdateUserInfo";
	}
	
	
	//修改用户
	@RequestMapping("/updateUser")
	//使用Spring的自动绑定入参，将前端的值自动绑定到user中
	public String updateUser(User user, Model model) {
		boolean result = userService.updateUser(user);
		if(result) {
			User updatedUser = userService.queryUserById(user.getId());
			model.addAttribute("user", updatedUser);
			return "UpdateUserInfo";
		}
		return "error";
	}
	
	
	//删除用户和用户购物车表
	@RequestMapping("/deleteUser")
	public String deleteUser(@RequestParam("id") String id, Model model) {
		boolean result = userService.deleteUser(id);
		if(!result)  System.out.println("删除失败，该用户已有相关订单信息");
		return "redirect:queryAllUsers";
	}
	
	
	//登录功能
	@RequestMapping("/login")
	//使用Spring的自动绑定入参，将前端的值自动绑定到user中
	public String login(User user, Model model) {
		boolean loginResult = userService.login(user);
		model.addAttribute("loginResult", loginResult);
		if(loginResult) {
			model.addAttribute("id", user.getId());
			
			if(user.getId().equals("000")) return "Manager";
			else return "HomePage";
		}else {
			model.addAttribute("loginMes", "登录失败，账户或密码错误");
			return "Login";
		}
	}
	
	
	//注册功能
	@RequestMapping("/register")
	//使用Spring的自动绑定入参，将前端的值自动绑定到user中
	public String register(User user, Model model) {
		boolean registerResult = userService.register(user);
		model.addAttribute("registerResult", registerResult);
		if(registerResult) {
			return "Login";
		}else {
			model.addAttribute("registerMes", "注册失败，该用户已存在");
			return "Register";
		}
		
	}
	
	
	//退出登录（从session域中删除用户）
	@RequestMapping("/logout")
	public String logout(SessionStatus status) {
		// 清除当前处理器通过@SessionAttribute注册的session属性
		status.setComplete();
		return "HomePage";
	}
	
}
