<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!-- 导入核心标签库 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link href="${pageContext.request.contextPath}/css/layout.css"
          type="text/css" rel="stylesheet"/>

    <script language="JavaScript"
            src="${pageContext.request.contextPath}/js/public.js"
            type="text/javascript"></script>

    <!-- 引入jQuery库文件 -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
        function buy1() {
            <s:if test="#session.user==null">
            alert("请先登录");
            </s:if>
            <s:else>
            if (document.buy.quantity.value == "") {
                alert("请输入购买数量");
                return false;
            }
            document.buy.submit();
            </s:else>
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
                <div class="list_bar">&nbsp;所有商品</div>
                <c:choose>
                    <c:when test="${empty pb.list }">
                        <h2>当前没有任何商品</h2>
                    </c:when>
                    <c:otherwise>
                        <table width="99%" border="0" cellpadding="2" cellspacing="1"
                               bgcolor="#FFFFFF" align="center" style="margin-top:8px">
                                    <tr align="center" bgcolor="#FAFAF1" height="22">
                                    <td>商品名称</td>
                                    <td>市场价</td>
                                    <td>商品图片</td>
                                    <td>操作</td>
                                    </tr>
                                    <c:forEach var="gd" items="${pb.list }">
                                    <tr align='center' bgcolor="#FFFFFF" height="22">
                                    <td>${gd.goods_name }</td>
                                    <td>￥${gd.market_price } <br/></td>
                                    <td><a
                                    href="${pageContext.request.contextPath}/goods.action?method=queryDetail&goodsId=${gd.goods_id}">
                                        <img
                                                src="${pageContext.request.contextPath}/${gd.goods_pic}"
                                                width="60" height="60" border="0"/>
                                    </a></td>
                                    <td><a
                                            href="${pageContext.request.contextPath}/goods.action?method=queryDetail&goodsId=${gd.goods_id}">
                                        <img
                                            alt=""
                                            src="${pageContext.request.contextPath}/images/icon_buy.gif"
                                            border=0/></a></td>
                                </tr>
                            </c:forEach>
                        </table>
                        当前第${pb.pageNum }页，每页<font color="red">${pb.pageSize }</font>条/共<font
                        color="red">${pb.totalCount }</font>条记录
                        <!-- 当前页号>1时，给用户提供上一页超链接；否则直接显示“上一页” -->
                        <c:choose>
                            <c:when test="${pb.pageNum gt 1}">
                                <a href="javascript:void(0)"
                                   onclick="changePageNum(${pb.pageNum-1})">上一页</a>
                            </c:when>
                            <c:otherwise>上一页</c:otherwise>
                        </c:choose>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <!-- 遍历所有的页号 -->
                        <c:forEach var="sn" begin="1" end="${pb.totalPage }">
                            <a href="javascript:void(0)" onclick="changePageNum(${sn })">${sn }</a>&nbsp;&nbsp;
                        </c:forEach>

                        <!-- 当前页号<总页数时，给用户提供下一页超链接；否则直接显示“下一页” -->
                        <c:choose>
                            <c:when test="${pb.pageNum lt pb.totalPage}">
                                <a href="javascript:void(0)"
                                   onclick="changePageNum(${pb.pageNum+1})">下一页</a>
                            </c:when>
                            <c:otherwise>下一页</c:otherwise>
                        </c:choose>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <!-- 尾页 -->
                        <a href="javascript:void(0)"
                           onclick="changePageNum(${pb.totalPage})">尾页</a>
                    </c:otherwise>
                </c:choose>

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

<script>
 //改变页号的函数
function changePageNum(pageNum){
    //改变表单中隐藏域封装的页号
    $("#currentPage").val(pageNum);
    //提交表单
    $("#searchForm").submit();
 }
</script>
</body>
</html>
