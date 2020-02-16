<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<h1 align="center">学生成绩操作</h1>
<h2 align="center">
    &lt;%&ndash;<form action="teacher.action?method=toAddGrade" method="post">
        <input type="submit" value="添加新生成绩">
    </form>&ndash;%&gt;
    <form action="admin.action?method=queryGradeByPage" method="post">
        名称：<input type="text" name="name" value="${name}">&nbsp;&nbsp;
        第: <input type="text" name="gorder" value="${gorder}">&nbsp;次成绩 &nbsp;&nbsp;
        <input type="submit" value="查询">
    </form>
</h2>
<table align="center" border="1" cellpadding="20" cellspacing="0" width="85%" height="10%">
    <tr>
        <th>学生ID</th>
        <th>姓名</th>
        <th>第几次</th>
        <th>java程序设计</th>
        <th>数据结构</th>
        <th>高等代数</th>
        <th>总分</th>
        <th>操作</th>
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
            <td> <a href="javascript:void(0)" onclick="queryGrade(${grade.admin.userid},${grade.gid},${pb.pageNum})">修改成绩</a>&nbsp;|
                <a href="javascript:void(0)" onclick="uploadGrade(${grade.admin.userid},'${grade.admin.username}',${pb.pageNum})">上传成绩</a> |
                <a href="javascript:void(0)" onclick="deleteGrade(${grade.gid},${pb.pageNum})">删除成绩</a>
            </td>


        </tr>
    </c:forEach>
</table>
<br><br>
&lt;%&ndash;上一页&ndash;%&gt;
<div align="center">
    <c:choose>
        <c:when test="${pb.pageNum gt 1}">
            <a href="admin.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum=${pb.pageNum-1}">上一页</a>
        </c:when>
        <c:otherwise>上一页</c:otherwise>
    </c:choose>
    &lt;%&ndash;生成所有页号的超链接，作为分页导航菜单
        当前页的页号,就添加class="sellink"的样式;否则没有该样式
    &ndash;%&gt;
    <c:forEach var="sn" begin="1" end="${pb.totalPage}">
        <c:choose>
            <c:when test="${sn eq pb.pageNum}">
                <a href="admin.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum=${sn}" class="sellink">${sn}</a>
            </c:when>
            <c:otherwise>
                <a href="admin.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum=${sn}">${sn}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    &lt;%&ndash;下一页&ndash;%&gt;
    <c:choose>
        <c:when test="${pb.pageNum lt pb.totalPage}">
            <a href="admin.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum=${pb.pageNum+1}">下一页</a>
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
    //去到修改页面的函数,因为可能会出现没有分数的现象，所以加入userid
    function  queryGrade(userid,gid,pageNum) {
        //请求CustomerServlet,用location.href发送get请求
        location.href="teacher.action?method=toUpdate&userid="+userid+"&gid="+gid+"&pageNum="+pageNum;
    }

    //去上传
    function  uploadGrade(userid,username,pageNum) {
        //请求CustomerServlet,用location.href发送get请求
        location.href="teacher.action?method=toUploadGrade&userid="+userid+"&username="+username+"&pageNum="+pageNum;
    }

    //去删除
    function  deleteGrade(gid,pageNum) {
        //请求CustomerServlet,用location.href发送get请求
        location.href="teacher.action?method=deleteGrade&gid="+gid+"&pageNum="+pageNum;
    }

    //选择下拉列表中的页号时，调用changePageNum()函数
    function changePageNum() {
        var pageNum = document.getElementById('selNum').value;
        location.href = "admin.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum=" + pageNum;
    }
</script>
</body>
</html>--%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>
    <%--用于表格的样式--%>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/pintuer.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin.css">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer.js"></script>

    <%--  定义js函数，实现根据不同的页号进行分页 --%>
    <script>
        function changePageNum(pageNum){
            //请求后台Servlet
            location.href="admin.action?method=queryGradeByPage&name=${name}&gorder=${gorder}&pageNum="+pageNum;
        }
    </script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="icon-reorder">学生成绩管理页面</strong>
    </div>

  <form action="admin.action?method=queryGradeByPage" method="post">
        名称：<input type="text" name="name" value="${name}">&nbsp;&nbsp;
        第: <input type="text" name="gorder" value="${gorder}">&nbsp;次成绩 &nbsp;&nbsp;
        <input type="submit" value="查询">
    </form>
    <table class="table table-hover text-center">
        <tr>

            <th>学生ID</th>
            <th>姓名</th>
            <th>第几次</th>
            <th>java程序设计</th>
            <th>数据结构</th>
            <th>高等代数</th>
            <th>总分</th>
            <th>操作</th>
        </tr>

        <c:forEach var="grade" items="${pb.list}">
            <tr>
                <td>${grade.admin.userid}</td>
                <td>${grade.admin.username}</td>
                <td>${grade.gorder}</td>
                <td>${grade.chinese}</td>
                <td>${grade.math}</td>
                <td>${grade.english}</td>
                <td>${grade.sum}</td>
                <td> <a href="javascript:void(0)" onclick="queryGrade(${grade.admin.userid},${grade.gid},${pb.pageNum})" style="color: #ff9900">修改成绩</a>&nbsp;|
                    <a href="javascript:void(0)" onclick="uploadGrade(${grade.admin.userid},'${grade.admin.username}',${pb.pageNum})" style="color: #0F91CB">上传成绩</a> |
                    <a href="javascript:void(0)" onclick="deleteGrade(${grade.gid},${pb.pageNum})" style="color: #ee3333">删除成绩</a>
                </td>
            </tr>
        </c:forEach>


        <tr>
            <td colspan="80">
                <div class="pagelist">
                    <!-- 当前页是第1页时，首页，上一页直接显示，
             <a class="nocls">首页</a>   <a class="nocls">上一页</a>
               不是第1页时，点击后跳转页面,onclick指定函数 -->
                    <c:choose>
                        <c:when test="${pb.pageNum eq 1}">
                            <a class="nocls">首页</a> <a class="nocls">上一页</a>
                        </c:when>
                        <c:otherwise>

                            <a href="javascript:void(0)" onclick="changePageNum(1)">首页</a> <a
                                href="javascript:void(0)" onclick="changePageNum(${pb.pageNum-1})">上一页</a>
                        </c:otherwise>
                    </c:choose>
                    <!-- 当前页显示在span里面,其它页点击后跳转页面 -->
                    <c:forEach var="sn" begin="1" end="${pb.totalPage}">
                        <c:choose>
                            <c:when test="${sn eq pb.pageNum}">
                                   <span
                                           class="current">${sn}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:void(0)" onclick="changePageNum(${sn})">${sn}</a>
                            </c:otherwise>
                        </c:choose>

                    </c:forEach>
                    <c:choose>
                        <c:when test="${pb.pageNum eq pb.totalPage}">
                            <a class="nocls">下一页</a> <a class="nocls">尾页</a>
                        </c:when>
                        <c:otherwise>

                            <a href="javascript:void(0)" onclick="changePageNum(${pb.pageNum+1})">下一页</a>
                            <a
                                    href="javascript:void(0)" onclick="changePageNum(${pb.totalPage})">尾页</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </td>
        </tr>

        <%--<tr>
                <td colspan="80"><div class="pagelist">
                        <!-- 当前页是第1页时，首页，上一页直接显示，
                 <a class="nocls">首页</a>   <a class="nocls">上一页</a>
                   不是第1页时，点击后跳转页面,onclick指定函数 -->
                        <a href="javascript:void(0)" onclick="alert('首页');">首页</a> <a
                            href="javascript:void(0)" onclick="alert('上一页');">上一页</a>
                        <!-- 当前页显示在span里面,其它页点击后跳转页面 -->
                        <a href="javascript:void(0)" onclick="alert(1);">1</a> <span
                            class="current">2</span>
                        <!-- 当前页是尾页时，尾页，下一页直接显示，
                 <a class="nocls">下一页</a>   <a class="nocls">尾页</a>
                   不是尾页时，点击后跳转页面,onclick指定函数 -->
                        <a class="nocls">下一页</a> <a class="nocls">尾页</a>
                    </div></td>
            </tr>--%>
    </table>
</div>
<script>
    //去到修改页面的函数,因为可能会出现没有分数的现象，所以加入userid
    function  queryGrade(userid,gid,pageNum) {
        //请求CustomerServlet,用location.href发送get请求
        location.href="teacher.action?method=toUpdate&userid="+userid+"&gid="+gid+"&pageNum="+pageNum;
    }

    //去上传
    function  uploadGrade(userid,username,pageNum) {
        //请求CustomerServlet,用location.href发送get请求
        location.href="teacher.action?method=toUploadGrade&userid="+userid+"&username="+username+"&pageNum="+pageNum;
    }

    //去删除
    function  deleteGrade(gid,pageNum) {
        //请求CustomerServlet,用location.href发送get请求
        location.href="teacher.action?method=deleteGrade&gid="+gid+"&pageNum="+pageNum;
    }

</script>
</body>
</html>
