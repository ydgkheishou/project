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
</head>
<body>

<div class="container">
    <div class="panel admin-panel margin-top">
        <div class="panel-head" id="add">
            <strong><h3><span class="icon ion-person-add margin-small"></span>用户注册</h3></strong>
        </div>
        <div class="body-content">
            <form method="post" class="form-x"
                  action="${pageContext.request.contextPath}/admin.action?method=add">
                <div class="form-group">

                    <div class="label">
                        <label>用户名：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="uloginname"
                               data-validate="required:请填写用户名!"/>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>密码：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="upsw"
                               data-validate="required:请填写密码!"/>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>设置问题：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="problem"
                               data-validate="required:请填写密码!"/>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>答案：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="answer"
                               data-validate="required:请填写密码!"/>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div >
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            角色：
                            <select name="role" id="roleid">
                                <option value="1">学生</option>
                                <option value="2">教师</option>
<%--                                <option value="3">教务处</option>--%>
                            </select></label>

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