<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.service.impl.UserServiceImpl"%>
<%@ page import="com.ssm.service.impl.BookServiceImpl"%>
<%@ page import="com.ssm.pojo.Deal"%>
<%@ page import="com.ssm.pojo.Book"%>
<%@ page import="com.ssm.pojo.User"%>
<%@ page import="java.util.List"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的订单</title>
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
    #userDeal a{
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
	
	#deals{
		margin:40px 0px 0px 50px;
	}
	#deals b{
		color:#b63b4d;
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
			String id = (String)session.getAttribute("id");
			session.setAttribute("id", id);
			//获取Ioc容器
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
			//获取UserServiceImpl的Bean对象
			UserServiceImpl userService = (UserServiceImpl)ctx.getBean("userService");
			
			User user = userService.queryUserById(id);
		%>
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
			<p style="width:230px;">我的订单</p>
		</div>
			<p id="returnHome"><a href="../views/HomePage.jsp">返回首页</a></p>
			
		<div id="deals">
			<ul  class="easyui-datalist" title="订单" style="width:1600px;height:600px;">
				<%
					//获取UserServiceImpl的Bean对象
					BookServiceImpl bookService = (BookServiceImpl)ctx.getBean("bookService");
				
					@SuppressWarnings("unchecked") 
					List<Deal> userDeals = (List<Deal>)request.getAttribute("userDeals");
					if(userDeals==null||userDeals.isEmpty()){
				%>
						<li>你还没有过订单,<a href="HomePage.jsp">点我返回首页</a></li>
				<%
					}else{
						for(Deal deal : userDeals){
				    		String bookId = deal.getBookId();
				    		int number = deal.getNumber();
				    		float price = deal.getPrice();
				    		String time = deal.getTime();
				    		String address = deal.getAddress();
				    		String payWay = deal.getPayWay();
				    		
				    		//排除书被删除后,无法根据id在Books表里查到书名的bug
				    		String bookName = "无" ;
				    		Book book = bookService.queryBookByBookId(bookId);
				    		if(book!=null)	bookName = book.getBookName();
				    		
				%>
					<li>
		        		<span id="bookId">序列号:<b><%= bookId %></b></span>&emsp;
		        		<span id="bookName">书名:<b><%= "《"+bookName+"》" %></b></span>&emsp;
		        		<span id="number">数量:<b><%= number %></b></span>&emsp;
		        		<span id="price">价格:<b><%= price %></b></span>&emsp;
		        		<span id="time">交易时间:<b><%= time %></b></span>&emsp;
		        		<span id="address">收货地址:<b><%= address %></b></span>&emsp;
		        		<span id="payWay">付款方式:<b><%= payWay %></b></span>
		    		</li>	
	    		<%
	            		}
					}
	       		%>
			</ul>
		</div>
	</div>
	
</body>
</html>