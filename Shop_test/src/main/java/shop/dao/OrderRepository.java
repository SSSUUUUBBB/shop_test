package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		String sql = " INSERT INTO `order` (ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone) "				
				   + " VALUES( ?, ?, ?, ?, ?, ?, ?,?,? ) ";
		
		int no = 1;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(no++, order.getShipName());
			psmt.setString(no++, order.getZipCode());
			psmt.setString(no++, order.getCountry());
			psmt.setString(no++, order.getAddress());
			psmt.setString(no++, order.getDate());
			psmt.setString(no++, order.getOrderPw());
			psmt.setString(no++, order.getUserId());
			psmt.setInt(no++, order.getTotalPrice());
			psmt.setString(no++, order.getPhone());
			result = psmt.executeUpdate();			// 상품 등록 요청
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		
		
	}
	
}






























