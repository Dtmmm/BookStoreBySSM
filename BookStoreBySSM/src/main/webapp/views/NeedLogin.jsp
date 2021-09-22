<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>加入购物车失败</title>
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
		background-color: #8b1e2e;
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
	    <div id="Vnavigation">
			<ul>
			    <li><br></li>
			    <li><p id="reLogin" ><a href="../views/Login.jsp">点我去登录</a></p></li>
			    <li><br><br><br><br><br><br><br></li>
			    <li><p id="test"><a href="#">帮助</a></p></li>
			    <li><p id="test"><a href="#">反馈</a></p></li>
			    <li><p id="test"><a href="#">联系我们</a></p></li>
			</ul>
		</div>
	</div>
	
	<!-- 主体 -->
	<div data-options="region:'center'">
		<div class="title">
		</div>
			<p id="returnHome"><a href="../views/HomePage.jsp">返回首页</a></p>
		
		<div class="message">
			<div id="content">
				<p>加入购物车失败,请先<a href="../views/Login.jsp">登录</a></p>
		    </div>
	    </div>
    </div>
</body>
</html>