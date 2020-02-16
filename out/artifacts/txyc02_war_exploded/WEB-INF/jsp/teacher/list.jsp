<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生界面</title>
    <style>
        .sellink{
            color:orangered;
        }
    </style>
</head>
<body>
<h1 align="center">学生查询</h1>
<h2 align="center">
    <form action="teacher.action?method=queryByPage" method="post">
        名称：<input type="text" name="name" value="${name}">
        <input type="submit" value="查询">
    </form>
</h2>
<table align="center" border="1" cellpadding="20" cellspacing="0" width="50%" height="10%">
    <tr>
        <th>学生ID</th>
        <th>学生名称</th>
        <th>学生密码</th>
    </tr>
    <c:forEach var="admin" items="${pb.list}">
        <tr align="center">

            <td>${admin.userid}</td>
            <td>${admin.username}</td>
            <td>${admin.userpwd}</td>

        </tr>
    </c:forEach>
</table>
<br><br>
<%--上一页--%>
<div align="center">
<c:choose>
    <c:when test="${pb.pageNum gt 1}">
        <a href="teacher.action?method=queryByPage&name=${name}&pageNum=${pb.pageNum-1}">上一页</a>
    </c:when>
    <c:otherwise>上一页</c:otherwise>
</c:choose>
<%--生成所有页号的超链接，作为分页导航菜单
    当前页的页号,就添加class="sellink"的样式;否则没有该样式
--%>
<c:forEach var="sn" begin="1" end="${pb.totalPage}">
    <c:choose>
        <c:when test="${sn eq pb.pageNum}">
            <a href="teacher.action?method=queryByPage&name=${name}&pageNum=${sn}" class="sellink">${sn}</a>
        </c:when>
        <c:otherwise>
            <a href="teacher.action?method=queryByPage&name=${name}&pageNum=${sn}">${sn}</a>
        </c:otherwise>
    </c:choose>
</c:forEach>
<%--下一页--%>
<c:choose>
    <c:when test="${pb.pageNum lt pb.totalPage}">
        <a href="teacher.action?method=queryByPage&name=${name}&pageNum=${pb.pageNum+1}">下一页</a>
    </c:when>
    <c:otherwise>下一页</c:otherwise>
</c:choose>
    <----->跳转到第<select id="selNum" onchange="changePageNum()">
    <c:forEach var="sn" begin="1" end="${pb.totalPage}">
        <option value="${sn}"  ${sn eq pb.pageNum?"selected":""}>${sn}</option>
    </c:forEach>
</select>页
</div>
<br><br>

<script>

    //选择下拉列表中的页号时，调用changePageNum()函数
    function changePageNum() {
        var pageNum = document.getElementById('selNum').value;
        location.href = "teacher.action?method=queryByPage&name=${name}&pageNum=" + pageNum;
    }
</script>
</body>
</html>
