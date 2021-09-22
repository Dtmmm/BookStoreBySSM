<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.ssm.service.impl.BookServiceImpl"%>
<%@ page import="com.ssm.pojo.Deal"%>
<%@ page import="com.ssm.pojo.Book"%>
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
<!-- 饼图  -->
	<script type="text/javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" src="../js/jsapi.js"></script>
	<script type="text/javascript" src="../js/corechart.js"></script>		
	<script type="text/javascript" src="../js/jquery.gvChart-1.0.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.ba-resize.min.js"></script>
	<script type="text/javascript">
	gvChartInit();
	$(document).ready(function(){
		$('#myTable').gvChart({
			chartType: 'PieChart',
			gvSettings: {
				vAxis: {title: 'No of players'},
				hAxis: {title: 'Month'},
				width: 1200,
				height: 700
			}
		});
	});
	</script>
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
	
	#pieChart{
		width:1200px;
		margin:-30px auto;
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
	
	<!-- 主体 -->
	<div data-options="region:'center'">
		<div class="title">
			<p style="width:320px;">商品销售信息</p>
		</div>
			<p id="returnHome"><a href="../views/Manager.jsp">返回首页</a></p>
		
		<%
			List<String> name = new ArrayList<>();
			List<Integer> value = new ArrayList<>();
			
			@SuppressWarnings("unchecked")
			List<Book> allBookSaleInfos = (List<Book>)session.getAttribute("allBookSaleInfos");
			
			//获取Ioc容器
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
			//获取BookServiceImpl的Bean对象
			BookServiceImpl bookService = (BookServiceImpl)ctx.getBean("bookService");
		%>
		<!-- 饼图 -->
		<div id="pieChart">
		   <table id='myTable'>
				<caption>商品销售量占比</caption>
				<thead>
					<tr>
						<th></th>
						<%
							for(Book book : allBookSaleInfos){
								String bookId = book.getBookId();
								String bookName = bookService.queryBookByBookId(bookId).getBookName();
						%>
						<th><%= bookName %></th>
						<%}%>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>1200</th>
						<%
							for(Book book : allBookSaleInfos){
								int totalSaleNumber = book.getTotalSaleNumber();
						%>
						<td><%= totalSaleNumber %></td>
						<%}%>
					</tr>
				</tbody>
			</table>  
		</div>	

<div style="text-align:center;clear:both;"></div>
</div>
</body>
</html>
