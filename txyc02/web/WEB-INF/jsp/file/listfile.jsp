<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/12/11
  Time: 9:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文件下载界面</title>
</head>
<body>
<h2 align="center">文件管理</h2>
<table align="center" border="0" cellspacing="0" cellpadding="20">
    <tr>
        <th align="left"><h3>文件</h3></th>
        <th><h3>操作</h3></th>
    </tr>
    <hr>
    <!-- 遍历Map集合 -->
    <c:forEach var="me" items="${fileNameMap}">
        <c:url value="/servlet/DownLoadServlet" var="downurl">
            <%--${me.key}为原始名称，如：9349249849-88343-8344_阿_凡_达.avi--%>
            <c:param name="filename" value="${me.key}"></c:param>
        </c:url>

        <tr>
                <%--${me.value}为处理后的名称，如：阿_凡_达.avi--%>
            <td>${me.value}</td>
            <td><a href="${downurl}">下载</a></td>
            <td><a href="${pageContext.request.contextPath}/servlet/DeleteServlet?filename=${me.key}">删除</a></td>
        </tr>
        <%--${me.value}<a href="${downurl}">下载</a>--%>
        <br/>
    </c:forEach>
</table>
<hr>
</body>
</html>
