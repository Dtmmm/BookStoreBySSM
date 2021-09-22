package com.ssm.service;

import java.util.List;

import com.ssm.pojo.User;

public interface UserService {
	
	//查询所有用户
	public List<User> queryAllUsers();
	
	//根据id查询用户
	public User queryUserById(String id);
	
	//添加用户
	public boolean addUser(User user);
	
	//修改用户
	public boolean updateUser(User user);
	
	//删除用户
	public boolean deleteUser(String id);
	
	//登录功能
	public boolean login(User user);
	
	//注册功能
	public boolean register(User user);
	
}
