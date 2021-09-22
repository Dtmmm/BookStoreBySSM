<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户登录</title>
<link href="../css/defult.css" type="text/css" rel="stylesheet" />
<style type="text/css">
	.popup{
		position:absolute;
		top:250px;
		right:250px;
		background-color:rgba(255,255,255);
		border-radius: 10px;
		width:400px;
        height:385px;
        line-height: 25px;
        font-size:20px;
	}
	
	h5{
		margin:10px 0px 0px 130px;
		font-size:5px;
	}
	
	a:link,a:visited{
        font-style:italic;
        text-decoration:none;
        color:#000;
    }
    a:hover {
        text-decoration:underline;
    }
	
	#login{
		width:300px;
		margin:20px;
		padding: 45px 0px 50px 55px;
		border:solid 1px;
		border:outset 2px;
	}
	
	#login>p{
		font-size:30px;
		margin:-20px 0px 25px 60px;
		color:#b63b4d;
		font-weight: bolder;
	}
	
	
	#login input:not(#submit){
        height:30px; 
        border:0px;
        border-bottom:2px solid #000;
	}
	
	#login input:focus { 
		outline: none; 
	}
	
	#login #id,
	#login #password{
		font-size:20px;
		width:250px;
		height:40px
	}
	
	#login #submit{
		font-size:20px;
		width:250px;
		height:40px;
		margin-top:-8px;
		color:#fff;
		background-color: #b63b4d;
		border:1px solid #b63b4d;
		border-radius: 5px;
	}
	
	#login #submit:active{
		background:#983947;
	}
	
	#login #message{
		font-size: 15px;
		margin:-35px 0px -30px 30px;
		color: red;
	}
	
</style>
</head>

<body>
    <img class="logo" alt="图片丢失" src="../imgs/logo2.png" style="width:300px;height:75px;margin-left:100px;"/>
    
    <div class="popup">
    	<div id="login">
    		<p><b>用户登录</b></p>
	    	<form action="../userController/login" method="post">
	           	<p><input type="text" id="id" name="id" placeholder=" 账号" pattern="^\d{3}$" title="账号为三位非负数字" required="required" /></p><br/>
	            <p><input type="password" id="password" name="userPassword" placeholder=" 密码" pattern="^\d{4}$" title="密码为四位非负数字" required="required"/></p><br/><br/>
	            <p  id="message">${requestScope.loginMes}</p><br/><br/>
	            <input id="submit" type="submit" value="登录" />
	        </form>
	        <h5>还没有账号？<a href="../views/Register.jsp">点我去注册</a></h5>
    	</div>
    </div>
    
</body>
</html>