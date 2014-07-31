/**
 * 
 */
package com.ifill.common.metadata.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.common.utils.IfillConstants;


/**
 * @author Sandy
 *
 */
@Service
public class MetadataDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private static String NO_OF_PUMPS = "SELECT count(*) no_of_pumps FROM pumps WHERE product_id = ? AND status = 'ACTIVE'";
	private static String FIND_PUMPS_BY_PRODUCT = "SELECT pump_id FROM pumps WHERE product_id = ? AND status = 'ACTIVE'";
	private static String FUEL_PRICE = "SELECT unit_price from products where product_id = ?";
	private static String FIND_ALL_LUBES = "SELECT product_id FROM products WHERE product_type = 'LUBE'";
	private static String FIND_ALL_FUELS = "SELECT product_id FROM products WHERE product_type in ('HSD','MS')";
	private static String FIND_ALL_PRODUCTS = "SELECT product_id,product_type, name, desc, unit_price FROM products";
	
	public int findPumpsByType(long type){
		
		List<Map<String,Object>> result = jdbcTemplate.queryForList(NO_OF_PUMPS,type);
		return (int) result.get(0).get("no_of_pumps");
	}
	
	public List<String> findPumpsByFuel(String pid){
		
		List<String> pumps = new ArrayList<>();
		List<Map<String,Object>> result = jdbcTemplate.queryForList(FIND_PUMPS_BY_PRODUCT,pid);
		for(Map<String,Object> row : result){
			pumps.add(row.get("pump_id").toString());
		}
		return pumps;
	}
	
	public Double findPriceById(String id){
		List<Double> prices = null;
		Object[] params = {id};
		int[] types = {Types.VARCHAR};
		try{
			prices = jdbcTemplate.query(FUEL_PRICE,params,types,  new RowMapper<Double>() {
			      public Double mapRow(ResultSet resultSet, int i) throws SQLException {
			          return resultSet.getDouble(1);
			        }
			      });
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
		return prices.get(0);
	}
	
	public List<String> pullLubes(){
		List<String> lubes = new ArrayList<>();
		List<Map<String,Object>> result = jdbcTemplate.queryForList(FIND_ALL_LUBES);
		for(Map<String,Object> row : result){
			lubes.add(row.get("product_id").toString());
		}
		return lubes;
	}
	
	public List<String> findAllFuels(){
		List<String> fuels = new ArrayList<>();
		try{
			List<Map<String,Object>> result = jdbcTemplate.queryForList(FIND_ALL_FUELS);
			for(Map<String,Object> row : result){
				fuels.add(row.get("product_id").toString());
			}
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
		return fuels;
	}
	
	public List<Item> findAllProducts(){
		List<Item> products = new ArrayList<>();
		try{
			List<Map<String,Object>> result = jdbcTemplate.queryForList(FIND_ALL_PRODUCTS);
			for(Map<String,Object> row : result){
				Item item = new Item();
				item.setProductId(row.get(IfillConstants.CONSTANTS_PRODUCT_ID).toString());
				item.setProductType(row.get(IfillConstants.CONSTANTS_PRODUCT_TYPE).toString());
				item.setName(row.get(IfillConstants.CONSTANTS_NAME).toString());
				item.setDesc(row.get(IfillConstants.CONSTANTS_DESC).toString());
				item.setUnitPrice(Double.parseDouble(row.get(IfillConstants.CONSTANTS_UNIT_PRICE).toString()));		
				
				products.add(item);
			}
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
		return products;
	}
	
}

