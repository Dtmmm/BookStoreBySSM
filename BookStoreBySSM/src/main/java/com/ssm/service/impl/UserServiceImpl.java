package com.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssm.mapper.CartMapper;
import com.ssm.mapper.UserMapper;
import com.ssm.pojo.User;
import com.ssm.service.UserService;
import com.ssm.util.JedisPoolUtil;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;


@Service("userService")
public class UserServiceImpl implements UserService{
	//生成dao层对象
	@Autowired
	@Qualifier("userMapper")
	private UserMapper userMapper;
	
	@Autowired
	@Qualifier("cartMapper")
	private CartMapper cartMapper;
	
	
	//查询所有用户
	@Override
	public List<User> queryAllUsers() {
		List<User> allUsers = userMapper.queryAllUsersDao();
		return allUsers;
	}
	
	//根据id查询用户
	@Override
	public User queryUserById(String id) {
		User user = userMapper.queryUserByIdDao(id);
		return user;
	}
	
	//添加用户
	@Override
	public boolean addUser(User user) {
		boolean result = userMapper.addUserDao(user);
		return result;
	}
	
	//删除用户和用户购物车表
	//遗留一个问题：删除用户购物车表后，没有将购物车中的书数量还回给库存
	@Override
	public boolean deleteUser(String id) {
		boolean result = userMapper.deleteUserDao(id);
		if(result) {
			//通过连接池得到jedis对象
			JedisPool jedisPoolInstance = JedisPoolUtil.getJedisPoolInstance();
			Jedis jedis = jedisPoolInstance.getResource();
			Long del = jedis.del("User"+id);
			if(del==1) {return true;}
		}
		return false;
	}
	
	//修改用户
	@Override
	public boolean updateUser(User user) {
		boolean result = userMapper.updateUserDao(user);
		return result;
	}
	
	//登录功能
	@Override
	public boolean login(User user) {
		//从数据库中查询用户信息
		User DBuser = userMapper.queryUserByIdDao(user.getId());
		//如果存在该用户且密码正确
		if(DBuser!=null&&DBuser.getUserPassword().equals(user.getUserPassword())) {
			return true;
		}
		return false;
	}
	
	//注册功能
	@Override
	public boolean register(User user) {
		//从数据库中查询用户信息
		User DBuser = userMapper.queryUserByIdDao(user.getId());
		//如果还没有用户
		if(DBuser==null) {
			//注册用户
			boolean registerResult = userMapper.addUserDao(user);
			return registerResult;
		}
		return false;
	}
	
}
