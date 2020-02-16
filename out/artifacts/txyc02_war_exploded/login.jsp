<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.net.URLDecoder" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>登录用户页面</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" type="text/css" media="screen"
          href="https://cdn.staticfile.org/ionicons/2.0.1/css/ionicons.min.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<%
    //用来实现记住账号密码和角色
    String username="";
    String userpwd="";
    String rid="";
    Boolean rememberFlag=false;
    Cookie[] cookies = request.getCookies();
    if (cookies!=null){
        for (int i=0;i<cookies.length;i++){
            if ("username".equals(cookies[i].getName())){
                username= URLDecoder.decode(cookies[i].getValue(),"utf-8");
                rememberFlag=true;
            }
            if ("userpwd".equals(cookies[i].getName())){
                userpwd=cookies[i].getValue();
            }
            if ("rid".equals(cookies[i].getName())){
                rid=cookies[i].getValue();
            }
        }
    }

    //将获取的值存放到request域中
    request.setAttribute("username",username);
    request.setAttribute("userpwd",userpwd);
    request.setAttribute("rid",rid);
    request.setAttribute("rememberFlag",rememberFlag);
   /*//或者存放到pageContext域中
    pageContext.setAttribute("username",username);
    pageContext.setAttribute("userpwd",userpwd);*/
%>
<div class="bg"></div>
<div class="container">
    <div class="line bouncein">
        <div class="xs6 xm4 xs3-move xm4-move">
            <div style="height:150px;"></div>
            <div class="media media-y margin-big-bottom"></div>
            <form action="${pageContext.request.contextPath }/login.action" method="post">
                <div class="panel loginbox">
                    <div class="text-center margin-big padding-big-top">
                        <h1 ><i class="icon ion-person-stalker margin-small"></i>教务处课程网站</h1>
                    </div>
                    <div class="panel-body"
                         style="padding:30px; padding-bottom:10px; padding-top:10px;">
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="text" class="input input-big" name="uloginname"
                                       value="${username}" placeholder="登录账号"
                                       data-validate="required:请填写账号!"/> <span
                                    class="icon icon-user margin-small"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="password" class="input input-big" name="upsw"
                                       placeholder="登录密码" value="${userpwd}"
                                       data-validate="required:请填写密码!"/> <span
                                    class="icon icon-key margin-small"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="field">
                                <input type="text" class="input input-big" name="code"
                                       placeholder="填写右侧的验证码" data-validate="required:请填写右侧的验证码!"/>
                                <%--应该是自动获取的，src後跟图片路径，会直接加载--%>
                                <img src="authCode.action" alt="" width="100" height="32"
                                     class="passcode" style="height:43px;cursor:pointer;"
                                     onclick="this.src=this.src+'?'">
                            </div>
                            <%--回显错误信息--%>
                            <span style="color:red;float:right">${errorMsg}</span>
                        </div>
                    </div>
                    <BR>
                    <div>
                        <%--<div  style="padding:30px;" >--%>
                        <label style="padding:30px;">
                            <input type="checkbox" value="remember-me" ${requestScope.rememberFlag ? 'checked': ''} name="remember">
                            记住我?
                        </label>
                            <select name="role" id="roleid">
                                <option value="1" <c:if test="${rid=='1'}">selected</c:if>>学生</option>
                                <option value="2"  <c:if test="${rid=='2'}">selected</c:if>>教师</option>
                                <option value="3" <c:if test="${rid=='3'}">selected</c:if>>教务处</option>
                            </select>
                        <label style="padding:25px;float:right">
                            <a style="color: yellow" href="forget1.jsp" ><i class="icon ion-help "></i>忘记密码</a>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <a style="color: cyan" href="${pageContext.request.contextPath }/admin.action?method=toAdd" ><i class="icon ion-person-add "></i> 我要注册</a>
                            &nbsp;
                        </label>
                    </div>
                    <div style="padding:30px;">

                        <input type="submit"
                               class="button button-block bg-main text-big input-big"
                               value="登录"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>