<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>教务处课程网站中心</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath }/css/pintuer.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath }/css/admin.css">
    <script src="${pageContext.request.contextPath }/js/jquery.js"></script>
</head>
<body style="background-color:#f2f9fd;">
<div class="header bg-main">
    <div class="logo margin-big-left fadein-top">
        <h1>
            <img src="${pageContext.request.contextPath }/images/t.jpg"
                 class="radius-circle rotate-hover" height="50" alt=""/>教务处课程网站中心
        </h1>
    </div>
    <div class="head-l" align="right">
        <a class="button  bg-white" href="#" target="_blank"><span
                class="jiaoshi"></span> 学生
            页面</a>
    </div>
    <div class="head-2" align="right">
        &nbsp;&nbsp;<a href="##" class="button button-little bg-blue"><span class="icon-wrench" id="qc"></span>
        清除缓存</a> &nbsp;&nbsp;
        <a class="button button-little bg-red"
           href=" ${pageContext.request.contextPath}/login.jsp"><span
                class="icon-power-off" id="tcdl"></span> 退出登录</a>
    </div>
</div>
<div class="leftnav">
    <div class="leftnav-title">
        <strong><span class="icon-list"></span>操作菜单</strong>
    </div>
    <h2>
        <span class="icon-user"></span>系统管理
    </h2>
    <ul style="display:block">
        <li><a
                href="${pageContext.request.contextPath}/student.action?method=toChoose"
                target="right"><span class="icon-caret-right"></span>选课</a></li>
        <li><a
                href="${pageContext.request.contextPath}/student.action?method=queryOptionCourse"
                target="right"><span class="icon-caret-right"></span>选课查询</a></li>
        <li><a
                href="${pageContext.request.contextPath}/servlet/ListFileServlet"
                target="right"><span class="icon-caret-right"></span>作业查询与下载</a></li>

        <li><a
                href="${pageContext.request.contextPath}/uploadServlet.action"
                target="right"><span class="icon-caret-right"></span>上传平时作业</a></li>
        <li><a
                href="${pageContext.request.contextPath}/student.action?method=queryGradeByPage"
                target="right"><span class="icon-caret-right"></span>成绩查询</a></li>

    </ul>
    <h2>
        <span class="icon-pencil-square-o"></span>个人管理
    </h2>
    <ul>
        <li><a
                href="${pageContext.request.contextPath}/admin.action?method=toUpdate"
                target="right"><span class="icon-caret-right"></span>修改密码</a></li>
    </ul>
</div>
<script type="text/javascript">
    $(function () {
        $(".leftnav h2").click(function () {
            $(this).next().slideToggle(200);
            $(this).toggleClass("on");
        })
        $(".leftnav ul li a").click(function () {
            $("#a_leader_txt").text($(this).text());
            $(".leftnav ul li a").removeClass("on");
            $(this).addClass("on");
        })
    });
</script>
<ul class="bread">
    <li><a <%--href="{:U('Index/info')}"--%>  href="${pageContext.request.contextPath}/toInfo.action" target="right" class="icon-home">
        首页</a></li>
    <li><a href="##" id="a_leader_txt">网站信息</a></li>
    <li><b>当前语言：</b><span style="color:red;">中文</php></span>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;切换语言：<a href="##">中文</a> &nbsp;&nbsp;<a
                href="##">英文</a></li>
</ul>
<div class="admin">
    <iframe scrolling="auto" frameborder="0"
            src="${pageContext.request.contextPath}/toInfo.action" name="right"
            width="100%" height="100%"></iframe>
</div>
</body>
</html>