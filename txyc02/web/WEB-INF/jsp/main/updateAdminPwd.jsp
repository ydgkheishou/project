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
    <title>修改用户信息页面</title>
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
            <strong><h3><span class="icon ion-person-add margin-small"></span>用户信息修改</h3></strong>
        </div>
        <div class="body-content">
            <form method="post" class="form-x"
                  action="${pageContext.request.contextPath}/admin.action?method=updateAdminInfo">
                <div class="form-group">
                    <input hidden value="${admin.userid}" name="userid"/>
                    <div class="label">
                        <label>用户名：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="username" value="${admin.username}" readonly
                               data-validate="required:请填写用户名!"/>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>密码：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="userpwd" value="${admin.userpwd}"
                               data-validate="required:请填写密码!"/>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>设置的问题：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="problem" value="${admin.problem}"
                               data-validate="required:请设置问题!"/>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>问题答案：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="answer" value="${admin.answer}"
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
                            提交修改信息
                        </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="button button-little bg-red"
                           href=" ${pageContext.request.contextPath}/login.jsp"><span
                                <%--class="icon-power-off"--%> id="tcdl"></span> 返回登录页面</a>
                    </div>

                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
