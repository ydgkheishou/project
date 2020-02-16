<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />

<link href="<%=path%>/css/layout.css" type="text/css" rel="stylesheet" />

<script language="JavaScript" src="<%=path%>/js/public.js"
	type="text/javascript">
		</script>
<!-- 删除页面自带的script标签 -->
</head>

<body>
	<jsp:include flush="true" page="/qiantai/inc/incTop.jsp"></jsp:include>
	<div class="page_row">
		<!--左边的 -->
		<div class="page_main_msg left">
			<div class="left_row">
				<div class="list pic_news">
					<div class="list_bar">&nbsp;我的订单</div>
					<table width="99%" border="0" cellpadding="2" cellspacing="1"
						bgcolor="#FFFFFF" align="center" style="margin-top: 8px">
						<tr align="center" bgcolor="#FAFAF1" height="22">
							<td>订单编号</td>
							<td>金额</td>
							<td>下单时间</td>
							<td>订单状态</td>
							<td>编辑</td>
						</tr>
						<c:forEach var="od" items="${orders }">
							<tr align='center' bgcolor="#FFFFFF" height="22">
								<td>${od.order_id }</td>
								<td>￥ ${od.order_jine } <br />
								</td>
								<td>${od.order_time }</td>
								<td><c:choose>
										<c:when test="${od.order_zhuangtai eq 0}">待发货</c:when>
										<c:when test="${od.order_zhuangtai eq 1}">已发货</c:when>
										<c:when test="${od.order_zhuangtai eq 2}">已收货</c:when>
										<c:otherwise>已完成</c:otherwise>
									</c:choose></td>
								<%-- 	 --%>
								<td><a href="${pageContext.request.contextPath}/orderitem.action?orderid=${od.order_id }"
								 target="_blank"
									>订单明细</a>
		                          </td>
							</tr>
						</c:forEach>
					</table>
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
