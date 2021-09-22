<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.service.impl.UserServiceImpl"%>
<%@ page import="com.ssm.service.impl.BookServiceImpl"%>
<%@ page import="com.ssm.service.impl.AnnouncementServiceImpl"%>
<%@ page import="com.ssm.pojo.Book"%>
<%@ page import="com.ssm.pojo.User"%>
<%@ page import="com.ssm.pojo.Announcement"%>
<%@ page import="java.util.List"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商城首页</title>
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
<!-- 轮播图 -->
	<link rel="stylesheet" type="text/css" href="../css/RotatePictureStyle.css">
	<script src="../js/RotatePicture.js"></script>
<!-- 公告栏 -->
	<link rel="stylesheet" type="text/css" href="../css/AnnouncementStyle.css">

<style type="text/css">
	hr{
		border-bottom: 2px solid #b63b4d;
		width:1630px;
		margin:0px auto;
	}
	
	.title{
		font-size:50px;
		color:#fff;
		border-bottom:5px solid #b63b4d;
		width:1630px;
		margin:0px auto;
	}
	
	.title p{
		margin:0px 0px 0px 110px;
		width:210px;
		border:3px solid #b63b4d;
		border-top-left-radius:10px;
		border-top-right-radius:10px;
		text-align: center;
		background-color: #b63b4d;
	}
	
	.book img{
		width:250px;
		height:270px;
	}
	.book #outerUl{
		margin:40px 0px 50px 100px;
	}
	.book #outerLi{
		width:390px;
		height:470px;
		display:inline-block;
	}
	.book #innerUl{
		font-size:20px;
	}
	.book #innerUl b{
		font-size:25px;
	}
	.book #innerUl #bookName b:hover{
		color:#b63b4d;
		text-decoration: underline;
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
		<!-- 侧面导航栏 -->
		<%
		String id = (String)session.getAttribute("id");
		
		//获取Ioc容器
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
		//获取UserServiceImpl的Bean对象
		UserServiceImpl userService = (UserServiceImpl)ctx.getBean("userService");
		
		if(id==null||id.equals("null")){
		%>
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
		<%
		}else{
			session.setAttribute("id", id);
			User user = userService.queryUserById(id);
			String tableName = "User"+id;
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
		<%
		}
		%>
	</div>
	
	
	<!-- 主体 -->
	<div data-options="region:'center'">
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
		
		<hr>
		
	    <!-- 轮播图 -->
	    <div class="box">
	    	<ul class="swiper">
		        <li class="active"><img src="../imgs/p1.jpg" alt=""></li>
		        <li><img src="../imgs/p2.jpg" alt=""></li>
		        <li><img src="../imgs/p3.jpg" alt=""></li>
		        <li><img src="../imgs/p4.jpg" alt=""></li>
		        <li class="active"><img src="../imgs/p1.jpg" alt=""></li>
	    	</ul>
	    	<ul class="dot">
		        <li class="active"></li>
		        <li></li>
		        <li></li>
		        <li></li>
	    	</ul>
	    	<div class="left">&lt;</div>
	    	<div class="right">&gt;</div>
		</div>
	    
	    
	    <!-- 公告 -->
	    <%
	  	//获取AnnouncementServiceImpl的Bean对象
	  	AnnouncementServiceImpl announcementService = (AnnouncementServiceImpl)ctx.getBean("announcementService");
	  	List<Announcement> allShowedAnnouncements = announcementService.queryAllShowedAnnouncements();  
	  	
	    %>
	    <div id="announcement">
	    	<div id="announcementTitle"><p>&nbsp;公告</p></div>
	   		<div id="announcementBody">
		    	<ul>
		    	<%
		            for(Announcement announcement : allShowedAnnouncements){
		            	String announcementId = announcement.getAnnouncementId();
						String announcementTitle = announcement.getAnnouncementTitle();
		        %>
		    		<li>
		        		<span id="announcementTitle"><a href="../announcementController/queryAnnouncement?announcementId=<%= announcementId %>"><%= announcementTitle %></a></span>
		    		</li>
		    	<%
		            }
		        %>
		    	</ul>
	    	</div>
	    </div>
	    
	    
	    <!-- 首页展示书 -->
	    <%
	  	//获取BookServiceImpl的Bean对象 
	    BookServiceImpl bookService = (BookServiceImpl)ctx.getBean("bookService");
	    List<Book> freshBooks = bookService.queryFreshBook();
	    List<Book> hotSoleBooks = bookService.queryHotSoleBook();
	    List<Book> recommendedBooks = bookService.queryRecommendedBook();
	    List<Book> soleBooks = bookService.querySoleBook();
	    %>
	    <!-- 新书上线 -->
	    <div class="title"><p>新书上线</p></div>
	    <div class=book>
	    	<ul id="outerUl">
	    	<%
	            for(Book book : freshBooks){
	            	String bookId = book.getBookId();
	            	String bookName = book.getBookName();
	            	String img = book.getImg();
	            	String author = book.getAuthor();
	            	String publisher = book.getPublisher();
	            	float price = book.getPrice();
	        %>
	    		<li id="outerLi">
	    			<a href="../views/Info.jsp?bookId=<%= bookId %>&id=<%= id %>" ><img alt="图片丢失" src="<%= img %>" /></a>
	    			<ul id="innerUl">
	    				<li id="bookId">序列号:<b><%= bookId %></b></li>
	    				<li id="bookName">书名:<a href="../views/Info.jsp?bookId=<%= bookId %>&id=<%= id %>" ><b><%= "《"+bookName+"》" %></b></a></li>
	    				<li id="inventory">作者:<b><%= author %></b></li>
	    				<li id="publisher">出版社:<b><%= publisher %></b></li>
	    				<li id="price">价格:￥<b><%= price %></b></li>
	    			</ul>
	    		</li>
	    	<%
	            }
	        %>
	    	</ul>
	    </div>
	    
	    
	    <!-- 火热售卖 -->
	    <div class="title"><p>火热售卖</p></div>
	    <div class=book>
	    	<ul id="outerUl">
	    	<%
	            for(Book book : hotSoleBooks){
	            	String bookId = book.getBookId();
	            	String bookName = book.getBookName();
	            	String img = book.getImg();
	            	String author = book.getAuthor();
	            	String publisher = book.getPublisher();
	            	float price = book.getPrice();
	        %>
	    		<li id="outerLi">
	    			<a href="../views/Info.jsp?bookId=<%= bookId %>&id=<%= id %>" target="_blank"><img alt="图片丢失" src="<%= img %>" /></a>
	    			<ul id="innerUl">
	    				<li id="bookId">序列号:<b><%= bookId %></b></li>
	    				<li id="bookName">书名:<a href="../views/Info.jsp?bookId=<%= bookId %>&id=<%= id %>"><b><%= "《"+bookName+"》" %></b></a></li>
	    				<li id="inventory">作者:<b><%= author %></b></li>
	    				<li id="publisher">出版社:<b><%= publisher %></b></li>
	    				<li id="price">价格:￥<b><%= price %></b></li>
	    			</ul>
	    		</li>
	    	<%
	            }
	        %>
	    	</ul>
	    </div>
	    
	    
	    <!-- 重点推荐 -->
	    <div class="title"><p>重点推荐</p></div>
	    <div class=book>
	    	<ul id="outerUl">
	    	<%
	            for(Book book : recommendedBooks){
	            	String bookId = book.getBookId();
	            	String bookName = book.getBookName();
	            	String img = book.getImg();
	            	String author = book.getAuthor();
	            	String publisher = book.getPublisher();
	            	float price = book.getPrice();
	        %>
	    		<li id="outerLi">
	    			<a href="../views/Info.jsp?bookId=<%= bookId %>&id=<%= id %>" target="_blank"><img alt="图片丢失" src="<%= img %>" /></a>
	    			<ul id="innerUl">
	    				<li id="bookId">序列号:<b><%= bookId %></b></li>
	    				<li id="bookName">书名:<a href="../views/Info.jsp?bookId=<%= bookId %>&id=<%= id %>"><b><%= "《"+bookName+"》" %></b></a></li>
	    				<li id="inventory">作者:<b><%= author %></b></li>
	    				<li id="publisher">出版社:<b><%= publisher %></b></li>
	    				<li id="price">价格:￥<b><%= price %></b></li>
	    			</ul>
	    		</li>
	    	<%
	            }
	        %>
	    	</ul>
	    </div>
	    
	    
	    <!-- 独家特供 -->
	    <div class="title"><p>独家特供</p></div>
	    <div class=book>
	    	<ul id="outerUl">
	    	<%
	            for(Book book : soleBooks){
	            	String bookId = book.getBookId();
	            	String bookName = book.getBookName();
	            	String img = book.getImg();
	            	String author = book.getAuthor();
	            	String publisher = book.getPublisher();
	            	float price = book.getPrice();
	        %>
	    		<li id="outerLi">
	    			<a href="../views/Info.jsp?bookId=<%= bookId %>&id=<%= id %>" target="_blank"><img alt="图片丢失" src="<%= img %>" /></a>
	    			<ul id="innerUl">
	    				<li id="bookId">序列号:<b><%= bookId %></b></li>
	    				<li id="bookName">书名:<a href="../views/Info.jsp?bookId=<%= bookId %>&id=<%= id %>"><b><%= "《"+bookName+"》" %></b></a></li>
	    				<li id="inventory">作者:<b><%= author %></b></li>
	    				<li id="publisher">出版社:<b><%= publisher %></b></li>
	    				<li id="price">价格:￥<b><%= price %></b></li>
	    			</ul>
	    		</li>
	    	<%
	            }
	        %>
	    	</ul>
	    </div>
    </div>
	

</body>
</html>