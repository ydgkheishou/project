<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 导入核心标签库 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/layout.css"
	type="text/css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/public.js"
	type="text/javascript"></script>

	<script>
		//点击“删除”按钮时调用的函数
		function deleteItem(goodsId){
			var flag=confirm("确认删除此购物项吗？");
			if (flag){
				//请求Servlet,执行删除
				location.href="${pageContext.request.contextPath}/goods.action?method=deleteItem&goodsId="+goodsId;
			}
		}
		//点击“清空购物车”超链接时调用的函数
		function clearItem(){
			var flag=confirm("确认清空购物车吗？");
			if(flag){
				//请求Servlet,执行清空
				location.href="${pageContext.request.contextPath}/goods.action?method=clearItem";
			}
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
					<div class="list_bar">&nbsp;我的购物车</div>
					<!-- 判断session中是否有购物车数据，如果没有，显示“您的购物车空空如也”，否则就显示购物车的数据到表格中 -->
					<c:choose>
						<c:when test="${empty  cart}">
							<h2>您的购物车空空如也</h2>
							<!-- 显示继续购物的图片 -->
							<a href="${pageContext.request.contextPath}/goods.action?method=queryByPage"><img
								border="0"
								src="${pageContext.request.contextPath}/images/Car_icon_02.gif" /></a>
						</c:when>
						<%--如果把所有勾选项都移除了，此时cart中的Map集合是空集--%>
						<c:when test="${empty cart.cartMap}">
							<h2>您的购物车空空如也</h2>
							<!-- 显示继续购物的图片 -->
							<a href="${pageContext.request.contextPath}/goods.action?method=queryByPage"><img
									border="0"
									src="${pageContext.request.contextPath}/images/Car_icon_02.gif" /></a>
						</c:when>
						<c:otherwise>
							<table width="99%" border="0" cellpadding="2" cellspacing="1"
								bgcolor="#FFFFFF" align="center" style="margin-top:8px">
								<tr align="center" bgcolor="#FAFAF1" height="22">
									<td>商品名称</td>
									<td>价格</td>
									<td>数量</td>
									<td>金额</td>
									<td>删除</td>
								</tr>
								<c:forEach var="entry" items="${cart.cartMap }">
									<tr align='center' bgcolor="#FFFFFF" height="22">
										<td>${entry.value.goods.goods_name }</td>
										<td>${entry.value.goods.mall_price }<br /></td>
										<td>${entry.value.quantity}</td>
										<td>￥${entry.value.money }</td>
										<td><input type="image"
											src="${pageContext.request.contextPath}/images/delete_01.gif"
											border="0" onclick="deleteItem(${entry.key})" /></td>
									</tr>
								</c:forEach>
								<tr>
									<td colspan="6" class="Order_Total"><img hspace="5"
										src="${pageContext.request.contextPath}/images/me03.gif" />
										总金额：￥<span id="totalMoney">${cart.totalPrice }</span>
									</td>
								</tr>
							</table>
							<table>
								<tr height="7">
									<td></td>
								</tr>
								<tr>
									<td width="120"></td>
									<td>
									 <a href="javascript:void(0)" onclick="clearItem()"><img border="0"
											src="${pageContext.request.contextPath}/images/Car_icon_01.gif" /></a>
									</td>
									<td>
										 <!-- 点击”继续购物“，跳转到商品列表页面 -->
										<a
										href="${pageContext.request.contextPath}/goods.action?method=queryByPage"><img
											border="0"
											src="${pageContext.request.contextPath}/images/Car_icon_02.gif" /></a></td>
									<td>
									 <!-- 点击“下一步”，直接跳转到订单确认的页面 -->
									<a
										href="${pageContext.request.contextPath}/qiantai/order/orderQueren.jsp"><img
											border="0"
											src="${pageContext.request.contextPath}/images/Car_icon_03.gif" /></a></td>
								</tr>
							</table>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
		</div>
		<!--左边的 -->
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
