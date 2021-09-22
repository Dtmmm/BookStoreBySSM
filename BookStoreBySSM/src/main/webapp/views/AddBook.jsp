<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.service.impl.BookServiceImpl"%>
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
	
	
	#addBook{
		border:2px solid #b63b4d;
		margin:140px auto;
		padding:30px;
		text-align:left;
		width:1000px;
		height:1020px;
		line-height: 60px;
		font-size: 30px;
	}
	#addBook input:not(.btn){
		border:0px;
		border-bottom:1px solid #b63b4d;
		width:840px;
		height:30px;
		font-size:30px;
		text-indent: 10px;
	}
	#addBook input:focus { 
		outline: none; 
	}
	#addBook .btn{
		margin-left:220px;
		background-color: #b63b4d;
		font-size:25px;
		color:#fff;
		border:1px solid #b63b4d;
		border-radius: 5px;
		padding: 3px;
		width:120px;
	}
	#addBook .btn:hover {
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
			<p style="width:220px;">增加商品</p>
		</div>
			<p id="returnHome"><a href="../views/Manager.jsp">返回首页</a></p>
	 
		 <div id="addBook">
		 	<form action="../bookController/addBook" method="post">
			 	<p>序列号:<input type="text" name="bookId" required="required" style="width:810px;"/></p>
			 	<p>书名:<input type="text" name="bookName" required="required" /></p>
			 	<p>作者:<input type="text" name="author" required="required" /></p>
			 	<p>单价:<input type="text" name="price" required="required" /></p>
			 	<p>出版社:<input type="text" name="publisher" required="required" style="width:810px;"/></p>
			 	<p>出版日期:<input type="text" name="date" placeholder="xxxx-xx(精确到月)" required="required" style="width:780px;"/></p>
			 	<p>库存(册):<input type="text" name="inventory" required="required" style="width:780px;"/></p>
			 	<p>一级类别:<input type="text" name="bClassification" required="required" style="width:780px;"/></p>
			 	<p>二级类别:<input type="text" name="sClassification" required="required" style="width:780px;"/></p>
			 	<p>图片:<input type="text" name="img" placeholder="请输入图片url" required="required" /></p>
			 	<p>简介:<input type="text" name="intro" required="required" /></p>
			 	<p>是否为新书:<input type="text" name="fresh" placeholder="true或者false" required="required" style="width:750px;"/></p>
			 	<p>是否为热卖:<input type="text" name="hot" placeholder="true或者false" required="required" style="width:750px;"/></p>
			 	<p>是否为推荐:<input type="text" name="recommended" placeholder="true或者false" required="required" style="width:750px;"/></p>
			 	<p>是否为独家:<input type="text" name="sole" placeholder="true或者false" required="required" style="width:750px;"/></p>
			 	<p><input type="submit" class="btn" id="submit" value="增加" />
			 		<input type="reset" class="btn" id="reset" value="重置" /></p>
		 	</form>
		 </div>
	 </div>
</body>
</html>