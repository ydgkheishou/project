<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/12/13
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传成绩</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>

</head>
<body>
<h2 align="center">修改成绩</h2>
<div align="center">
    <form action="#" method="post">
        学生姓名：<input type="text" name="username" value="${grade.admin.username}"><br>
        语文成绩：<input type="text" name="chinese" value="${grade.chinese}"><br>
        数学成绩：<input type="text" name="math" value="${grade.math}"><br>
        英语成绩：<input type="text" name="english" value="${grade.english}"><br>
        <!--    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
        总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;分：<input type="text" name="sum" value="${grade.sum}">
        <br><br><br>
        <input type="submit" value="提交成绩">
    </form>
</div>
</body>
</html>
