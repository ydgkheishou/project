<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
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

<link href="${pageContext.request.contextPath}/css/layout.css"
	type="text/css" rel="stylesheet" />

<script language="JavaScript"
	src="${pageContext.request.contextPath}/js/public.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function back1() {
		window.history.go(-1);
	}
</script>
</head>

<body>
	<jsp:include flush="true" page="/qiantai/inc/incTop.jsp"></jsp:include>
	<div class="page_row">
		<!--左边的 -->
		<div class="page_main_msg left">
			<div class="left_row">
				<div class="list pic_news">
					<div class="list_bar">&nbsp;订单确认</div>
					<form
						action="${pageContext.request.contextPath}/order.action?method=addOrder"
						name="f" method="post">
						<table width="99%" border="0" cellpadding="2" cellspacing="1"
							bgcolor="#FFFFFF" align="center" style="margin-top:8px">
							<tr align='center' bgcolor="#FFFFFF" height="22">
								<td>收货人帐号：</td>
								<td><input type="text" readonly="readonly"
									value="${user.user_name }" /></td>
							</tr>
							<tr align='center' bgcolor="#FFFFFF" height="22">
								<td>收货人姓名：</td>
								<td><input type="text" readonly="readonly"
									value="${user.user_realname }" /></td>
							</tr>
							<tr align='center' bgcolor="#FFFFFF" height="22">
								<td>收货人联系电话：</td>
								<td><input type="text" value="${user.user_tel }" /></td>
							</tr>

							<tr align='center' bgcolor="#FFFFFF" height="22">
								<td>收货地址：</td>
								<td><input type="text" name="odderSonghuodizhi"
									value="${user.user_address }" /></td>
							</tr>
							<tr align='center' bgcolor="#FFFFFF" height="22">
								<td>付款方式(暂时只支持货到付款)：</td>
								<td><select name="odderFukuangfangshi" style="width:155px;">
										<option value="货到付款">货到付款</option>
								</select> <!-- 隐藏域，存储订单的总金额，就是购物车的总金额 --> <input type="hidden"
									name="totalPrice" value="${cart.totalPrice }" /> <!-- 隐藏域，存储当前用户的id -->
									<input type="hidden" name="userid" value="${user.user_id }" />
								</td>
							</tr>
						</table>
						<table>
							<tr height="7">
								<td></td>
							</tr>
							<tr>
								<td width="120"></td>
								<td><a href="#" onclick="back1()"><img border="0"
										src="${pageContext.request.contextPath}/images/Car_icon_back.gif" /></a></td>
								<!-- 点击提交订单，将表单提交到后台Servlet -->
								<td><img border="0"
									src="${pageContext.request.contextPath}/images/Car_icon_06.gif"
									onclick="javascript:document.f.submit();" /></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
		<!--左边的 -->
		<!-- 右边的-->
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
