<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.pojo.User"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理员页面</title>
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
    #userManager a{
    	color:#fff;
    	background:#b63b4d;
    }
    
   .title{
		font-size:50px;
		color:#fff;
		border-bottom:5px solid #b63b4d;
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
		margin:50px 0px 0px 350px;
		width:1000px;
	}
	#info b{
		color:#b63b4d;
	}
	#info a{
		background-color: #b63b4d;
		color:#fff;
		padding: 2px;
		border: 1px solid #b63b4d;
		border-radius: 5px;
	}
	#info a:hover {
		background-color:#983947;
		border-color: #983947;
		text-decoration: none;
	}
</style>
</head>

<body class="easyui-layout">
	<!-- 顶部 -->
	<div data-options="region:'north'" style="height:80px">
		<img class="logo" alt="图片丢失" src="../imgs/logo2.png" style="width:300px;height:68px;margin-left:100px;"/>
	</div>
	
	<!-- 侧面 -->
	<div data-options="region:'west',title:' '" style="width:180px;">
		<%
			@SuppressWarnings("unchecked")
			List<User> allUsers = (List<User>) request.getAttribute("allUsers");
		%>
		
		
		<div id="Vnavigation">
		    <ul>
		    	<li><img alt="图片丢失" src="../imgs/user.png" width="100" height="120" style="margin-top:50px;"/></li>
		    	<li><p id="name" >管理员</p></li>
		    	<li><br></li>
		    	<li><p id="reLogin" ><a href="../views/Login.jsp">重新登录</a></p></li>
		    	<li><p id="userManager"><a href="../userController/queryAllUsers">用户管理</a></p></li>
		    	<li><p id="bookManager"><a href="../bookController/queryAllBooks">商品管理</a></p></li>
		    	<li><p id="dealManager"><a href="../dealController/queryAllDeals">订单管理</a></p></li>
		    	<li><p id="announcementManager"><a href="../announcementController/queryAllAnnouncements">公告管理</a></p></li>
		    	<li><p id="bookSaleInfos"><a href="../dealController/queryAllBookSaleInfo">商品销售信息</a></p></li>
	    	</ul>
		</div>
	</div>
	
	<!-- 主体 -->
	<div data-options="region:'center'">
		<div class="title">
			<p style="width:220px;">用户管理</p>
		</div>
			<p id="returnHome"><a href="../views/Manager.jsp">返回首页</a></p>
		
	    <div id="info">
	    	<ul class="easyui-datalist" title="用户信息" style="width:1000px;height:600px;">
	    	<%
	            for(User user : allUsers){
	            	String id = user.getId();
	            	String userName = user.getUserName();
	            	String userPassword = user.getUserPassword();
	            	String address = user.getAddress();
	        %>
	    		<li>
	        		<span id="id">账号:<b><%= id %></b></span>&emsp;
	        		<span id="userName">用户名:<b><%= userName %></b></span>&emsp;
	        		<span id="userPassword">密码:<b><%= userPassword %></b></span>&emsp;
	        		<span id="address">收货地址:<b><%= address %></b></span>&emsp;
	        		<span id="deleteUser"><a href="../userController/deleteUser?id=<%= id %>">删除该用户</a></span>
	    		</li>
	    	<%
	            }
	        %>
	    	</ul>
	    </div>
    </div>
	      
	    
	    
</body>
</html>