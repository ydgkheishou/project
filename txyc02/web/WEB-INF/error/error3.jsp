<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/12/15
  Time: 1:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>错误页面</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
</head>
<body>
<!--setTimeout():炸弹定时函数，到达指定时间就执行函数或代码串，只会执行一次
     如果要调用的函数没有参数，可以直接用函数名调用，不用打引号-->
<h2 align="center">用户名不存在！2秒后跳返回页面......</h2>

<script>
    function goToUrl() {
        //改变url
        window.location.href = "forget1.jsp";
    }

    //3秒后跳转到百度网站
    setTimeout(goToUrl, 2000);
</script>
</body>
</html>