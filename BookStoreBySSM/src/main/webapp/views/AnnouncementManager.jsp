<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ssm.pojo.Announcement"%>
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
    #announcementManager a{
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
		margin:40px 0px 0px 180px;
		width:1400px;
	}
	#info b{
		color:#b63b4d;
	}
	#info a,
	#info #submit{
		background-color: #b63b4d;
		color:#fff;
		padding: 2px;
		border: 1px solid #b63b4d;
		border-radius: 5px;
		font-size: 20px;
	}
	#info a:hover ,
	#info #submit:hover{
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
	#addAnnouncement a{
		margin:20px 0px 0px 1250px;
		font-size: 25px;
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
			List<Announcement> allAnnouncements = (List<Announcement>) request.getAttribute("allAnnouncements");
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
			<p style="width:220px;">公告管理</p>
		</div>
			<p id="returnHome"><a href="../views/Manager.jsp">返回首页</a></p>
		
	    <div id="info"> 
	    	<ul class="easyui-datalist" title="用户信息" style="width:1400px;height:550px;">
	    	<%
	            for(Announcement announcement : allAnnouncements){
	            	String announcementId = announcement.getAnnouncementId();
	            	String announcementTitle = announcement.getAnnouncementTitle();
	            	String announcementContent = announcement.getAnnouncementContent();
	            	boolean announcementShow = announcement.isAnnouncementShow();
	        %>
	    		<li>
	        		<form action="../announcementController/updateAnnouncement" method="post">
	        			公告编号:<span id="announcementId"><input type="text" name="announcementId" value=<%= announcementId %>  readonly="readonly"></span>
	        			公告标题:<span id="announcementTitle"><input type="text" name="announcementTitle" value=<%= announcementTitle %>  required="required"></span>
	        			公告内容:<span id="announcementContent"><input type="text" name="announcementContent" value=<%= announcementContent %>  required="required"></span>
	        			是否在首页显示:<span id="announcementShow"><input type="text" name="announcementShow" value=<%= announcementShow %>  required="required" placeholder="请输入true或者false"></span>
	        			<input type="submit" id="submit" value="修改"  />
	        			<span id="deleteAnnouncement"><a href="../announcementController/deleteAnnouncement?announcementId=<%= announcementId %>">删除公告</a></span>
	        		</form>
	    		</li>
	    	<%
	            }
	        %>
	    	</ul>
	    	<span id="addAnnouncement"><a href="../views/AddAnnouncement.jsp">增加公告</a></span>
	    </div>
	</div>

</body>
</html>