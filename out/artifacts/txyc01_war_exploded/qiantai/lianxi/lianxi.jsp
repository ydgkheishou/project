<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="${pageContext.request.contextPath}/css/layout.css" type="text/css" rel="stylesheet" />

<script language="JavaScript" src="${pageContext.request.contextPath}/js/public.js"
	type="text/javascript"></script>
<script type="text/javascript">
	
</script>
</head>

<body>
	<jsp:include flush="true" page="/qiantai/inc/incTop.jsp"></jsp:include>
	<div class="page_row">
		<!--左边的 -->
		<div class="page_main_msg left">
			<div class="left_row">
				<div class="list pic_news">
					<div class="list_bar">&nbsp;联系我们</div>
					<div class="ctitle ctitle1">联系方式</div>
					<div class="ctitleinfo"></div>
					<div class="pbox">




						网上体育商城 <br> 电话：15200088888<br> 联系人：老卢 <br>
						邮编：000000<br>


					</div>
					<div class="page_no">
						<div class="pg-3">
							<%--分页--%>
						</div>
					</div>
					<div class="arti_ref"></div>
				</div>
			</div>
		</div>
		<!-- 右边的 -->
		<div class="page_other_msg right">
			<div class="left_row">
				<div class="list">
					<div class="list_bar">用户登录</div>
					<div class="list_content">
						<div id="div">
							<jsp:include flush="true" page="/qiantai/userinfo/userlogin.jsp"></jsp:include>
						</div>
					</div>
				</div>
			</div>
			<div class="left_row">

			</div>
			
		</div>
		<div style="clear: both"></div>
	</div>

	<div>
		<jsp:include flush="true" page="/qiantai/inc/incFoot.jsp"></jsp:include>
	</div>
</body>
</html>
