<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.service.impl.UserServiceImpl"%>
<%@ page import="com.ssm.pojo.User"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<%	User user = (User) request.getAttribute("user");
		String id = user.getId();
	%>
<title><%= user.getUserName() %></title>
<!-- 布局 -->
	<link href="../EasyUI/themes/default/easyui.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="../EasyUI/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../EasyUI/demo.css">
	<script src="../EasyUI/jquery.min.js" type="text/javascript"></script>
	<script src="../EasyUI/jquery.easyui.min.js" type="text/javascript"></script>
<!-- 清除边距,设置默认格式 -->
	<link rel="stylesheet" type="text/css" href="../css/DefaultStyle.css">
<!-- 侧面导航栏 -->
	<link rel="stylesheet" type="text/css" href="../css/VnavigationStyle.css">
<style type="text/css">
	#userInfo a{
    	color:#fff;
    	background:#b63b4d;
    }
	.title{
		font-size:50px;
		color:#fff;
		border-bottom:5px solid #b63b4d;
		width:1740px;
		margin:0px auto;
	}
	.title p{
		margin:50px 0px 0px 130px;
		width:210px;
		border:3px solid #b63b4d;
		border-top-left-radius:10px;
		border-top-right-radius:10px;
		text-align: center;
		background-color: #b63b4d;
	}
	
	#returnHome{
		margin:0px 0px 0px 1500px;
		width:115px;
		border:3px solid #b63b4d;
		border-bottom-left-radius:10px;
		border-bottom-right-radius:10px;
		text-align: center;
		background-color: #b63b4d;
		font-size:25px;
		color:#fff;
	}
	#returnHome a{
		color:#fff;
		text-decoration: none;
	}
	#returnHome:hover{
		background-color:#983947;
		border-color: #983947;
	}
	
	
	#info{
		display:block;
		width:1200px;
		margin:50px auto;
		border:3px solid #b63b4d;
		border-radius:10px;
	}
	#info p{
		padding: 20px;
		font-size: 30px;
		
	}
	#info input:not(#submit){
        border:0px;
        width:1000px;
		height:50px;
		font-size: 30px;
		border-bottom:2px solid #b63b4d;
	}
	#info input:focus{ 
		outline: none; 
	}
	#info #submit{
		display:block;
		margin:0px auto;
		width:300px;
		height:50px;
		background-color: #b63b4d;
		color:#fff;
		font-size: 25px;
		border-bottom:2px solid #b63b4d;
		border-radius: 10px;
	}
</style>
</head>
<body  class="easyui-layout">
	<!-- 顶部 -->
	<div data-options="region:'north'" style="height:80px">
		<img class="logo" alt="图片丢失" src="../imgs/logo2.png" style="width:300px;height:75px;margin-left:100px;"/>
	</div>	
	 
	<!-- 侧面 -->
	<div data-options="region:'west',title:' '" style="width:180px;">
		<div id="Vnavigation">
		    	<ul>
		    		<li><img alt="图片丢失" src="../imgs/user.png" width="100" height="120" style="margin-top:50px;"/></li>
		    		<li><p id="name" ><%= user.getUserName() %></p></li>
		    		<li><br></li>
		    		<li><p id="reLogin" ><a href="../views/Login.jsp">重新登录</a></p></li>
		    		<li><p id="reLogin" ><a href="../userController/logout">退出登录</a></p></li>
		    		<li><p id="userCart"><a href="../cartController/queryUserCart?tableName=<%= "User"+id %>">我的购物车</a></p></li>
		    		<li><p id="userInfo"><a href="../userController/queryUserById?id=<%= id %>">我的信息</a></p></li>
		    		<li><p id="userDeal"><a href="../dealController/queryUserDeal?id=<%= id %>">我的订单</a></p></li>
		    	</ul>
		</div>
	</div>
	 
	<!-- 主体 -->
	<div data-options="region:'center'"> 

		<div class="title">
			<p style="width:230px;">我的信息</p>
		</div>
			<p id="returnHome"><a href="../views/HomePage.jsp">返回首页</a></p>
		 
		 <div id="info">
		 	<form action="../userController/updateUser" method="post">
			 	<p>账号:<input type="text" name="id" value=<%= user.getId() %>  readonly="readonly" /></p>
			 	<p>用户名:<input type="text" name="userName" value=<%= user.getUserName() %>  required="required" pattern="^[A-Za-z\u4e00-\u9fa5\1-9]*$" title="用户名为汉字、英文字母和数字的组合"/></p>
			 	<p>密码:<input type="text" name="userPassword" value=<%= user.getUserPassword() %>  required="required" pattern="^\d{4}$" title="密码为四位非负数字" /></p>
			 	<p>收货地址:<input type="text" name="address" value=<%= user.getAddress() %>  required="required" pattern="^[A-Za-z\u4e00-\u9fa5]*$" title="收货地址为汉字、英文字母的组合"/></p>
			 	<p><input type="submit" id="submit" value="修改" /></p>
		 	</form>
		 </div>
	 </div>
</body>
</html>