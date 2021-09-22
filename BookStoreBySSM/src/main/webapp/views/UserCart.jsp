<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.service.impl.UserServiceImpl"%>
<%@ page import="com.ssm.service.impl.BookServiceImpl"%>
<%@ page import="com.ssm.pojo.Book"%>
<%@ page import="com.ssm.pojo.User"%>
<%@ page import="com.ssm.pojo.Cart"%>
<%@ page import="java.util.List"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的购物车</title>
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
    #userCart a{
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
    .book img{
		width:250px;
		height:290px;
		margin-left:60px;
		margin-top:20px;
	}
	.book #outerUl{
		margin:40px 0px 50px 130px;
	}
	.book #outerLi{
		margin-top:40px;
		width:1400px;
		height:350px;
		border-bottom:2px solid #b63b4d;
	}
	.book #innerUl{
		margin:-290px 0px 0px 400px;
		font-size:25px;
		line-height: 50px;
	}
	.book #innerUl input:focus{ 
		outline: none; 
	}
	.book #innerUl input:not(.number){
        height:30px; 
        border:0px;
        font-size:30px;
        text-indent: 15px;
	}
	.book #innerUl #number{
		text-align: center;
		font-size:25px;
		border:3px solid #b63b4d;
        border-radius:5px;
	}
	.book #innerUl #submit{
		margin-left:25px;
		height:35px; 
        width:110px;
		font-size:20px;
		background-color:#b63b4d;
        color:#fff;
        border:1px solid #b63b4d;
        border-radius: 5px;
	}
	.book #innerUl #submit:hover {
		background-color:#983947;
	}
	
	#delete {
		margin-left:410px;
		text-align: center;
		font-size:25px;
		height:35px; 
        width:350px;
		background-color:#b63b4d;
        border:4px solid #b63b4d;
        border-radius: 5px;
	}
	#delete:hover{
		background-color:#983947;
		border-color: #983947;
	}
	#delete a{
		color:#fff;
	}
	#delete a:hover{
		text-decoration: none;
	}
	
	#totalPrice{
		display:inline-block;
		margin-left:1000px;
		padding:5px;
		font-size:30px;
		background-color: #b63b4d;
		color:#fff;
		width:autopx;
		border:3px solid #b63b4d;
		border-bottom-left-radius:10px;
		border-bottom-right-radius:10px;
	}
	
	
	#payInfo{
		margin:40px 0px 0px 300px;
		font-size:30px;
		line-height: 60px;
	}
	#payInfo #address{
		width:400px;
		border-bottom: 2px solid #b63b4d;
	}
	#payInfo input{
        height:30px; 
        border:0px;
        font-size:30px;
        text-indent: 10px;
	}
	#payInfo input:focus{ 
		outline: none; 
	}
	#payInfo #submit{
		margin-left:1000px;
		margin-bottom:100px;
		height:50px; 
        width:100px;
		background-color:#b63b4d;
        color:#fff;
        border:1px solid #b63b4d;
        border-radius: 5px;
        text-align: center;
	}
	#payInfo #submit:hover{
		background-color:#983947;
		border-color: #983947;
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
			session.setAttribute("id", id);
			//获取Ioc容器
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
			//获取UserServiceImpl的Bean对象
			UserServiceImpl userService = (UserServiceImpl)ctx.getBean("userService");
			//获取UserServiceImpl的Bean对象
			BookServiceImpl bookService = (BookServiceImpl)ctx.getBean("bookService");
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
			<p style="width:170px;">购物车</p>
		</div>
			<p id="returnHome"><a href="../views/HomePage.jsp">返回首页</a></p>
		
		<div class=book>
			<ul id="outerUl">
				<%
					@SuppressWarnings("unchecked") 
					List<Cart> userCart = (List<Cart>)request.getAttribute("userCart");
					if(userCart==null||userCart.isEmpty()){
				%>
						<li>
							<div class="message">
								<div id="content">
							<p>你的购物车还是空的,<a href="../views/HomePage.jsp">点我去逛逛</a></p>
			    				</div>
		    				</div>
	    				</li>
				<%
					}else{
						float totalPrice = 0;
						for(Cart cart : userCart){
				    		String bookId = cart.getBookId();
				    		int number = cart.getNumber();
				    		
				    		//根据bookId查询图书信息
				    		Book book = new Book();
				            book = bookService.queryBookByBookId(bookId);
				            String img = book.getImg();
				            String bookName = book.getBookName();
				            float price = book.getPrice();
				            totalPrice = totalPrice + price*number;
				            totalPrice = (float)(Math.round(totalPrice*100))/100;
				            
				            //更改后的数量
				            int afterNumber = number;
				%>
				<li id="outerLi">
					<a href="Info.jsp?bookId=<%= bookId %>&id=<%= id %>" target="_blank"><img alt="图片丢失" src="<%= img %>" /></a>
	        		<form action="updateUserCartNumber" method="post">
	        			<ul id="innerUl">
		            		<li><input type="hidden"  value="<%= id %>" name="id"></li>
		            		<li>序列号:<input type="text" name="bookId" value="<%= bookId %>" readonly="readonly"></li>
		            		<li>书名:<input type="text" name="bookName" value="<%= bookName %>" readonly="readonly"></li>
		            		<li>单价:<input type="text" name="price" value="<%= price %>" readonly="readonly"></li>
		            		<li><input type="hidden"  value="<%= number %>" name="number" readonly="readonly"></li>
		            		<li>购买数量:<input type="number" class="number" id="number" name="afterNumber" min="1" max="99" step="1" value="<%= afterNumber %>">
		            					<input type="submit" class="number" id="submit" value="确认更改" ></li>
	            			<li><a href="Info.jsp?bookId=<%= bookId %>&id=<%= id %>" target="_blank">详情</a>
	            		</ul>
	            	</form> 
	        		<p id="delete"><a href="deleteCart?bookId=<%= bookId %>&tableName=<%= "User"+id %>">删除</a></p>
	    		</li>	
	    		<%
	            		}
	            %>
	            <li><p id="totalPrice">总价格为:&emsp;￥<b><%= totalPrice %></b></p></li>
				<%
					}
	       		%>
			</ul>
	          	<%if(userCart!=null&&!userCart.isEmpty()){%>
	          	<div class="title">
					<p style="width:180px;font-size:40px;">付款信息</p>
	
				</div>
					
	          	<div id="payInfo">
			        <form action="../cartController/pay" method="post">
			        	账号:<input type="text" id="id" name="id" value=<%= id %> readonly="readonly">
			        	收货地址:<input type="text" id="address" name="address" value=<%= user.getAddress() %> required="required">
			        	<br>
                        付款方式:&nbsp;<input type="radio" name="payWay" value="支付宝" checked="checked">支付宝&emsp;
            							<input type="radio" name="payWay" value="微信">微信&emsp;
          						  		<input type="radio" name="payWay" value="到付">货到付款&emsp;
			           	<input type="submit" id="submit" value="结账">
			        </form>
	        	</div>
	          	<%}%>					  
		</div>	
	</div>
</body>
</html>