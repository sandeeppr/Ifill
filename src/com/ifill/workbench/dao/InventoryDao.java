/**
 * 
 */
package com.ifill.workbench.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.common.utils.CommonUtils;
import com.ifill.workbench.vo.DipReading;
import com.ifill.workbench.vo.MiscExpenses;
import com.ifill.workbench.vo.PumpFeed;
import com.ifill.workbench.vo.Sales;
import com.ifill.workbench.vo.StockData;

/**
 * @author Sandy
 *
 */
@Service
public class InventoryDao {

	private static String SAVE_PUMP_FEED = "INSERT INTO daily_pump_readings(PUMP_ID, DAY_DATE, READING_IN_LITERS, PUMP_TEST, EFFC_SALE_IN_LITERS, EFFC_SALE_IN_RS, MECH_READING_IN_LTRS, EFFC_MECH_SALE_LTRS, EFFC_MECH_SALE_RS, VARIATION_IN_SALES) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; 
	private static String SAVE_STOCK = "INSERT INTO stock_reciept(PRODUCT_ID, RECIEPT_DATE, QUANTITY) VALUES (?,?,?)";
	private static String SAVE_SALE = "INSERT INTO sales(SALES_ID, DATE_OF_SALE, QUANTITY_OF_SALE, TOTAL_AMOUNT_OF_SALE, SALE_TYPE, CUSTOMER_ID, CUSTOMER_NAME, PRODUCT) VALUES (?,?,?,?,?,?,?,?)";
	private static String SAVE_EXPENSES = "INSERT INTO misc_expenses(DESCRIPTION, AMOUNT, EXPNS_DATE) VALUES (?,?,?)";
	private static String SAVE_DIPS = "INSERT INTO dailydips(FUEL, DATE, DIP) VALUES (?,?,?)";
	private static String SAVE_LUBES_SALE = "INSERT INTO lubes_sales(PRODUCT,DATE,UNITS, SALES_IN_RS) VALUES (?,?,?,?)";
	private static String SAVE_CREDIT_RECOVERY = "INSERT INTO credit_recovery(CUSTOMER_ID, DATE_OF_RECOVERY, AMOUNT, MODE_OF_PAYMENT) VALUES (?,?,?,?)";
	private static String FIND_LD_READINGS = "SELECT reading_in_liters FROM daily_pump_readings WHERE pump_id = ? AND day_date = DATE(?) - INTERVAL 1 DAY";
	
	private static String DEL_PUMP_FEED = "delete FROM daily_pump_readings where pump_id = ? AND day_date = ?";
	private static String DEL_STOCK = "DELETE FROM stock_reciept WHERE product_id = ? AND reciept_date = ?";
	private static String DEL_SALE = "DELETE FROM sales WHERE sales_id = ? AND date_of_sale = ? AND sale_type = ?";
	private static String DEL_RECOVERY = "DELETE FROM credit_recovery WHERE customer_id = ? AND date_of_recovery = ?";
	private static String DEL_EXPENSES = "DELETE from misc_expenses WHERE expense_id = ?";
	private static String DEL_DIPS = "DELETE FROM dailydips WHERE Fuel = ? AND date = ? AND Dip = ?";
	private static String DEL_LUBE_SALES = "DELETE from lubes_sales WHERE sale_id = ?";
	
	private static String KEY_SEPERATOR = "~";
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void savePumpFeed(PumpFeed feed){
		//System.out.println(feed.getDayDate());
		Object[] params = {feed.getPumpId(),feed.getDayDate(),feed.getQuantity(), feed.getPumpTest(), feed.getEffcSaleLtrs(), feed.getEffcSaleRs(), feed.getMechReading(), feed.getEffcMechSaleLtrs(), feed.getEffcMechSaleRs(), feed.getEffcMechSaleLtrs()-feed.getEffcSaleLtrs()};
		int[] types = {Types.VARCHAR, Types.DATE, Types.DOUBLE, Types.DOUBLE, Types.DOUBLE, Types.DOUBLE, Types.DOUBLE, Types.DOUBLE, Types.DOUBLE, Types.DOUBLE};

		try{
			jdbcTemplate.update(SAVE_PUMP_FEED, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	// delete operation
	public void deletePumpFeed(String key){
		System.out.println("key : "+key);
		
		// split key
		String[] compoundKeys = key.split(KEY_SEPERATOR);
		
		Object[] params = {compoundKeys[0],CommonUtils.getDate(compoundKeys[1])};
		int[] types = {Types.VARCHAR, Types.DATE};

		try{
			jdbcTemplate.update(DEL_PUMP_FEED, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
		
	}
	
	public void saveStockReciept(StockData data){
		//System.out.println(data.getDate());
		Object[] params = {data.getProduct(),data.getDate(),data.getQuantity()};
		int[] types = {Types.VARCHAR, Types.DATE, Types.DOUBLE};

		try{
			jdbcTemplate.update(SAVE_STOCK, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
		
	}
	
	// delete for stock 
	public void deleteStockReciept(String key){
		System.out.println(key);
		// split key
		String[] compoundKeys = key.split(KEY_SEPERATOR);
		System.out.println(compoundKeys[0] + "--"+CommonUtils.getDate(compoundKeys[1]));
		Object[] params = {compoundKeys[0],CommonUtils.getDate(compoundKeys[1])};
		int[] types = {Types.VARCHAR, Types.DATE};
		
		try{
			jdbcTemplate.update(DEL_STOCK, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
		
	}
	
	public void saveCreditSales(Sales data){
		
		Object[] params = {data.getBillno(), data.getDate(), data.getQuantity(), data.getSaleInRs(), data.getSaleType(),data.getCustomerId(), data.getName(), data.getType()};
		int[] types = {Types.VARCHAR, Types.DATE, Types.DOUBLE, Types.DOUBLE,Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};

		try{
			jdbcTemplate.update(SAVE_SALE, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	// delete credit sales
	public void deleteCreditSales(String key){
		
		// split key
		String[] compoundKeys = key.split(KEY_SEPERATOR);
		
		Object[] params = {compoundKeys[0],CommonUtils.getDate(compoundKeys[1]), "CREDIT"};
		int[] types = {Types.VARCHAR, Types.DATE, Types.VARCHAR};
		
		try{
			jdbcTemplate.update(DEL_SALE, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
		
	}
	
	public void saveCreditRecovery(Sales data){
		
		Object[] params = {data.getCustomerId(), data.getDate(), data.getSaleInRs(), data.getModeOfPayment()};
		int[] types = {Types.VARCHAR, Types.DATE, Types.DOUBLE, Types.VARCHAR};

		try{
			jdbcTemplate.update(SAVE_CREDIT_RECOVERY, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	// delete for recovery
	public void deleteCreditRecovery(String key){
		
		// split key
		String[] compoundKeys = key.split(KEY_SEPERATOR);
		
		Object[] params = {compoundKeys[0],CommonUtils.getDate(compoundKeys[1])};
		int[] types = {Types.VARCHAR, Types.DATE};
		
		try{
			jdbcTemplate.update(DEL_RECOVERY, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	
	public int saveExpenses(MiscExpenses expenses){
		Object[] params = {expenses.getDesc(), expenses.getAmount(), expenses.getDate()};
		int[] types = {Types.VARCHAR, Types.DOUBLE, Types.DATE};
	
		try{
			jdbcTemplate.update(SAVE_EXPENSES, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
		
		int autoIncKeyFromFunc = -1;
		List<Integer> ids = jdbcTemplate.queryForList("SELECT IFNULL(max(expense_id),0) as id FROM misc_expenses", Integer.class);
		if(ids != null){
		 autoIncKeyFromFunc = ids.get(0);
		}
		
		return autoIncKeyFromFunc;
			
	}
	
	// delete expenses
	public void deleteExpenses(String key){
		
		Object[] params = {key};
		int[] types = {Types.VARCHAR};
		
		try{
			jdbcTemplate.update(DEL_EXPENSES, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
	}

	public void saveDips(DipReading data){
		Object[] params = {data.getProduct(),data.getDate(),data.getReading()};
		int[] types = {Types.VARCHAR, Types.DATE, Types.DOUBLE};
	
		try{
			jdbcTemplate.update(SAVE_DIPS, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	// delete dips
	public void deleteDips(String key){
		// split key
		String[] compoundKeys = key.split(KEY_SEPERATOR);
		
		Object[] params = {compoundKeys[0], CommonUtils.getDate(compoundKeys[1]), Double.valueOf(compoundKeys[2])};
		int[] types = {Types.VARCHAR, Types.DATE, Types.DOUBLE};
		
		try{
			jdbcTemplate.update(DEL_DIPS, params, types);
		}catch(DataAccessException dae){
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	public int saveLubes(Sales data){
		Object[] params = {data.getProduct(),data.getDate(),data.getQuantity(),data.getSaleInRs()};
		int[] types = {Types.VARCHAR, Types.DATE, Types.DOUBLE, Types.DOUBLE};
	
		try{
			jdbcTemplate.update(SAVE_LUBES_SALE, params, types);
		}catch(DataAccessException dae){
			throw new DataAccessLayerException(dae.getMessage());
		}
		
		 int autoIncKeyFromFunc = -1;
		 List<Integer> ids = jdbcTemplate.queryForList("SELECT IFNULL(max(sale_id),0) as id FROM lubes_sales", Integer.class);
		 if(ids != null){
			 autoIncKeyFromFunc = ids.get(0);
		 }
		 
		 return autoIncKeyFromFunc;
	}
	
	// delete lube sales
	public void deleteLubes(String key){
		
		Object[] params = {key};
		int[] types = {Types.INTEGER};
		
		try{
			jdbcTemplate.update(DEL_LUBE_SALES, params, types);
		}catch(DataAccessException dae){
			//TODO
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	public double findLDReadings(String pumpid, String curDate){
		
		List<Double> prices = null;
		Object[] params = {pumpid, CommonUtils.getDate(curDate)};
		int[] types = {Types.VARCHAR, Types.DATE};

		try{
			prices = jdbcTemplate.query(FIND_LD_READINGS,params,types,  new RowMapper<Double>() {
			      public Double mapRow(ResultSet resultSet, int i) throws SQLException {
			          return resultSet.getDouble(1);
			        }
			      });
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
		
		if(prices.size() < 1)
			return 0.0;
		return prices.get(0);
		
	}
	
}
