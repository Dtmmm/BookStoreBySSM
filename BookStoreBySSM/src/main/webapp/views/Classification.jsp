<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.service.impl.UserServiceImpl"%>
<%@ page import="com.ssm.pojo.Book"%>
<%@ page import="com.ssm.pojo.User"%>
<%@ page import="java.util.List"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <%	
    	String id = (String)session.getAttribute("id");
    %>
<title>${classification}</title>
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
		width:1723px;
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
		display:inline-block
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
	
	.message{
		margin:200px auto;
		text-align:center;
	}
	.message #content{
		display:inline-block;
		padding:30px;
		font-size:40px;
		border:3px solid #b63b4d;
		border-radius:10px;
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
	if(id==null||id.equals("null")){
	%>
	    <div id="Vnavigation">
		    <ul>
		    	<li><br></li>
		    	<li><p id="reLogin" ><a href="Login.jsp">点我去登录</a></p></li>
		    	<li><br><br><br><br><br><br><br></li>
		    	<li><p id="test"><a href="">帮助</a></p></li>
		    	<li><p id="test"><a href="">反馈</a></p></li>
		    	<li><p id="test"><a href="">联系我们</a></p></li>
		    </ul>
		</div>
	<%
	}else{
		session.setAttribute("id", id);
		//BookStoreService service = new BookStoreService();
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
		
		<div class="title">
			<p style="width:115px;">${classification}</p>
		</div>
			<p id="returnHome"><a href="../views/HomePage.jsp">返回首页</a></p>
		
		<div class=book>
			<ul id="outerUl">
				<%
					@SuppressWarnings("unchecked") 
					List<Book> classificationBooks = (List<Book>)request.getAttribute("classificationBooks");
					if(classificationBooks==null||classificationBooks.isEmpty()){
				%>
				<li>
					<div class="message">
						<div id="content">
					<p>好像没有结果,去看看别的书吧,<a href="../views/HomePage.jsp">返回首页</a></p>
		    			</div>
	    			</div>
				</li>
				<%
					}else{
						for(Book book : classificationBooks){
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
	    				<li id="bookName">书名:<a href="Info.jsp?bookId=<%= bookId %>&id=<%= id %>" ><b><%= "《"+bookName+"》" %></b></a></li>
	    				<li id="inventory">作者:<b><%= author %></b></li>
	    				<li id="publisher">出版社:<b><%= publisher %></b></li>
	    				<li id="price">价格:￥<b><%= price %></b></li>
	    			</ul>
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