/**
 * 
 */
package com.ifill.workbench.dao;

import java.sql.Types;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.common.metadata.dao.Item;
import com.ifill.common.utils.IfillConstants;
import com.ifill.workbench.vo.Pumps;

/**
 * @author Sandy
 *
 */
@Service
public class AdminDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private static String CREATE_PUMP = "insert into pumps(pump_id, product_id, name, status) values(?,?,?,?)";
	private static String DELETE_PUMP = "update pumps set status = ? where pump_id = ? and product_id = ?";
	private static String ADD_PRODUCT = "insert into products(product_id, product_type, name, desc, unit_price) values(?,?,?,?,?)";
	private static String UPDATE_PRODUCT = "update products set product_type=?, name=?, desc=?, unit_price=? where product_id = ?";
	
	public void createPump(Pumps pump){
		
		Object[] params = {pump.getPumpid(), pump.getFuelType(), pump.getPumpName(), pump.getStatus()};
		int[] types = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		try{
			jdbcTemplate.update(CREATE_PUMP, params, types);
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	public void deletePump(Pumps pump){
		
		Object[] params = {IfillConstants.CONSTANTS_INACTIVE, pump.getPumpid(), pump.getFuelType()};
		int[] types = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		try{
			jdbcTemplate.update(DELETE_PUMP, params, types);
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	public void addProduct(Item item){
		
		Object[] params = {item.getProductId(), item.getProductType(), item.getName(), item.getDesc(), item.getUnitPrice()};
		int[] types = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.DOUBLE};
		try{
			jdbcTemplate.update(ADD_PRODUCT, params, types);
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	public void updateProduct(Item item){
		
		Object[] params = {item.getProductType(), item.getName(), item.getDesc(), item.getUnitPrice(), item.getProductId()};
		int[] types = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.DOUBLE, Types.VARCHAR};
		try{
			jdbcTemplate.update(UPDATE_PRODUCT, params, types);
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
}
