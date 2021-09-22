<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>首页</title>
</head>
<body>

	<a href="../userController/queryAllUsers">查询所有用户</a>
	<br>
	
	<form action="../userController/queryUserById" method="post">
		查询用户：<input type="text" name="id">
		<input type="submit" value="查询">
	</form>
	<br>
	
	<form action="../userController/addUser" method="post">
		添加用户：<br>
		账户：<input type="text" name="id"><br>
		用户名：<input type="text" name="userName"><br>
		密码：<input type="text" name="userPassword"><br>
		地址：<input type="text" name="address"><br>
		<input type="submit" value="添加">
	</form>
	<br>
	
	<form action="../userController/updateUser" method="post">
		修改用户：<br>
		账户：<input type="text" name="id"><br>
		用户名：<input type="text" name="userName"><br>
		密码：<input type="text" name="userPassword"><br>
		地址：<input type="text" name="address"><br>
		<input type="submit" value="修改">
	</form>
	<br>
	
	<form action="../userController/deleteUser" method="post">
		删除用户：<br>
		账户：<input type="text" name="id">
		<input type="submit" value="删除">
	</form>
	<br>
	
	========================<br><br>
	
	<a href="../bookController/queryAllBooks">查询所有图书</a>
	<br>
	
	<form action="../bookController/queryBookByBookId" method="post">
	查询图书：<input type="text" name="bookId">
	<input type="submit" value="查询">
	</form>
	<br>
	
	<form action="../bookController/addBook" method="post">
	添加图书：<br>
	编号：<input type="text" name="bookId"><br>
	书名：<input type="text" name="bookName"><br>
	作者：<input type="text" name="author"><br>
	价格：<input type="text" name="price"><br>
	出版社：<input type="text" name="publisher"><br>
	出版日期：<input type="text" name="date"><br>
	库存：<input type="text" name="inventory"><br>
	图片：<input type="text" name="img"><br>
	简介：<input type="text" name="intro"><br>
	大分类：<input type="text" name="bClassification"><br>
	小分类：<input type="text" name="sClassification"><br>
	新品？：<input type="text" name="fresh"><br>
	畅销？：<input type="text" name="hot"><br>
	推荐？：<input type="text" name="recommended"><br>
	特卖？：<input type="text" name="sole"><br>
	<input type="submit" value="添加">
	</form>
	<br>
	
	<form action="../bookController/updateBook" method="post">
	修改图书：<br>
	编号：<input type="text" name="bookId"><br>
	书名：<input type="text" name="bookName"><br>
	作者：<input type="text" name="author"><br>
	价格：<input type="text" name="price"><br>
	出版社：<input type="text" name="publisher"><br>
	出版日期：<input type="text" name="date"><br>
	库存：<input type="text" name="inventory"><br>
	图片：<input type="text" name="img"><br>
	简介：<input type="text" name="intro"><br>
	大分类：<input type="text" name="bClassification"><br>
	小分类：<input type="text" name="sClassification"><br>
	新品？：<input type="text" name="fresh"><br>
	畅销？：<input type="text" name="hot"><br>
	推荐？：<input type="text" name="recommended"><br>
	特卖？：<input type="text" name="sole"><br>
	<input type="submit" value="修改">
	</form>
	<br>
	
	<form action="../bookController/deleteBook" method="post">
	删除图书：<br>
	编号：<input type="text" name="bookId">
	<input type="submit" value="删除">
	</form>
	<br>
	
	<form action="../bookController/searchBook" method="post">
	模糊查询图书：<input type="text" name="searchCondition">
	<input type="submit" value="模糊查询">
	</form>
	<br>
	
	<form action="../bookController/updateBookInventory" method="post">
		更新图书库存信息：<br>
		编号：<input type="text" name="bookId">
		数量：<input type="text" name="number">
		<input type="submit" value="更新">
	</form>

	========================<br><br>

	<form action="../cartController/createUserCart" method="post">
		创建用户购物车表：<input type="text" name="tableName">
		<input type="submit" value="创建">
	</form>
	<br>

	<form action="../cartController/queryUserCart" method="post">
		查询用户购物车：<input type="text" name="tableName">
		<input type="submit" value="查询">
	</form>
	<br>
	
	<form action="../cartController/updateUserCart" method="post">
		更新用户购物车：<br>
		表名：<input type="text" name="tableName">
		编号：<input type="text" name="bookId">
		数量：<input type="text" name="number">
		<input type="submit" value="更新">
	</form>
	<br>
	
	<form action="../cartController/deleteCart" method="post">
		从用户购物车中删除书：<br>
		表名：<input type="text" name="tableName">
		编号：<input type="text" name="bookId">
		<input type="submit" value="删除">
	</form>
	<br>
	
	<form action="../cartController/clearCart" method="post">
		清空用户购物车：<br>
		表名：<input type="text" name="tableName">
		<input type="submit" value="清空">
	</form>
	<br>
	
	<form action="../cartController/deleteUserCart" method="post">
		删除用户购物车表：<input type="text" name="tableName">
		<input type="submit" value="删除">
	</form>
	<br>
	
	========================<br><br>
	
	<a href="../dealController/queryAllDeals">查询所有订单</a>
	<br>
	
	<form action="../dealController/addDeal" method="post">
		添加订单：<br>
		id:<input type="text" name="id"><br>
		bookId:<input type="text" name="bookId"><br>
		number:<input type="text" name="number"><br>
		price:<input type="text" name="price"><br>
		time:<input type="text" name="time"><br>
		address:<input type="text" name="address"><br>
		payWay:<input type="text" name="payWay"><br>
		<input type="submit" value="添加">
	</form>
	<br>
	
	<form action="../dealController/queryUserDeal" method="post">
		查询用户订单:
		id:<input type="text" name="id">
		<input type="submit" value="查询">
	</form>
	<br>
	
	<form action="../dealController/searchUserDeal" method="post">
		根据账户、编号、时间、地址模糊查询订单:
		<input type="text" name="searchCondition">
		<input type="submit" value="查询">
	</form>
	<br>
	
	<form action="../dealController/queryBookSaleInfo" method="post">
		查询图书销售信息（数量）:
		bookId:<input type="text" name="bookId">
		<input type="submit" value="查询">
	</form>
	<br>
	
	========================<br><br>
	
	<a href="../announcementController/queryAllAnnouncements">查询所有通知</a>
	<br>
	
	<form action="../announcementController/queryAnnouncement" method="post">
		查询通知:
		<input type="text" name="announcementId">
		<input type="submit" value="查询">
	</form>
	<br>
	
	<form action=../announcementController/addAnnouncement method="post">
		添加通知:<br>
		announcementId:<input type="text" name="announcementId"><br>
		announcementTitle:<input type="text" name="announcementTitle"><br>
		announcementContent:<input type="text" name="announcementContent"><br>
		announcementShow:<input type="text" name="announcementShow"><br>
	<input type="submit" value="添加">
	</form>
	<br>
	
	<form action="../announcementController/deleteAnnouncement" method="post">
		删除通知:
		<input type="text" name="announcementId">
		<input type="submit" value="删除">
	</form>
	<br>
	
	<form action=../announcementController/updateAnnouncement method="post">
		修改通知:<br>
		announcementId:<input type="text" name="announcementId"><br>
		announcementTitle:<input type="text" name="announcementTitle"><br>
		announcementContent:<input type="text" name="announcementContent"><br>
		announcementShow:<input type="text" name="announcementShow"><br>
	<input type="submit" value="修改">
	</form>
	<br>

</body>
</html>