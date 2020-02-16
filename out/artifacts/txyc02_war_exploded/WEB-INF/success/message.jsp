<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/12/11
  Time: 8:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>消息提示</title>
</head>
<body>
<%--文件操作结果提示--%>
   ${message}<br><br>
   <a href="${pageContext.request.contextPath }/uploadServlet.action">返回</a>
</body>
</html>
