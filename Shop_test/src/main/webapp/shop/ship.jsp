<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productDAO" class="shop.dao.ProductRepository" />
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

	%>
	<jsp:include page="/layout/header.jsp"/>
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">배송 정보</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
				<a href="<%= root %>/shop/products.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품목록</a>
				<button type="button" class="btn btn-outline-secondary btn-lg px-4">로그인</button>
			</div>
		</div>
	</div>
	
	<!-- 배송 정보 입력 -->
	<div class="container mb-5 p-4">
		<form action="ship_pro.jsp" class="form-horizontal" method="post">
			<input type="hidden" name="cartId" value="<%= request.getParameter("cartId") %>" />
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">성명</label>
				<input type="text" class="form-control col-md-10" name="name">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">배송일</label>
				<input type="text" class="form-control col-md-10" name="shippingDate">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">국가명</label>
				<input type="text" class="form-control col-md-10" name="country">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">우편변호</label>
				<input type="text" class="form-control col-md-10" name="zipCode">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">주소</label>
				<input type="text" class="form-control col-md-10" name="addressName">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">전화번호</label>
				<input type="text" class="form-control col-md-10" name="phone">
			</div>
			
			<div class="d-flex justify-content-between mt-5 mb-5">
				<div class="item">
					<a href="javascript: history.back()" class="btn btn-lg btn-success">이전</a>
					<a href="<%= root %>/index.jsp" class="btn btn-lg btn-danger">취소</a>
				</div>
				<div class="item">				
					<input type="submit" class="btn btn-lg btn-primary" value="등록" />
				</div>
			</div>
		</form>
	</div>
	
	
	<jsp:include page="/layout/footer.jsp"/>
	<jsp:include page="/layout/script.jsp" />
</body>
</html>