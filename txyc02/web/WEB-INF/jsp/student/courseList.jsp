<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>选课页面</title>
    <style>
        .sellink{
            color:orangered;
        }
    </style>
    <script src="${pageContext.request.contextPath }/js/jquery.js"></script>
</head>
<body>
<h1 align="center">学生选课</h1>
<h2 align="center">
    <form action="student.action?method=choose" method="post">
        <input  type="submit" value="提交选课">&nbsp;&nbsp;&nbsp;
        <input type="reset" value="重置"><br><br>

<table align="center" border="1" cellpadding="20" cellspacing="0" width="50%" height="10%">
    <tr>
        <th>全选 <input type="checkbox" id="checkAll" onclick="clickAll()"></th>
        <th>课程ID</th>
        <th>课程名</th>
        <th>上课教室</th>
        <th>任课教师</th>
    </tr>
    <c:forEach var="course" items="${pb.list}">
        <tr align="center">

            <td><input type="checkbox" name="cid" id="cid" value="${course.cid}"></td>
            <td>${course.cid}</td>
            <td>${course.coursename}</td>
            <td>${course.courseclass}</td>
            <td>${course.admin.username}</td>

        </tr>
    </c:forEach>
</table>

</form>
</h2>
<br><br>
<%--上一页--%>
<div align="center">
    <c:choose>
        <c:when test="${pb.pageNum gt 1}">
            <a href="student.action?method=toChoose&pageNum=${pb.pageNum-1}">上一页</a>
        </c:when>
        <c:otherwise>上一页</c:otherwise>
    </c:choose>
    <%--生成所有页号的超链接，作为分页导航菜单
        当前页的页号,就添加class="sellink"的样式;否则没有该样式
    --%>
    <c:forEach var="sn" begin="1" end="${pb.totalPage}">
        <c:choose>
            <c:when test="${sn eq pb.pageNum}">
                <a href="student.action?method=toChoose&pageNum=${sn}" class="sellink">${sn}</a>
            </c:when>
            <c:otherwise>
                <a href="student.action?method=toChoose&pageNum=${sn}">${sn}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <%--下一页--%>
    <c:choose>
        <c:when test="${pb.pageNum lt pb.totalPage}">
            <a href="student.action?method=toChoose&pageNum=${pb.pageNum+1}">下一页</a>
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
  function clickAll() {
      var a=document.getElementsByName("cid");
      for (var i=0;i<a.length;i++){
          var b=document.getElementById("checkAll").checked;
          a[i].checked=document.getElementById("checkAll").checked;
      }
    }



    //选择下拉列表中的页号时，调用changePageNum()函数
    function changePageNum() {
        var pageNum = document.getElementById('selNum').value;
        location.href = "student.action?method=toChoose&pageNum=" + pageNum;
    }
</script>
</body>
</html>
