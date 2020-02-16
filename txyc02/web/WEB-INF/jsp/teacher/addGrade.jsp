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
    <title>添加学生成绩页面</title>
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
            <strong><h3><span class="icon ion-person-add margin-small"></span>添加新生成绩</h3></strong>
        </div>
        <div class="body-content">
            <form method="post" class="form-x"
                  action="${pageContext.request.contextPath}/teacher.action?method=gradeInsert">
                <div class="form-group">
                    <div class="label">
                        <label>新生学号：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="sid"
                               data-validate="required:请填写新生学号!"/>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>第几次成绩：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="gorder"
                               data-validate="required:请填写是第几次成绩!"/>
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>java程序设计成绩：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="chinese"
                        />
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>数据结构成绩：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="math"
                        />
                        <div class="tips"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>高等代数成绩：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="english"
                        />
                        <div class="tips"></div>
                    </div>
                </div>
             <%--   <div class="form-group">
                    <div class="label">
                        <label>总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;分：</label>
                    </div>
                    <div class="field">
                        <input type="text" class="input w80" name="sum"
                        />
                        <div class="tips"></div>
                    </div>
                </div>--%>
                <div class="form-group">
                    <div class="label">
                        <label></label>
                    </div>
                    <div class="field">
                        <button class="button bg-main icon-check-square-o" type="submit">
                            上传成绩
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>


