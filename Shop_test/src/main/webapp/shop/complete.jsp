<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Order"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="orderDAO" class="shop.dao.OrderRepository"/>
<jsp:useBean id="IODAO" class="shop.dao.ProductIORepository"/>
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
		
		//주문 완료 후, sessionId로 주문번호를 확인
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
		int sum = 0;
		for(int i = 0; i < cartList.size(); i++){
			Product product = cartList.get(i);		
			int total = product.getUnitPrice()	* product.getQuantity();
			sum += total;
		}
		
		Order order = new Order();
		
		String orderPw = request.getParameter("orderpw");
		
		order.setShipName(ship_name);
		order.setZipCode(ship_zipCode);
		order.setCountry(ship_country);
		order.setAddress(ship_addressName);
		order.setDate(ship_date);
		order.setUserId(loginId);
		order.setPhone(ship_phone);
		order.setOrderPw(orderPw);
		order.setTotalPrice(sum);
		
		int result = orderDAO.insert(order);
		
		
		
		
		
		// 주문 완료 후, 장바구니 목록 전체 삭제 (session 만료)
		session.invalidate();
		
		// 배송 정보를 저장한 쿠키는 삭제
		if( cookies != null ) {
			for(int i = 0 ; i < cookies.length ; i++) {
				Cookie cookie = cookies[i];
				String cookieName = cookie.getName();
				cookie.setValue("");
				switch(cookieName) {
				 	case "ship_cartId" 			: cookie.setMaxAge(0); break;
				 	case "ship_name" 			: cookie.setMaxAge(0); break;
				 	case "ship_date" 			: cookie.setMaxAge(0); break;
				 	case "ship_country" 		: cookie.setMaxAge(0); break;
				 	case "ship_zipCode" 		: cookie.setMaxAge(0); break;
				 	case "ship_addressName" 	: cookie.setMaxAge(0); break;
				}
				response.addCookie(cookie);
			}
		}
	%>
	<jsp:include page="/layout/header.jsp"/>
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 완료</h1>
	</div>
	
	<!-- 주문 완료 확인 -->
	<div class="container mb-5 p-5">
		<h2>주문이 완료되었습니다.</h2>
		<p>주문번호 : <%= ship_cartId %></p>
		<p>배송지 : <%= ship_addressName%></p>
	</div>
	<div class="d-flex justify-content-center mt-5 mb-5">
		<div class="item">
			<a href="<%= root %>/user/order.jsp" class="btn btn-lg btn-primary">주문내역</a>
		</div>

	</div>
	<jsp:include page="/layout/footer.jsp"/>
	<jsp:include page="/layout/script.jsp" />
</body>
</html>