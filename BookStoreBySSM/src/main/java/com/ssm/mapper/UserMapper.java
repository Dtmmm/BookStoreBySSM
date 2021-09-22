package com.ssm.mapper;

import java.util.List;

import com.ssm.pojo.User;

public interface UserMapper {
	
	//查询所有用户
	public List<User> queryAllUsersDao();
	
	//根据id查询用户
	public User queryUserByIdDao(String id);
	
	//添加用户
	public boolean addUserDao(User user);
	
	//修改用户
	public boolean updateUserDao(User user);
	
	//删除用户
	public boolean deleteUserDao(String id);
	
}
