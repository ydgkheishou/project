<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<!-- 引入格式化标签库 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>


<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>消息管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pintuer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" type="text/css" media="screen"
          href="https://cdn.staticfile.org/ionicons/2.0.1/css/ionicons.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer.js"></script>
</head>
<body>

<div class="container">
    <div class="panel admin-panel margin-top">
        <div class="panel-head" id="add">
            <strong><h3><span class="icon ion-person-add margin-small"></span>用户密码修改</h3></strong>
        </div>
        <div class="body-content">

            <form method="post" class="form-x"
                  action="${pageContext.request.contextPath}/admin.action?method=addInfomation">
                <div class="form-group">
                    <div class="label">
                        <label>发布公告：</label>
                    </div>
                    <div class="field">
                        <textarea type="" class="input w80" name="text" cols="50" rows="10"
                               data-validate="required:请填写公告!"/></textarea>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label></label>
                    </div>
                    <div class="field">
                        <button class="button bg-main icon-check-square-o" type="submit">
                            提交
                        </button>
                    </div>
                </div>
            </form>
            <table align="left" border="1" cellpadding="20" cellspacing="0" width="80%" height="10%">
                <tr>
                    <th>公告ID</th>
                    <th>公告内容</th>
                    <th>发布时间</th>
                    <th>操作</th>
                </tr>
                <c:forEach var="infomation" items="${infomationList}" >
                    <tr>
                        <td align="center">${infomation.nid}</td>
                        <td>${infomation.text}</td>
                        <td align="center">
                                <%--注意：日期可以使用下面这种形式转换--%>
                                <%--使用格式化标签将日期值格式化成年月日形式--%>
                            <fmt:formatDate value="${infomation.time}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
                        <td align="center"><a href="${pageContext.request.contextPath}/admin.action?method=deleteInfomation&nid=${infomation.nid}">删除</a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
</body>
</html>