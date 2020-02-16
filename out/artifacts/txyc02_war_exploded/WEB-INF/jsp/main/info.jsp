<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 引入格式化标签库 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pintuer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer.js"></script>
</head>
<%--消息样式--%>
<style>
    /*消息框整个div*/
    #message-window {
        background-color: #FFF;
        border: 1px solid #DDDDDD;
        text-align: left;
        line-height: 40px;
        font-size: 12px;
        font-weight: bold;
        z-index: 99;
        width: 320px;
        position: absolute; /*IE6*/
    }

    #message-top {
        /* background: #0084FF;*/
        background: chartreuse;
        width: 100%;
        height: 45px;
    }

    /*消息提醒框标题*/
    .message-top-title {
        text-align: left;
        float: left;
        padding-left: 3px;
        width: 50%;
    }

    .message-top-close {
        text-align: right;
        float: left;
        width: 48%;
    }

    .message-content {
        /*
                float: right;
        */
        height: 340px;
    }

    /*关闭图片*/
    .message-top-close-img {
        margin-top: 10px;
        margin-right: 4px;
        -webkit-transition: 0.4s;
        -webkit-transition: -webkit-transform 0.4s ease-out;
        transition: transform 0.4s ease-out;
        -moz-transition: -moz-transform 0.4s ease-out;
    }

    /* !*设置关闭图片旋转*!
     .message-top-close-img:hover{
         transform:rotate(360deg);
         -ms-transform:rotate(360deg); !* IE 9 *!
         -webkit-transform:rotate(360deg); !* Opera, Chrome, and Safari *!
     }*/

    /*消息框折叠*/
    #message-window-open {
        display: none;
        color: #fff;
        margin-right: 4px;
        font-size: 15px;
    }
</style>
<body>
<div class="bg"></div>
<div class="container">
    <div class="line bouncein">
        <div class="xs6 xm4 xs3-move xm4-move">
            <div style="height:150px;"></div>
            <div class="media media-y margin-big-bottom">
            </div>
            <form action="index.html" method="post">
                <div class="panel loginbox">
                    <div class="text-center margin-big padding-big-top"><h2>欢迎您登录教务处课程网站中心</h2></div>
                    <div class="panel-body" style="padding:30px; padding-bottom:10px; padding-top:10px;">
                        您好：${admin.username}<br/>
                        登陆时间:<%=new Date().toLocaleString()%>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%--消息框--%>
<div id="message-window" class="message-window" style="display:block;">
    <div id="message-top">
        <div class="message-top-title">系统消息!</div>
        <div class="message-top-close">
            <%--<input type="button" value="关闭" onclick="closeMessageWin()"  class="message-top-close-img">--%>
            <img alt="" src="${pageContext.request.contextPath}/images/close1.png"  class="message-top-close-img"
                 onclick="closeMessageWin()">
            <div id="message-window-open" onclick="msgWindowShow();">&gt;&gt;</div>
        </div>
    </div>
    <div id="message-content" class="message-content">

        <c:forEach var="infomation" items="${infomationList}" varStatus="id">
            <tr>
                    <%--<td>${infomation.nid}</td>
                    <c:forEach items="${signBusList}" var="sign" varStatus="xh"> sign与xh不能相同
                    ${xh.count}序号从1开始
                    ${xh.index}序号从0开始
                    ${xh.last}最后一个序号
                    ${xh.first}第一个序号
                  </c:forEach>--%>
                <td>${id.count}</td>
                、
                <td>${infomation.text}</td>&nbsp;&nbsp;&nbsp;
                发布时间：
                <td>
                        <%--注意：日期可以使用下面这种形式转换--%>
                        <%--使用格式化标签将日期值格式化成年月日形式--%>
                    <fmt:formatDate value="${infomation.time}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
            </tr>
            <br>
        </c:forEach>
    </div>
</div>
<script>
    function resizeMessageWin() {
        var getDiv = document.getElementById('message-window');
        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        getDiv.style.left = document.documentElement.clientWidth - getDiv.offsetWidth + 'px';
        getDiv.style.top = document.documentElement.clientHeight - getDiv.offsetHeight + scrollTop + 'px';
    }

    window.onscroll = window.onresize = window.onload = function () {
        resizeMessageWin();
    };

    function closeMessageWin() {
        $("#message-content").hide();//隐藏内容主题

        $('.message-top-close img').hide();

        $("#message-window-open").show();//折叠后的div
        resizeMessageWin();
    }

    function msgWindowShow() {
        $("#message-content").fadeIn(2000);
        $('.message-top-close img').show();
        $("#message-window-open").hide();
        resizeMessageWin();
    }
</script>
</body>
</html>