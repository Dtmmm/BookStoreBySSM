<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.pojo.Deal"%>
<%@ page import="java.util.List"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
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
    #dealManager a{
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
	
	
	#search{
		margin:30px auto;
		text-align: center;
	}
	#search input:focus { 
		outline: none; 
	}
	#search input:not(#submit){
		padding-top:5px;
		border:2px solid #b63b4d;
		width:150px;
		height:30px;
	}	
	#search #submit{
		border:1px solid #b63b4d;
		border-radius:5px;
		background-color: #b63b4d;
		font-size:23px;
		color:#fff;
		padding: 3px;
	}
	
	
    #info{
		margin:10px 0px 0px 180px;
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
			List<Deal> deals = (List<Deal> ) request.getAttribute("allDeals");
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
			<p style="width:220px;">订单管理</p>
		</div>
			<p id="returnHome"><a href="../views/Manager.jsp">返回首页</a></p>
		
		<!-- 搜索框 -->
		<div id="search">
			<form action="../dealController/searchUserDeal" method="post">
				查询:&emsp;
				账号:<input type="text" name="id" />
				序列号:<input type="text" name="bookId" />
				交易时间:<input type="text" name="time" />
				收货地址:<input type="text" name="address" />&emsp;
				<input type="submit" id="submit" value="搜索" />
			</form>
		</div>
		
	    <div id="info">
	    	<ul class="easyui-datalist" title="订单信息" style="width:1400px;height:550px;">
	    	<%
	    		if(!deals.isEmpty()&&deals!=null){
		            for(Deal deal : deals){
		            	String id = deal.getId();
		            	String bookId = deal.getBookId();
		            	int number = deal.getNumber();
		            	float price = deal.getPrice();
		            	String time = deal.getTime();
		            	String address = deal.getAddress();
		    %>
		    		<li>
		        		<span id="id">用户账号:<b><%= id %></b></span>&emsp;
		        		<span id="bookId">商品序列号:<b><%= bookId %></b></span>&emsp;
		        		<span id="number">商品数量:<b><%= number %></b></span>&emsp;
		        		<span id="price">价格:<b><%= price %></b></span>&emsp;
		        		<span id="time">订单创建时间:<b><%= time %></b></span>&emsp;
		        		<span id="address">收货地址:<b><%= address %></b></span>
		    		</li>
		   	<%
		            }
	    		}else{
	    	%>
	    		<li><span>没有订单信息记录</span></li>
	    	<%
	    		}
	        %>
	    	</ul>
	    </div>
	</div>
	
</body>
</html>