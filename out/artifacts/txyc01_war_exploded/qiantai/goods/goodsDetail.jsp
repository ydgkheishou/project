<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!-- 引入格式化标签库 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="${pageContext.request.contextPath}/css/layout.css" type="text/css" rel="stylesheet" />
		
		<script language="JavaScript" src="${pageContext.request.contextPath}/js/public.js" type="text/javascript"></script>
		<!-- 引入jQuery库文件 -->
		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script>
	        function buy1()
	        {
	           // 判断用户是否登录了，如果没有登录，提示他去登录
	               <c:if  test="${empty user}">
	                alert("请去右边的登录板块去登录，登录后才能买宝贝！");
	                 return;
	               </c:if>
	               //用户已登录，user不为空，允许表单提交
	               $('#buyForm').submit();
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
		  	                <div class="list_bar">&nbsp;详情</div>
						  	<form action="${pageContext.request.contextPath}/goods.action?method=addToCart" method="post" name="buy"  id="buyForm">
                                  <table border="0" cellpadding="6">
                                      <tr><td width="30"></td><td style="font-size: 11px;">品名：</td><td style="font-size: 11px;">${gd.goods_name }</td></tr>
                                      <tr><td width="30"></td><td style="font-size: 11px;">简介：</td><td style="font-size: 11px;">${gd.goods_miaoshu }</td></tr>
                                      <tr><td width="30"></td><td style="font-size: 11px;">市场价：</td><td style="font-size: 11px;">${gd.market_price }</td></tr>
                                      <tr><td width="30"></td><td style="font-size: 11px;">商城价：</td><td style="font-size: 11px;color:red">${gd.mall_price }</td></tr>
                                      <tr><td width="30"></td><td style="font-size: 11px;">图片：</td><td style="font-size: 11px;"><img width="300xp" height="300xp" src="${pageContext.request.contextPath }/${gd.goods_pic}"/></td></tr>
                                        <tr><td width="30"></td><td style="font-size: 11px;">产地：</td><td style="font-size: 11px;">${gd.goods_address }</td></tr>
                                      <tr><td width="30"></td><td style="font-size: 11px;">
										  上市时间：</td><td style="font-size: 11px;">
                                        <%--使用格式化标签将日期值格式化成年月日形式--%>
										  <fmt:formatDate value="${gd.enter_date}" pattern="yyyy-MM-dd"></fmt:formatDate>
									   </td>
									  </tr>
                                     
                                     
                                       <tr><td width="30"></td><td style="font-size: 11px;">购买数量：</td><td style="font-size: 11px;"><input type="text" name="quantity" value="1" size="8" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></td></tr>
                                        <tr><td width="30"></td><td style="font-size: 11px;">
                                          <!-- 隐藏域，保存当前商品的编号，传到购物车页面上 -->
                                        <input type="hidden" name="goodsId" value="${gd.goods_id }"/>
                                         <!--隐藏域，保存商品名称 -->
                                         <input type="hidden" name="goodsName" value="${gd.goods_name }"/>
                                         <!--隐藏域，保存商品价格 -->
                                         <input type="hidden" name="goodsPrice" value="${gd.mall_price }"/>
                                        <a href="javascript:void(0)" onclick="buy1()"><img  src="${pageContext.request.contextPath}/images/icon_buy.gif"/></a></td><td style="font-size: 11px;"></td></tr>
                                  </table>
                            </form>
                            
		             </div>
		         </div>	
	        </div>
			<!-- 右边的-->
			<div class="page_other_msg right">
				<div class="left_row">
					<div class="list">
						<div class="list_bar">
							用户登录
						</div>
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
