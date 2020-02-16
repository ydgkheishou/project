<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>学生成绩界面</title>
    <style>
        .sellink{
            color:orangered;
        }
    </style>
</head>
<body>
<h1 align="center">成绩列表</h1>
<h2 align="center">

    <form action="student.action?method=queryGradeByPage" method="post">&nbsp;
        第: <input type="text" name="gorder" value="${gorder}">&nbsp;次成绩 &nbsp;&nbsp;
        <input type="submit" value="查询">
    </form>
</h2>
<table align="center" border="1" cellpadding="20" cellspacing="0" width="70%" height="10%">
    <tr>
        <th>学生ID</th>
        <th>姓名</th>
        <th>第几次</th>
        <th>java程序设计</th>
        <th>数据结构</th>
        <th>高等代数</th>
        <th>总分</th>
    </tr>
    <c:forEach var="grade" items="${pb.list}">
        <tr align="center">

            <td>${grade.admin.userid}</td>
            <td>${grade.admin.username}</td>
            <td>${grade.gorder}</td>
            <td>${grade.chinese}</td>
            <td>${grade.math}</td>
            <td>${grade.english}</td>
            <td>${grade.sum}</td>


        </tr>
    </c:forEach>
</table>
<br><br>
<%--上一页--%>
<div align="center">
    <c:choose>
        <c:when test="${pb.pageNum gt 1}">
            <a href="student.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum=${pb.pageNum-1}">上一页</a>
        </c:when>
        <c:otherwise>上一页</c:otherwise>
    </c:choose>
    <%--生成所有页号的超链接，作为分页导航菜单
        当前页的页号,就添加class="sellink"的样式;否则没有该样式
    --%>
    <c:forEach var="sn" begin="1" end="${pb.totalPage}">
        <c:choose>
            <c:when test="${sn eq pb.pageNum}">
                <a href="student.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum=${sn}" class="sellink">${sn}</a>
            </c:when>
            <c:otherwise>
                <a href="student.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum=${sn}">${sn}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <%--下一页--%>
    <c:choose>
        <c:when test="${pb.pageNum lt pb.totalPage}">
            <a href="student.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum=${pb.pageNum+1}">下一页</a>
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
        location.href = "student.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum=" + pageNum;
    }
</script>
</body>
</html>
