package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;
		String sql = " INSERT INTO product_io (product_id, type, amount) "				
				   + " VALUES( ?, 'OUT' ) ";
		
		int no = 1;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(no++, product.getProductId());
			psmt.setInt(no++, product.getQuantity());
			result = psmt.executeUpdate();			// 상품 등록 요청
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;		
	}
	

}