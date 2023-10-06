<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productDAO" class="shop.dao.ProductRepository"/>
<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/link.jsp" />
</head>
<body> 
	<% 
		String root = request.getContextPath(); 
		String loginId = (String) session.getAttribute("loginId");
		String ship_status = "비회원 주문";
		if( loginId != null && !loginId.isEmpty() ) {
			ship_status = "회원 주문";
		}
		
		//쿠키에 저장된 주문정보 불러오기
		String cartId = session.getId();
		
		String ship_cartId="";
		String ship_name="";
		String ship_date="";
		String ship_country="";
		String ship_zipCode="";
		String ship_addressName="";
		String ship_phone = "";
		
		Cookie[] cookies = request.getCookies();
		
		if( cookies != null){
			for(int i =0; i < cookies.length; i++){
				Cookie cookie = cookies[i];
				String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode(cookie.getValue());
				
				switch(cookieName){
					case "ship_cartId" : ship_cartId = cookieValue;  break;
					case "ship_name" : ship_name = cookieValue;  break;
					case "ship_date" : ship_date = cookieValue;  break;
					case "ship_country" : ship_country = cookieValue;  break;
					case "ship_zipCode" : ship_zipCode = cookieValue;  break;
					case "ship_addressName" : ship_addressName = cookieValue;  break;
					case "ship_phone" : ship_phone = cookieValue;  break;
				}
			}
		}
		
		List<Product> cartList = (List<Product>) session.getAttribute("cartList");
		if( cartList == null ) cartList = new ArrayList<Product>();
	%>
	<jsp:include page="/layout/header.jsp"/>
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 정보</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
				<a href="<%= root %>/shop/products.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품목록</a>
				<button type="button" class="btn btn-outline-secondary btn-lg px-4">로그인</button>
			</div>
		</div>
	</div>
	
	<!-- 주문 확인 영역 -->
	<div class="container mb-5">
	<form action="complete.jsp" method="post">
		<div class="text-center">
			<h1>영수증</h1>
		</div>
		<!-- 배송정보 -->
		<div class="ship-box">
			<table class="table">
				<tr>
					<td>주문 형태 :</td>
					<td><%= ship_status %></td>
				</tr>
				<tr>
					<td>성 명 :</td>
					<td><%= ship_name %></td>
				</tr>
				<tr>
					<td>우편번호 :</td>
					<td><%= ship_zipCode%></td>
				</tr>
				<tr>
					<td>주 소 :</td>
					<td><%= ship_addressName%></td>
				</tr>
				<tr>
					<td>배송일 :</td>
					<td><%= ship_date %></td>
				</tr>
				<tr>
					<td>전화번호 :</td>
					<td><%= ship_phone %></td>
				</tr>
		<%
			if( loginId == null || loginId.isEmpty() ){
		%>	
				<tr>
					<td>주문 비밀번호 :</td>
					<td><input type="text" class="form-control col-md-10" name="orderpw"></td>
				</tr>

		<%
			}
		%>
			</table>
		</div>
		<!-- 주문정보 -->
		<div class="cart-box">
			<table class="table table-striped table-hover table-bordered text-center">
			<thead>
				<tr class="table-primary">
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<%
					int sum = 0;
					for(int i = 0; i < cartList.size(); i++){
						Product product = cartList.get(i);		
						int total = product.getUnitPrice()	* product.getQuantity();
						sum += total;
				%>
				<tr>
					<td><%= product.getName() %></td>
					<td><%= product.getUnitPrice() %></td>
					<td><%= product.getQuantity() %></td>
					<td><%= total %></td>
					<td><a href="" class="btn btn-danger">삭제</a></td>
				</tr>			
				<%
					}
				%>
			</tbody>
			<tfoot>
			<%
				if(cartList.isEmpty()){
			%>
				<tr>
					<td colspan="5">추가된 상품이 없습니다.</td>
				</tr>
			<% } else { %>	
				<tr>
					<td></td>
					<td></td>
					<td>총액</td>
					<td><%= sum %></td>
					<td></td>
				</tr>
			<%
				}
			%>
			</tfoot>
			</table>
	
		</div>
	
		<!-- 버튼 영역 -->
		<div class="d-flex justify-content-between mt-5 mb-5">
			<div class="item">
				<a href="javascript: history.back()" class="btn btn-lg btn-success">이전</a>
					<a href="<%= root %>/index.jsp" class="btn btn-lg btn-danger">취소</a>
			</div>
			<div class="item">				
				<input type="submit" class="btn btn-lg btn-primary" value="주문완료" />
			</div>
		</div>
	
	</form>
	</div>
	
	<jsp:include page="/layout/footer.jsp"/>
	<jsp:include page="/layout/script.jsp" />
</body>
</html>