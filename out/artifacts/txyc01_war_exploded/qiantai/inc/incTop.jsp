<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 引入核心标签库 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 导入头部，尾部的公共样式表 -->
<link href="${pageContext.request.contextPath}/css/mall.css"
	type="text/css" rel="stylesheet" />
<script type="text/javascript">
  //点击"我的信息"
	function myXinxi() {
		<c:if  test="${empty user}">
		alert("请去右边的登录板块去登录！");
		return;
		</c:if>

		var url = "${pageContext.request.contextPath}/qiantai/userinfo/userXinxi.jsp";
		window.open(url, "_blank");
	}
	//点击“我的购物车”
	function myCart() {

		<c:if  test="${empty user}">
		alert("请去右边的登录板块去登录！");
		return;
		</c:if>
		//已登录，跳转到购物车页面
		location.href = "${pageContext.request.contextPath}/qiantai/myCart/myCart.jsp";
	}
    //点击“我的订单”
	function myOrder() {
		<c:if  test="${empty user}">
		alert("请去右边的登录板块去登录！");
		return;
		</c:if>
		 //跳转到后台servlet，调用queryOrders方法，传用户的id过去
		var s = "${pageContext.request.contextPath}/order.action?method=queryOrders&uid=${user.user_id}";
		window.location.href = s;
	}
</script>



<div id="ContainerPanel" style="display: none;">
	<div id="calendarPanel"
		style="position: absolute; display: none; z-index: 9999; background-color: #FFFFFF; border: 1px solid #CCCCCC; width: 175px; font-size: 12px; margin-left: 25px;"></div>
</div>


<div class="zt">
	<div id="H">
		<table width="1000" border="0" align="center" cellpadding="0"
			cellspacing="0"
			style="font-size: 12px; line-height: 23px; color: #eee;">
			<tbody>
				<tr>
					<td width="750" class="notice" align="left"></td>

				</tr>
			</tbody>
		</table>
		<div id="CImage-332778-43073-2">
			<img
				src="${pageContext.request.contextPath}/qiantai/qimg/header-1.jpg"
				border="0" alt="">
		</div>
	</div>
</div>
<div id="A">
	<div id="CMenuMultiLevel-332774-43069-2">
		<div class="markermenu">
			<table>
				<tbody>
					<tr>
						<td><a href="${pageContext.request.contextPath}/index.jsp"
							target="_self">网站首页</a></td>
						<td><img
							src="${pageContext.request.contextPath}/qiantai/qimg/line.gif"
							width="1px" height="13px"></td>


						<td><img
							src="${pageContext.request.contextPath}/qiantai/qimg/line.gif"
							width="1px" height="13px"></td>
						<td><a
							href="${pageContext.request.contextPath}/goods.action?method=queryByPage"
							target="_self" rel="CMenuMultiLevel-332774-43069-213" class="">商品列表</a></td>


						<td><img
							src="${pageContext.request.contextPath}/qiantai/qimg/line.gif"
							width="1px" height="13px"></td>

						<td><img
							src="${pageContext.request.contextPath}/qiantai/qimg/line.gif"
							width="1px" height="13px"></td>
						<td><A href="javascript:void(0)" onclick="myXinxi()"
							target="_self" rel="CMenuMultiLevel-332774-43069-213">我的信息</A></td>
						<td><img
							src="${pageContext.request.contextPath}/qiantai/qimg/line.gif"
							width="1px" height="13px"></td>

						<td><img
							src="${pageContext.request.contextPath}/qiantai/qimg/line.gif"
							width="1px" height="13px"></td>
						<td><A href="javascript:void(0)" onclick="myCart()"
							target="_self" rel="CMenuMultiLevel-332774-43069-213">我的购物车</A></td>
						<td><img
							src="${pageContext.request.contextPath}/qiantai/qimg/line.gif"
							width="1px" height="13px"></td>

						<td><img
							src="${pageContext.request.contextPath}/qiantai/qimg/line.gif"
							width="1px" height="13px"></td>
						<td><A href="javascript:void(0)" onclick="myOrder()"
							rel="CMenuMultiLevel-332774-43069-213">我的订单</A></td>
						<td><img
							src="${pageContext.request.contextPath}/qiantai/qimg/line.gif"
							width="1px" height="13px"></td>

						<td><img
							src="${pageContext.request.contextPath}/qiantai/qimg/line.gif"
							width="1px" height="13px"></td>
						<td><a
							href="${pageContext.request.contextPath}/qiantai/lianxi/lianxi.jsp"
							target="_self">联系我们</a></td>




					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>


<form id="searchForm"
	action="${pageContext.request.contextPath}/goods.action?method=queryByPage"
	method="post">
	<div class="topsearch">
		<div class="title"></div>
		<div id="page_search_left">
			<!-- 使用隐藏域将要查询的页号封装起来 -->
             <input type="hidden" name="pageNum" id="currentPage"  value="1">
			<input class="inputText" id="goodsName" size="16"
				onkeypress="if(event.keyCode==13){searchFormSubmit();return false;}"
				name="goodsName" type="text" value="${keyword}"/>
		</div>

		<div id="page_search_btn">
			<input type="submit" value="商品搜索">&nbsp;&nbsp;&nbsp; </b>
		</div>

		<div id="page_search_right"></div>
		<div style="clear: both"></div>
	</div>
</form>
