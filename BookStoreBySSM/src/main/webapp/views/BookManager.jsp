<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.pojo.Book"%>
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
    #bookManager a{
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
		margin:40px 0px 0px 60px;
		width:1550px;
	}
	#info b,
	#info a{
		color:#b63b4d;
	}
	#info img{
		width:110px;
		height:160px;
	}
	#info #deleteBook a{
		background-color: #b63b4d;
		color:#fff;
		padding: 2px;
		border: 1px solid #b63b4d;
		border-radius: 5px;
		font-size: 20px;
	}
	#info #deleteBook a:hover{
		background-color:#983947;
		border-color: #983947;
		text-decoration: none;
	}
	#info input:focus { 
		outline: none; 
	}
	#info input:not(#submit){
		padding-top:5px;
		border:1px solid #b63b4d;
		width:180px;
		height:30px;
		font-size:20px;
	}
	.datalist .datagrid-cell, .m-list li {
		border-bottom: 2px solid #b63b4d;
		line-height: 40px;
		padding: 20px;
		
	}
	#addBook a{
		margin:0px 0px 0px 1400px;
		background-color: #b63b4d;
		color:#fff;
		border: 1px solid #b63b4d;
		border-radius: 5px;
		font-size: 25px;
		padding: 5px;
	}
	#addBook a:hover {
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
			List<Book> allBooks = (List<Book>) request.getAttribute("allBooks");
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
			<p style="width:220px;">商品管理</p>
		</div>
			<p id="returnHome"><a href="../views/Manager.jsp">返回首页</a></p>
			
			
	    <div id="info">
	    	<ul  class="easyui-datalist" title="商品信息" style="width:1600px;height:550px;">
	    	<%
	            for(Book book : allBooks){
	            	String bookId = book.getBookId();
	            	String bookName = book.getBookName();
	            	String img = book.getImg();
	            	float price = book.getPrice();
	            	int inventory = book.getInventory();
	            	String bClassification = book.getbClassification();
	            	String sClassification = book.getsClassification();
	            	boolean fresh = book.isFresh();
	            	boolean hot = book.isHot();
	            	boolean recommended = book.isRecommended();
	            	boolean sole = book.isSole();
	        %>
	    		<li>
	    			<a href="../views/Info.jsp?bookId=<%= bookId %>&id=<%= "000" %>" target="_blank"><img alt="图片丢失" src="<%= img %>" /></a>
	        		<span id="bookId">序列号:<b><%= bookId %></b></span>
	        		<span id="bookName">书名:<b><a href="../views/Info.jsp?bookId=<%= bookId %>&id=<%= "000" %>" target="_blank"><b><%= "《"+bookName+"》" %></b></a></b></span>
	        		<span id="price">价格:<b><%= price %></b></span>
	        		<span id="inventory">库存(册):<b><%= inventory %></b></span>
	        		<span id="classification">一级类别:<b><%= bClassification %></b></span>
	        		<span id="classification">二级类别:<b><%= sClassification %></b></span>
	        		<span id="fresh">新书:<b><%= fresh %></b></span>
	        		<span id="hot">热卖:<b><%= hot %></b></span>
	        		<span id="recommended">推荐:<b><%= recommended %></b></span>
	        		<span id="sole">独家:<b><%= sole %></b></span>
	        		<span id="deleteBook"><a href="../bookController/deleteBook?bookId=<%= bookId %>">删除</a></span>
	    		</li>
	    	<%
	            }
	        %>
	    	</ul>
	        <span id="addBook"><a href="../views/AddBook.jsp">新增书籍</a></span>
	    </div>
	</div>
	
</body>
</html>