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
    <title>忘记密码页面</title>
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
            <strong><h3><span class="icon ion-person-add margin-small"></span>忘记密码</h3></strong>
        </div>
        <div class="body-content">
            <form method="post" class="form-x"
                  action="${pageContext.request.contextPath}/admin.action?method=toUpdateAdminInfo">
                <div class="form-group">
                    <h2>${admin.username},您设置的：</h2><br>
                    <div class="label">
                        <label>问题：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="problem" value="${admin.problem}" readonly
                               data-validate="required:请填写密码!"/>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <input hidden value="${admin.username}" name="username"/>
                    <div class="label">
                        <label>答案：</label>
                    </div>

                    <div class="field">
                        <input type="text" class="input w80" name="answer"
                               data-validate="required:请填写答案!"/>
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
        </div>
    </div>
</div>
</body>
</html>

