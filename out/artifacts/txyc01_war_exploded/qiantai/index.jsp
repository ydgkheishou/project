<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 导入核心标签库 -->
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

 <title>网站首页</title>


<link href="${pageContext.request.contextPath}/css/layout.css"
	type="text/css" rel="stylesheet" />

<script language="JavaScript"
	src="${pageContext.request.contextPath}/js/public.js"
	type="text/javascript">
	
</script>
<script type="text/javascript">
	
</script>
<style rel="stylesheet" type="text/css" media="screen">
</style>
</head>
<body>
	<!-- 包含头部页面 -->

	<jsp:include flush="true" page="inc/incTop.jsp"></jsp:include>

	<div class="page_row">
		<!--左边的 -->
		<div class="page_main_msg left">

			<!-- 新品上市 -->
			<div class="left_row">
				<div class="list pic_news">
					<div class="list_bar">
						<span style="float: left">新品上市</span> <span style="float: right">
						<a href="${pageContext.request.contextPath}/goods.action?method=queryByPage">更多</a>&nbsp;&nbsp;&nbsp;&nbsp;</span>
					</div>
					<div id="tw" class="list_content">
						<div style="width: 100%; overflow: hidden; white-space: nowrap;">
							<table width="100%" align="left" cellpadding="0" cellspacing="0"
								border="0">
								<tr>
									<c:forEach var="gd" items="${goods }">
										<td>
											<table width="100%" cellpadding="0" cellspacing="0"
												border="0">
												<tr>
													<td sytle="height:60px;">
														<dl
															style="width: 100%; height: 200px; padding-right: 10px;">
															<dd style="margin-left: 0;">
																<a
																	href="${pageContext.request.contextPath}/goods.action?method=queryDetail&goodsId=${gd.goods_id}">
																	<img width="105" height="110"
																	src="${pageContext.request.contextPath}/${gd.goods_pic}" />
																</a>
															</dd>
															<dt style="margin-left: 0; width: 90%">
																<a
																	href="${pageContext.request.contextPath}/goods.action?method=queryDetail&goodsId=${gd.goods_id}">
																	<font size="2"> ${gd.goods_name } </font>
																</a>
															</dt>
															<dt>
																<font size="2">￥: ${gd.mall_price }</font>
															</dt>
														</dl>
													</td>
												</tr>
											</table>
										</td>
									</c:forEach>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--左边的 -->

		<!-- 右边的用户登录。-->
		<div class="page_other_msg right">
			<div class="left_row">
				<div class="list">
					<div class="list_bar">用户登录</div>
					<div class="list_content">
						<div id="div">
							<!-- 包含登录页面 -->
							<jsp:include flush="true" page="userinfo/userlogin.jsp"></jsp:include>
						</div>
					</div>
				</div>
			</div>
			<div class="left_row">

			</div>
		</div>

		<div style="clear: both"></div>
		<!-- 右边的用户登录。-->
	</div>



	<!-- 包含尾部页面 -->

	<jsp:include flush="true" page="inc/incFoot.jsp"></jsp:include>




	<script language="javascript" type="text/javascript"
		src="qiantai/qimg/png.js">
		
	</script>

</body>
</html>