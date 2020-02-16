<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/12/11
  Time: 0:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文件上传页面</title>
</head>
<body>
<!-- 实现文件的上传 -->
<!-- 1.要上传文件 表单提交请求的方式必须为post请求 -->
<!-- 2.要上传文件 需要设置form表单的enctype
	application/x-www-form-urlencoded是form表单enctype的默认值
	需要将enctype的值设置为 multipart/form-data
-->

<form  action="${pageContext.request.contextPath}/servlet/UploadHandleServlet" enctype="multipart/form-data" method="post">
    上传用户&nbsp;&nbsp;：<input type="text" name="username"><br/>
    上传文件1：<input type="file" name="file1"><br/>
    上传文件2：<input type="file" name="file2"><br/><br>
    <input type="submit" value="上传">
</form>

<form action="${pageContext.request.contextPath}/servlet/ListFileServlet" method="post">
    <input type="submit" value="文件管理">
</form>
<%--<a href="${pageContext.request.contextPath}/servlet/ListFileServlet" >文件管理</a>--%>
</body>
</html>

