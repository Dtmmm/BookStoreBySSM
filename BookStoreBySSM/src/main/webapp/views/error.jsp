<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>错误页面</title>
<link href="../css/defult.css" type="text/css" rel="stylesheet" />
<style type="text/css">
    #error{
        text-align: center;
        font-style:normal;
        font-weight:bold;
        font-size:30px;
        line-height: 90px;
        margin:290px 0px 0px 800px;
        padding: 15px 20px 0px 25px; 
        background-color:rgba(255,255,255);
        width:360px;
        height:100px; 
        border-radius: 30px;
    }
    
    a:link,a:visited{
        font-style:italic;
        text-decoration:none;
        color:#000000;
    }
    a:hover {
        text-decoration:underline;
    }
</style>
</head>
<body>
    <img class="logo" alt="图片丢失" src="../imgs/logo2.png" style="width:300px;height:75px;margin-left:100px;"/>

    <div id="error">
    	出错了！<a href="../views/HomePage.jsp">返回首页</a>
    </div>

</body>
</html>