<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户注册</title>
<link href="../css/defult.css" type="text/css" rel="stylesheet" />
<style type="text/css">
	.popup{
		position:absolute;
		top:200px;
		right:250px;
		background-color:rgba(255,255,255);
		border-radius: 10px;
		width:400px;
        height:515px;
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
	
	#register{
		width:300px;
		margin:20px;
		padding: 45px 0px 20px 55px;
		border:outset 2px;
	}
	
	#register>p{
		font-size:30px;
		margin:-20px 0px 25px 60px;
		color:#b63b4d;
		font-weight: 900;
	}

	#register input:not(.but){
        height:30px; 
        border:0px;
        border-bottom:2px solid #000;
	}
	
	#register input:focus { 
		outline: none; 
	}
	
	#register #id,
	#register #name,
	#register #password,
	#register #address{
		font-size:20px;
		width:250px;
		height:40px
	}
	
	#register .but{
		font-size:20px;
		width:100px;
		height:40px;
		margin-top:-8px;
		color:#fff;
		background-color: #b63b4d;
		border:1px solid #b63b4d;
		border-radius: 5px;
	}
	
	#register .but:active{
		background:#983947;
	}
	
	#register #message{
		font-size: 15px;
		margin:-35px 0px -30px 40px;
		color: red;
	}
	
</style>
</head>
<body>
	<img class="logo" alt="图片丢失" src="../imgs/logo2.png" style="width:300px;height:75px;margin-left:100px;"/>
    <div class="popup">
	    <div id="register">
	   	 	<p><b>用户注册</b></p>
	        <form action="../userController/register" method="post">
		        <p><input type="text" id="id" name="id"  placeholder=" 账号" required="required" pattern="^\d{3}$" title="账号为三位非负数字"/></p><br/>
		        <p><input type="text" id="name" name="userName" style="font-size:20px;width:250px;height:40px"  placeholder=" 用户名" required="required" pattern="^[A-Za-z\u4e00-\u9fa5\1-9]*$" title="用户名为汉字、英文字母和数字的组合" required="required"/></p><br/>
		        <p><input type="text" id="password" name="userPassword" style="font-size:20px;width:250px;height:40px"  placeholder=" 密码" required="required" pattern="^\d{4}$" title="密码为四位非负数字" required="required"/></p><br/>
		        <p><input type="text" id="address" name="address" style="font-size:20px;width:250px;height:40px"  placeholder=" 收货地址" required="required" pattern="^[A-Za-z\u4e00-\u9fa5]*$" title="收货地址为汉字、英文字母的组合" required="required"/></p><br/><br/>
		        <p  id="message">${requestScope.registerMes}</p><br/><br/>
		        <input type="submit" id="submit" class="but" value="注册"  />
		        &emsp;&emsp;
		        <input type="reset" id="reset" class="but" value="重置"  />
	        </form>
	        <h5>已有账号？<a href="../views/Login.jsp">点我去登录</a></h5>
	    </div>
    </div>
</body>
</html>