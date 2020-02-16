<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户界面</title>

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        #sellink{
            color:orangered;
        }
        tr th{
            text-align: center;
        }
    </style>
</head>
<body>
<h2 align="center">教务处课程网站</h2><br>
<h4 align="center">
    <form action="admin.action?method=queryByPage" method="post" >
        名称：<input type="text" name="name" value="${name}">
        <select name="role" id="roleid">
            <option value="1" <c:if test="${roleid=='1'}">selected</c:if>>学生</option>
            <option value="2" <c:if test="${roleid=='2'}">selected</c:if>>教师</option>
        </select>
        <input type="submit" value="查询" >
    </form>
</h4>
<table align="center" border="1" cellpadding="20" cellspacing="0" width="50%" height="20%" class="table table-striped">
    <tr align="center">
        <th>用户ID</th>
        <th>用户名称</th>
        <th>用户密码</th>
        <th>操作</th>
    </tr>
    <c:forEach var="admin" items="${pb.list}">
        <tr align="center">

            <td>${admin.userid}</td>
            <td>${admin.username}</td>
            <td>${admin.userpwd}</td>
            <td width="30%">
                <a href="javascript:void(0)" onclick="queryAdmin(${admin.userid},${pb.pageNum},${roleid})" class="btn btn-info">修改密码</a>
                <a href="javascript:void(0)" onclick="initPassword(${admin.userid},${pb.pageNum},${roleid})" class="btn btn-warning">初始化密码</a>
                    &lt;%&ndash; javascript:void(0)：用在href属性上，表示取消超链接的任何跳转，只响应JS事件&ndash;%&gt;
                <a href="javascript:void(0)" onclick="deleteAdmin(${admin.userid},${pb.pageNum},${roleid})" class="btn btn-danger">删除用户</a>
            </td>
        </tr>
    </c:forEach>
</table>
<br><br>
&lt;%&ndash;上一页&ndash;%&gt;
<div align="center">

&lt;%&ndash;生成所有页号的超链接，作为分页导航菜单
    当前页的页号,就添加class="sellink"的样式;否则没有该样式
&ndash;%&gt;
    <ul class="pagination pagination-lg">
&lt;%&ndash;        <li><a href="#">&laquo;</a></li>&ndash;%&gt;
    <c:choose>
        <c:when test="${pb.pageNum gt 1}">
            <li><a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${pb.pageNum-1}">&laquo;</a></li>
        </c:when>
    <c:otherwise>&lt;%&ndash;<li>&laquo;</li>&ndash;%&gt;</c:otherwise>
    </c:choose>
&lt;%&ndash;        <li><a href="#">1</a></li>&ndash;%&gt;
        <c:forEach var="sn" begin="1" end="${pb.totalPage}">
            <c:choose>
                <c:when test="${sn eq pb.pageNum}">
                    <li><a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${sn}" id="sellink">${sn}</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${sn}">${sn}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>

&lt;%&ndash;        <li><a href="#">&raquo;</a></li>&ndash;%&gt;
    <c:choose>
        <c:when test="${pb.pageNum lt pb.totalPage}">
            <li><a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${pb.pageNum+1}">&raquo;</a></li>
        </c:when>
        <c:otherwise>&lt;%&ndash;<li>&raquo;</li>&ndash;%&gt;</c:otherwise>
    </c:choose>
    </ul>
    <br>

&lt;%&ndash;下一页&ndash;%&gt;

&lt;%&ndash;    <----->跳转到第<select id="selNum" onchange="changePageNum()">
    <c:forEach var="sn" begin="1" end="${pb.totalPage}">
        <option value="${sn}"  ${sn eq pb.pageNum?"selected":""}>${sn}</option>
    </c:forEach>
</select>页 &ndash;%&gt;
</div>
<br><br>

<script>
    //点击删除后调用的函数
    function deleteAdmin(sid,pageNum,roleid){
        var flag=confirm("确定要删除密码吗？")
        if(flag){
            //请求CustomerServlet页面，使用location.href发送get请求
            location.href="admin.action?method=deleteAdmin&id="+sid+"&pageNum="+pageNum+"&role="+roleid;
        }
    }
    //点击初始化密码后调用的函数
    function initPassword(userid,pageNum,roleid){
        var flag=confirm("确定要初始化密码吗？")
        if(flag){
            //请求CustomerServlet页面，使用location.href发送get请求
            location.href="admin.action?method=initPassword&userid="+userid+"&pageNum="+pageNum+"&role="+roleid;
        }
    }
    //点击修改后调用的函数
    function  queryAdmin(id,pageNum,roleid) {
            //请求CustomerServlet,用location.href发送get请求
            location.href = "admin.action?method=toUpdate&id="+ id+"&pageNum="+pageNum+"&role="+roleid;
    }
    //选择下拉列表中的页号时，调用changePageNum()函数
    function changePageNum() {
        var pageNum = document.getElementById('selNum').value;
        location.href = "admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=" + pageNum;
    }

</script>
</body>
</html>--%>



<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户界面</title>
    <style>
        .sellink{
            color:orangered;
        }
        tr th{
            text-align: center;
        }
    </style>

</head>
<body>
<h1 align="center">教务处课程网站</h1><br>
<h2 align="center">
    <form action="admin.action?method=queryByPage" method="post" >
        名称：<input type="text" name="name" value="${name}">
        <select name="role" id="roleid">
            <option value="1" <c:if test="${roleid=='1'}">selected</c:if>>学生</option>
            <option value="2" <c:if test="${roleid=='2'}">selected</c:if>>教师</option>
        </select>
        <input type="submit" value="查询">
    </form>
</h2>
<table align="center" border="1" cellpadding="20" cellspacing="0" width="50%" height="10%" >
    <tr align="center">
        <th>用户ID</th>
        <th>用户名称</th>
        <th>用户密码</th>
        <th>操作</th>
    </tr>
    <c:forEach var="admin" items="${pb.list}">
        <tr align="center">

            <td>${admin.userid}</td>
            <td>${admin.username}</td>
            <td>${admin.userpwd}</td>
            <td >
                <a href="javascript:void(0)" onclick="queryAdmin(${admin.userid},${pb.pageNum},${roleid})" >修改密码</a> |
                <a href="javascript:void(0)" onclick="initPassword(${admin.userid},${pb.pageNum},${roleid})" >初始化密码</a> |
                    &lt;%&ndash; javascript:void(0)：用在href属性上，表示取消超链接的任何跳转，只响应JS事件&ndash;%&gt;
                <a href="javascript:void(0)" onclick="deleteAdmin(${admin.userid},${pb.pageNum},${roleid})" >删除用户</a>
            </td>
        </tr>
    </c:forEach>
</table>
<br><br>
&lt;%&ndash;上一页&ndash;%&gt;
<div align="center">
    <c:choose>
        <c:when test="${pb.pageNum gt 1}">
            <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${pb.pageNum-1}">上一页</a>
        </c:when>
        <c:otherwise>上一页</c:otherwise>
    </c:choose>
    &lt;%&ndash;生成所有页号的超链接，作为分页导航菜单
        当前页的页号,就添加class="sellink"的样式;否则没有该样式
    &ndash;%&gt;
    <c:forEach var="sn" begin="1" end="${pb.totalPage}">
        <c:choose>
            <c:when test="${sn eq pb.pageNum}">
                <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${sn}" class="sellink">${sn}</a>
            </c:when>
            <c:otherwise>
                <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${sn}">${sn}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    &lt;%&ndash;下一页&ndash;%&gt;
    <c:choose>
        <c:when test="${pb.pageNum lt pb.totalPage}">
            <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${pb.pageNum+1}">下一页</a>
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
    //点击删除后调用的函数
    function deleteAdmin(sid,pageNum,roleid){
        var flag=confirm("确定要删除密码吗？")
        if(flag){
            //请求CustomerServlet页面，使用location.href发送get请求
            location.href="admin.action?method=deleteAdmin&id="+sid+"&pageNum="+pageNum+"&role="+roleid;
        }
    }
    //点击初始化密码后调用的函数
    function initPassword(userid,pageNum,roleid){
        var flag=confirm("确定要初始化密码吗？")
        if(flag){
            //请求CustomerServlet页面，使用location.href发送get请求
            location.href="admin.action?method=initPassword&userid="+userid+"&pageNum="+pageNum+"&role="+roleid;
        }
    }
    //点击修改后调用的函数
    function  queryAdmin(id,pageNum,roleid) {
        //请求CustomerServlet,用location.href发送get请求
        location.href = "admin.action?method=toUpdate&id="+ id+"&pageNum="+pageNum+"&role="+roleid;
    }
    //选择下拉列表中的页号时，调用changePageNum()函数
    function changePageNum() {
        var pageNum = document.getElementById('selNum').value;
        location.href = "admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=" + pageNum;
    }

</script>
</body>
</html>--%>




<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>注册添加用户页面</title>
    <%--在jsp页面上，用如下的EL可以动态获取web应用的根路径:${pageContext.request.contextPath}--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pintuer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" type="text/css" media="screen"
          href="https://cdn.staticfile.org/ionicons/2.0.1/css/ionicons.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer.js"></script>
    <title>用户界面</title>
    <style>
        .sellink{
            color:orangered;
        }
    </style>
</head>
<body>

<div class="container" >
    <div class="panel admin-panel margin-top">
        <div class="panel-head" id="add">
            <strong><h3><span class="icon ion-person-add margin-small"></span>用户注册</h3></strong>
        </div>
        <div class="body-content">
            <h5 align="center">
                <form action="admin.action?method=queryByPage" method="post">
                    名称：<input type="text" name="name" value="${name}">
                    <select name="role" id="roleid">
                        <option value="1" <c:if test="${roleid=='1'}">selected</c:if>>学生</option>
                        <option value="2" <c:if test="${roleid=='2'}">selected</c:if>>教师</option>
                    </select>
                    <input type="submit" value="查询">
                </form>
            </h5>
           <%-- <table align="center" border="1" cellpadding="20" cellspacing="0" width="100%" height="90%">--%>
            <table class="table table-hover text-center">
                <tr>
                    <th>用户ID</th>
                    <th>用户名称</th>
                    <th>用户密码</th>
                    <th>操作</th>
                </tr>
                <c:forEach var="admin" items="${pb.list}">
                    <tr align="center">

                        <td>${admin.userid}</td>
                        <td>${admin.username}</td>
                        <td>${admin.userpwd}</td>
                        <td>
                            <a href="javascript:void(0)" onclick="queryAdmin(${admin.userid},${pb.pageNum},${roleid})" style="color: #ff9900">修改密码</a> |
                            <a href="javascript:void(0)" onclick="initPassword(${admin.userid},${pb.pageNum},${roleid})" style="color: #0F91CB">初始化密码</a> |
<%--
                             javascript:void(0)：用在href属性上，表示取消超链接的任何跳转，只响应JS事件
--%>
                            <a href="javascript:void(0)" onclick="deleteAdmin(${admin.userid},${pb.pageNum},${roleid})" style="color: #ee3333">删除用户</a>
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

                                    <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=1">首页</a> <a
                                        href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${pb.pageNum-1}">上一页</a>
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
                                        <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${sn}">${sn}</a>
                                    </c:otherwise>
                                </c:choose>

                            </c:forEach>
                            <c:choose>
                                <c:when test="${pb.pageNum eq pb.totalPage}">
                                    <a class="nocls">下一页</a> <a class="nocls">尾页</a>
                                </c:when>
                                <c:otherwise>

                                    <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${pb.pageNum+1}">下一页</a>
                                    <a
                                            href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${pb.totalPage}">尾页</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                </tr>

           <%-- <div align="center">
                <c:choose>
                    <c:when test="${pb.pageNum gt 1}">
                        <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${pb.pageNum-1}">上一页</a>
                    </c:when>
                    <c:otherwise>上一页</c:otherwise>
                </c:choose>
               &lt;%&ndash; 生成所有页号的超链接，作为分页导航菜单
                当前页的页号,就添加class="sellink"的样式;否则没有该样式&ndash;%&gt;

                <c:forEach var="sn" begin="1" end="${pb.totalPage}">
                    <c:choose>
                        <c:when test="${sn eq pb.pageNum}">
                            <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${sn}" class="sellink">${sn}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${sn}">${sn}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:choose>
                    <c:when test="${pb.pageNum lt pb.totalPage}">
                        <a href="admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=${pb.pageNum+1}">下一页</a>
                    </c:when>
                    <c:otherwise>下一页</c:otherwise>
                </c:choose>
                <----->跳转到第<select id="selNum" onchange="changePageNum()">
                <c:forEach var="sn" begin="1" end="${pb.totalPage}">
                    <option value="${sn}"  ${sn eq pb.pageNum?"selected":""}>${sn}</option>
                </c:forEach>
            </select>页
            </div>--%>
            </table>
        </div>
    </div>
</div>
<script>
    //点击删除后调用的函数
    function deleteAdmin(sid,pageNum,roleid){
        var flag=confirm("确定要删除密码吗？")
        if(flag){
            //请求CustomerServlet页面，使用location.href发送get请求
            location.href="admin.action?method=deleteAdmin&id="+sid+"&pageNum="+pageNum+"&role="+roleid;
        }
    }
    //点击初始化密码后调用的函数
    function initPassword(userid,pageNum,roleid){
        var flag=confirm("确定要初始化密码吗？")
        if(flag){
            //请求CustomerServlet页面，使用location.href发送get请求
            location.href="admin.action?method=initPassword&userid="+userid+"&pageNum="+pageNum+"&role="+roleid;
        }
    }
    //点击修改后调用的函数
    function  queryAdmin(id,pageNum,roleid) {
        //请求CustomerServlet,用location.href发送get请求
        location.href = "admin.action?method=toUpdate&id="+ id+"&pageNum="+pageNum+"&role="+roleid;
    }
    //选择下拉列表中的页号时，调用changePageNum()函数
    function changePageNum() {
        var pageNum = document.getElementById('selNum').value;
        location.href = "admin.action?method=queryByPage&name=${name}&role=${roleid}&pageNum=" + pageNum;
    }

</script>
</body>
</html>
