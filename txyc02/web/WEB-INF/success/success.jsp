<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/12/14
  Time: 23:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>提示页面</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
</head>
<body>
<!--setTimeout():炸弹定时函数，到达指定时间就执行函数或代码串，只会执行一次
     如果要调用的函数没有参数，可以直接用函数名调用，不用打引号-->
<%--学生成绩页面操作结果提示--%>
<h2 align="center" >${operate}成功！2秒后跳转到学生成绩页面......</h2>
<script>
    function goToUrl(){
        //改变url
        window.location.href="teacher.action?method=queryGradeByPage&pageNum=${pageNum}";
    }
    //3秒后跳转到百度网站
    setTimeout(goToUrl,2000);
</script>

</body>
</html>
