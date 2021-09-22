<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.service.impl.UserServiceImpl"%>
<%@ page import="com.ssm.service.impl.BookServiceImpl"%>
<%@ page import="com.ssm.pojo.Book"%>
<%@ page import="com.ssm.pojo.User"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <%	
    	String id = request.getParameter("id");
    	if(id==null||id=="") id = (String)request.getAttribute("id");
    	if(!id.equals("000")) session.setAttribute("id", id);
    	
        String bookId = request.getParameter("bookId");
        if(bookId==null||bookId=="") bookId = (String)request.getAttribute("bookId");
        session.setAttribute("bookId", bookId);      
        
		//获取Ioc容器
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
		//获取UserServiceImpl的Bean对象
		UserServiceImpl userService = (UserServiceImpl)ctx.getBean("userService");
		//获取BookServiceImpl的Bean对象
		BookServiceImpl bookService = (BookServiceImpl)ctx.getBean("bookService");
		
        Book book = new Book();
        book = bookService.queryBookByBookId(bookId);
    %>
<title><%= book.getBookName() %></title>
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
<!-- 导航栏 -->
	<link rel="stylesheet" type="text/css" href="../css/HMultileveNavigationStyle.css">
<!-- 搜索框 -->
	<link rel="stylesheet" type="text/css" href="../css/SearchBarStyle.css">
<style type="text/css">
	.title{
		font-size:50px;
		color:#fff;
		border-bottom:5px solid #b63b4d;
		margin:0px auto;
	}
	
	.title p{
		margin:0px 0px 0px 130px;
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
	
	#bookInfo{
		height:73px;
    	width:1330px;
    	margin:15px 0px 0px 200px;
    	font-size:26px;
	}
	#bookInfo b{
		font-size:26px;
	}
	#bookInfo img{
		width:300px;
		height:460px;
		display:inline-block;
	}
	#bookInfo ul {
		margin:-465px 30px 0px 170px;
		width:1000px;
		height:400px;
	}
	#bookInfo ul li{
		margin:0px 0px 0px 200px;
    	height:45px;
	}
	
	#joinCart{
		margin:125px 0px 0px 960px;
	}
	#joinCart input:focus { 
		outline: none; 
	}
	#joinCart input:not(#submit){
        width:70px;
       	font-size:23px;
        color:#b63b4d;
       	border:3px solid #b63b4d;
       	border-radius: 5px;
       	text-align: center;
	}
	#joinCart #submit{
		height:40px; 
        width:140px;
		font-size:23px;
		background-color:#b63b4d;
        color:#fff;
        border:3px solid #b63b4d;
        border-radius: 10px;
	}
	#joinCart #submit:hover {
		background-color:#983947;
	}
	
	
	#manager{
		margin:150px 0px 0px 1000px;
	}
	#manager a{
		padding:10px;
		font-size:23px;
		background-color:#b63b4d;
        color:#fff;
        border:1px solid #b63b4d;
        border-radius: 10px;
	}
	#manager a:hover {
		background-color:#983947;
		text-decoration: none;
	}
</style>
</head>

<body class="easyui-layout">
	<!-- 顶部 -->
	<div data-options="region:'north'" style="height:80px">
		<img class="logo" alt="图片丢失" src="../imgs/logo2.png" style="width:300px;height:68px;margin-left:100px;"/>
	</div>	
	    
    <%
    if(id==null||id.equals("null")){
    %>
    <!-- 侧面 -->
	<div data-options="region:'west',title:' '" style="width:180px;">
    	<!-- 侧面导航栏 -->
	    <div id="Vnavigation">
			<ul>
			    <li><br></li>
			    <li><p id="reLogin" ><a href="../views/Login.jsp">点我去登录</a></p></li>
			    <li><br><br><br><br><br><br><br></li>
			    <li><p id="test"><a href="">帮助</a></p></li>
			    <li><p id="test"><a href="">反馈</a></p></li>
			    <li><p id="test"><a href="">联系我们</a></p></li>
			</ul>
		</div>
	</div>
    <%	
    }else if(id.equals("000")){
	%>
	<!-- 侧面 -->
	<div data-options="region:'west',title:' '" style="width:180px;">
	    <div id="Vnavigation">
	    	<ul>
		    	<li><img alt="图片丢失" src="../imgs/user.png" width="100" height="120" style="margin-top:50px;"/></li>
		    	<li><p>管理员</p></li>
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
	    
	    
	<%
	}else{
		session.setAttribute("id", id);
		User user = userService.queryUserById(id);
	%>
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
	<%
		}
	%>
	
    <!-- 主体 -->
	<div data-options="region:'center'">
		<%
			if(!id.equals("000")){
		%>
	    <!-- 导航栏 -->
	    <div id="HMultileveNavigation">
	    	<ul id="outUl">
	        	<li id="outLi"><a href="../views/HomePage.jsp">首页</a></li>
	        	<li id="outLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "小说" %>&sClassification=<%= "null" %>">小说</a>
	          		<ul id="inUl">
	            		<li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "小说" %>&sClassification=<%= "科幻" %>">科幻</a></li>
	            		<li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "小说" %>&sClassification=<%= "社会" %>">社会</a></li>
	            		<li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "小说" %>&sClassification=<%= "悬疑" %>">悬疑</a></li>
	          		</ul>
	        	</li>
	        	<li id="outLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "教育" %>&sClassification=<%= "null" %>">教育</a>
	            	<ul id="inUl">
	                    <li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "教育" %>&sClassification=<%= "教材" %>">教材</a></li>
	                    <li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "教育" %>&sClassification=<%= "教辅" %>">教辅</a></li>
	                </ul>
	        	</li>
	        	<li id="outLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "童书" %>&sClassification=<%= "null" %>">童书</a>
	            	<ul id="inUl">
	                    <li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "童书" %>&sClassification=<%= "科普" %>">科普</a></li>
	                    <li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "童书" %>&sClassification=<%= "绘本" %>">绘本</a></li>
	                    <li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "童书" %>&sClassification=<%= "童话" %>">童话</a></li>
	                </ul>
	        	</li>
	        	<li id="outLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "文学" %>&sClassification=<%= "null" %>">文学</a>
	            	<ul id="inUl">
	                    <li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "文学" %>&sClassification=<%= "名著" %>">名著</a></li>
	                    <li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "文学" %>&sClassification=<%= "古籍" %>">古籍</a></li>
	                    <li id="inLi"><a href="../bookController/queryClassificationBook?bClassification=<%= "文学" %>&sClassification=<%= "传记" %>">传记</a></li>
	                </ul>
	        	</li>
	        	<li id="outLi"><a href="">分类</a></li>
	        	<li id="outLi"><a href="">分类</a></li>
	        	<li id="outLi"><a href="">分类</a></li>
    		</ul>
    	</div>
	    
	    <!-- 搜索框 -->
		<div class="SearchBar">
			<form action="../bookController/searchBook" method="post">
				<input id="searchCondition" type="text" name="searchCondition"  placeholder=" 请输入书名或作者名" required="required"/>&emsp;
				<input id="submit" type="submit" value="搜索"/>
			</form>
		</div>	
		<%
			}
		%>
		
		<div class="title">
		</div>
		<% if(!id.equals("000")){ %><p id="returnHome"><a href="../views/HomePage.jsp">返回首页</a></p><% } %>
		<% if(id.equals("000")){ %><p id="returnHome"><a href="../views/Manager.jsp">返回首页</a></p><% } %>
		
	    <div id="bookInfo">
	        <img alt="图片丢失" src="<%= book.getImg() %>" width="220" height="250" />
	        <ul>
	            <li id="bookId">序列号:<b><%= bookId %></b></li>
	            <li id="bookName">书名:<b><%= book.getBookName() %></b></li>
	            <li id="author">作者:<b><%= book.getAuthor() %></b></li>
	            <li id="price">单价:<b><%= book.getPrice() %></b></li>
	            <li id="publisher">出版社:<b><%= book.getPublisher() %></b></li>
	            <li id="date">出版日期:<b><%= book.getDate() %></b></li>
	            <li id="Bclassification">一级类别:<b><%= book.getbClassification() %></b></li>
	            <li id="Sclassification">二级类别:<b><%= book.getsClassification() %></b></li>
	            <li id="inventory">库存(册):<b><%= book.getInventory() %></b></li>
	            <li id="intro">简介:<b><%= book.getIntro() %></b></li>
	        </ul>
	        <% if(!id.equals("000")){ %>
	            <div id="joinCart">
	            	<form action="../cartController/buy" method="post">
	            		<b>购买数量:</b>
	            		<input type="number" min="1" max="99" step="1" value="1" name="number" />
	            		<input type="hidden" name="bookId" value=<%= bookId %> />
	            		<input type="hidden" name="id" value=<%= id %> />
	            		<input type="submit" id="submit" value="加入购物车" />
	            	</form>
	            </div>
	        <% } %>
	        <% if(id.equals("000")){%>
	        	<div id="manager">
		        	<a href="UpdateBook.jsp?bookId=<%= bookId %>">修改商品信息</a>
		        	<a href="../bookController/deleteBook?bookId=<%= bookId %>">删除该商品</a>
	        	</div>
	        <% } %>
	    </div>
	</div>
</body>
</html>