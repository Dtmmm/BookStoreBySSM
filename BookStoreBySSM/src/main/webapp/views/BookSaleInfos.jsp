<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.service.impl.BookServiceImpl"%>
<%@ page import="com.ssm.pojo.Book"%>
<%@ page import="com.ssm.pojo.Deal"%>
<%@page import="java.util.ArrayList"%>
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
    #bookSaleInfos a{
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
		margin:10px 0px 0px 400px;
		width:1300px;
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
	
	#chart{
		margin:-530px 0px 0px 1050px;
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
			//获取标志(true:所有书  false:某本书)
			boolean flag = (boolean) request.getAttribute("flag");
			
			//所有书的销售数量
			@SuppressWarnings("unchecked")
			List<Book> allBookSaleInfos = (List<Book>) request.getAttribute("allBookSaleInfos");
			
			//某本书的销售数量
			Book bookTotalSaleNumber = (Book) request.getAttribute("bookTotalSaleNumber");
			
			//获取Ioc容器
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
			//获取BookServiceImpl的Bean对象
			BookServiceImpl bookService = (BookServiceImpl)ctx.getBean("bookService");
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
			<p style="width:320px;">商品销售信息</p>
		</div>
			<p id="returnHome"><a href="../views/Manager.jsp">返回首页</a></p>
		
		<!-- 搜索框 -->
		<div id="search">
			<form action="../dealController/queryBookSaleInfo" method="post">
				序列号:<input type="text" name="bookId" required="required"  placeholder="请输入商品序列号"/>
				<input type="submit" id="submit" value="搜索" />
			</form>
		</div>
		
		<div id="info">
	    	<ul class="easyui-datalist" title="销售信息" style="width:1000px;height:550px;">
	    	<%
	    		if(flag==true&&!allBookSaleInfos.isEmpty()){
		            for(Book book : allBookSaleInfos){
		            	String bookId = book.getBookId();
		            	int totalSaleNumber = book.getTotalSaleNumber();
		            	
		            	Book bookInfo = bookService.queryBookByBookId(bookId);
		            	String bookName = bookInfo.getBookName();
		            	float price = bookInfo.getPrice();
		            	float totalPrice = 0;
		            	totalPrice = totalPrice + price*totalSaleNumber;
		            	totalPrice = (float)(Math.round(totalPrice*100))/100;
		            	
		    %>
		    		<li>
		        		<span id="bookId">序列号:<b><%= bookId %></b></span>
		        		<span id="bookName">书名:<b><%= "《"+bookName+"》" %></b></span>
		        		<span id="number">累计销售量:<b><%= totalSaleNumber %></b></span>
		        		<span id="price">单价:<b><%= price %></b></span>
		        		<span id="time">累计成交价:<b><%= totalPrice %></b></span>
		    		</li>
		    <%
		            }
	    		}
	        %>
	        <%
	    		if(flag==false&&bookTotalSaleNumber!=null){
		            String bookId = bookTotalSaleNumber.getBookId();
		            int totalSaleNumber = bookTotalSaleNumber.getTotalSaleNumber();
		            	
		            Book bookInfo = bookService.queryBookByBookId(bookId);
		            String bookName = bookInfo.getBookName();
		            float price = bookInfo.getPrice();
		            	
		    %>
		    	<li>
		        	<span id="bookId">序列号:<b><%= bookId %></b></span>
		        	<span id="bookName">书名:<b><%= "《"+bookName+"》" %></b></span>
		        	<span id="number">累计销售量:<b><%= totalSaleNumber %></b></span>
		        	<span id="price">单价:<b><%= price %></b></span>
		        	<span id="time">累计成交价:<b><%= totalSaleNumber*price %></b></span>
		    	</li>
		    <%
	    		}
	        	if((flag==true&&allBookSaleInfos.isEmpty())||(flag==false&&bookTotalSaleNumber==null)){
	    	%>
	    			<li>没有找到信息,<a href="../views/Manager.jsp">返回首页</a></li>
	    	<%
	    		}
	        %>
	    	</ul>
	    	<%
	    		if(flag==true&&!allBookSaleInfos.isEmpty()){
	    			session.setAttribute("allBookSaleInfos", allBookSaleInfos);
	    	%>
	    		<p id="chart"><a href="../views/Chart.jsp">查看饼图</a></p>
	    	<%	
	    		}
	    	%>
	    </div>
	</div>
	
	
</body>
</html>