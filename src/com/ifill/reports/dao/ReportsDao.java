/**
 * 
 */
package com.ifill.reports.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.common.utils.CommonUtils;
import com.ifill.reports.vo.ReportRespObject;
import com.ifill.reports.vo.ReportsResponseWrapper;

/**
 * @author Sandy
 *
 */
@Service
public class ReportsDao {
	
	private static String SUM_DAILY_SALES_FROM_PUMP_READINGS = "SELECT coalesce(SUM(effc_sale_in_rs),0) sale from daily_pump_readings where day_date = CURDATE() AND pump_id in (SELECT pump_id from pumps where status = 'ACTIVE' AND product_id = ?)";
	private static String SUM_DAILY_CREDITS = "SELECT coalesce(SUM(total_amount_of_sale),0) sale FROM sales where sale_type = 'CREDIT' AND date_of_sale = CURDATE()";
	private static String SUM_DAILY_CREDIT_RECOVERYS = "SELECT coalesce(SUM(amount),0) sale FROM credit_recovery where date_of_recovery = CURDATE()";
	private static String SUM_DAILY_LUBES_SALE = "SELECT coalesce(SUM(sales_in_rs),0) sale FROM lubes_sales where date = CURDATE()";
	private static String SUM_DAILY_EXPENSES = "select coalesce(SUM(amount),0) sale FROM misc_expenses where expns_date = CURDATE();";
	
	/*private static String READINGS_FOR_SALES_REPORT_PUMPS = "SELECT readings.*, pmps.product_id, 'Fuel' type from (SELECT CUR.pump_id, yes.opening, CUR.closing, (cur.closing - yes.opening) sales, cur.pump_test,totalSale, saleRs  from (SELECT pump_id, reading_in_liters closing, pump_test, effc_sale_in_liters totalSale, effc_sale_in_rs saleRs from daily_pump_readings where day_date = CURDATE()) cur, (SELECT pump_id,reading_in_liters opening from daily_pump_readings where day_date = CURDATE() - INTERVAL 1 DAY) yes WHERE cur.pump_id = yes.pump_id) readings, pumps pmps WHERE pmps.pump_id = readings.pump_id";
	private static String READINGS_FOR_SALES_REPORT_LUBES = "SELECT product, units, sales_in_rs, 'Lube' type from lubes_sales where date = CURDATE()";
	*/
	
	private static String READINGS_FOR_SALES_REPORT_PUMPS = "SELECT readings.*, pmps.product_id, 'Fuel' type from (SELECT CUR.pump_id, yes.opening, CUR.closing, (cur.closing - yes.opening) sales, cur.pump_test,totalSale, saleRs  from (SELECT pump_id, reading_in_liters closing, pump_test, effc_sale_in_liters totalSale, effc_sale_in_rs saleRs from daily_pump_readings where day_date = DATE(?)) cur, (SELECT pump_id,reading_in_liters opening from daily_pump_readings where day_date = DATE(?) - INTERVAL 1 DAY) yes WHERE cur.pump_id = yes.pump_id) readings, pumps pmps WHERE pmps.pump_id = readings.pump_id";
	private static String READINGS_FOR_SALES_REPORT_LUBES = "SELECT product, units, sales_in_rs, 'Lube' type from lubes_sales where date = DATE(?)";
	
	private static String CREDIT_REPORT = "SELECT tbl.* FROM ((SELECT customer_id, date_of_sale AS date,total_amount_of_sale as credit, 0 as recovery  from sales where sale_type = ? and customer_id = ?)  UNION "
											+"(SELECT customer_id, date_of_recovery as date, 0 as credit, amount as recovery from credit_recovery where customer_id = ?) ) tbl ORDER BY tbl.date";
	
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Map<String,String> generateCashReportData(){

		Map<String,String> sales = new HashMap<>();

		// pull sales from pump readings
		try{
			List<Map<String,Object>> result = jdbcTemplate.queryForList(SUM_DAILY_SALES_FROM_PUMP_READINGS,new Object[]{"MS"});
			
			for(Map<String,Object> row : result){
				sales.put("MS", row.get("sale").toString());
			}
			
			result = null;
			result = jdbcTemplate.queryForList(SUM_DAILY_SALES_FROM_PUMP_READINGS,new Object[]{"HSD"});
			
			for(Map<String,Object> row : result){
				sales.put("HSD", row.get("sale").toString());
			}
			
			
			// pull lubes sale
			result = null;
			result = jdbcTemplate.queryForList(SUM_DAILY_LUBES_SALE);
			
			for(Map<String,Object> row : result){
				sales.put("LUBES", row.get("sale").toString());
			}
			
			// pull credit sales
			result = null;
			result = jdbcTemplate.queryForList(SUM_DAILY_CREDITS);
			
			for(Map<String,Object> row : result){
				sales.put("CREDITS", row.get("sale").toString());
			}
			
			/*result = null;
			result = jdbcTemplate.queryForList(SUM_DAILY_CREDITS);
			
			for(Map<String,Object> row : result){
				sales.put("MS_CREDIT", row.get("sale").toString());
			}*/
			
			// pull credit recoveries
			result = null;
			result = jdbcTemplate.queryForList(SUM_DAILY_CREDIT_RECOVERYS);
			
			for(Map<String,Object> row : result){
				sales.put("CREDIT_RECOVERY", row.get("sale").toString());
			}
			
			//pull misc expenses
			result = null;
			result = jdbcTemplate.queryForList(SUM_DAILY_EXPENSES);
			
			for(Map<String,Object> row : result){
				sales.put("MISC_EXPENSES", row.get("sale").toString());
			}
			
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
		
		return sales;
	}
	
	public List<ReportRespObject> generateSalesReportData(){

		List<ReportRespObject> reportRespList = new ArrayList<>();

		// pull sales from pump readings
		try{
			List<Map<String,Object>> result = jdbcTemplate.queryForList(READINGS_FOR_SALES_REPORT_PUMPS);
			
			for(Map<String,Object> row : result){
				
				String pump = row.get("pump_id").toString();
				String type = row.get("type").toString();
				String product = row.get("product_id").toString();
				double opening = Double.valueOf(row.get("opening").toString());
				double closing = Double.valueOf(row.get("closing").toString());			
				double sales = Double.valueOf(row.get("sales").toString());
				double test = Double.valueOf(row.get("pump_test").toString());
				double totalSale = Double.valueOf(row.get("totalSale").toString());
				double saleRs = Double.valueOf(row.get("saleRs").toString());
				
				ReportRespObject reportRow = new ReportRespObject();
				
				reportRow.setPumpId(pump);
				reportRow.setType(type);
				reportRow.setProduct(product);
				reportRow.setOpening(opening);
				reportRow.setClosing(closing);
				reportRow.setSaleLtr(sales);
				reportRow.setTest(test);
				reportRow.setFinalQuantity(totalSale);
				reportRow.setSaleRs(saleRs);
				
				reportRespList.add(reportRow);
			}
			
			result = null;
			result = jdbcTemplate.queryForList(READINGS_FOR_SALES_REPORT_LUBES);
			
			for(Map<String,Object> row : result){
				
				String product = row.get("product").toString();
				double finalQ = Double.valueOf(row.get("units").toString());
				String type = row.get("type").toString();
				double saleRs = Double.valueOf(row.get("sales_in_rs").toString());
				
				ReportRespObject reportRow = new ReportRespObject();
				reportRow.setType(type);
				reportRow.setProduct(product);
				reportRow.setFinalQuantity(finalQ);
				reportRow.setSaleRs(saleRs);
				
				reportRespList.add(reportRow);
			}
			
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
		
		return reportRespList;
	}
	
	public List<ReportRespObject> generateSalesReportData(Date date){

		List<ReportRespObject> reportRespList = new ArrayList<>();

		// pull sales from pump readings
		try{
			
			List<Map<String,Object>> result = jdbcTemplate.queryForList(READINGS_FOR_SALES_REPORT_PUMPS,new Object[]{date,date},new int[]{Types.DATE,Types.DATE});
			
			for(Map<String,Object> row : result){
				
				String pump = row.get("pump_id").toString();
				String type = row.get("type").toString();
				String product = row.get("product_id").toString();
				double opening = Double.valueOf(row.get("opening").toString());
				double closing = Double.valueOf(row.get("closing").toString());			
				double sales = Double.valueOf(row.get("sales").toString());
				double test = Double.valueOf(row.get("pump_test").toString());
				double totalSale = Double.valueOf(row.get("totalSale").toString());
				double saleRs = Double.valueOf(row.get("saleRs").toString());
				
				ReportRespObject reportRow = new ReportRespObject();
				
				reportRow.setPumpId(pump);
				reportRow.setType(type);
				reportRow.setProduct(product);
				reportRow.setOpening(opening);
				reportRow.setClosing(closing);
				reportRow.setSaleLtr(sales);
				reportRow.setTest(test);
				reportRow.setFinalQuantity(totalSale);
				reportRow.setSaleRs(saleRs);
				
				reportRespList.add(reportRow);
			}
			
			result = null;			
			result = jdbcTemplate.queryForList(READINGS_FOR_SALES_REPORT_LUBES,new Object[]{date},new int[]{Types.DATE});
			
			for(Map<String,Object> row : result){
				
				String product = row.get("product").toString();
				double finalQ = Double.valueOf(row.get("units").toString());
				String type = row.get("type").toString();
				double saleRs = Double.valueOf(row.get("sales_in_rs").toString());
				
				ReportRespObject reportRow = new ReportRespObject();
				reportRow.setType(type);
				reportRow.setProduct(product);
				reportRow.setFinalQuantity(finalQ);
				reportRow.setSaleRs(saleRs);
				
				reportRespList.add(reportRow);
			}
			
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
		
		return reportRespList;
	}
	
	public ReportsResponseWrapper generateCreditData(String customerID){
		
		List<Map<String, Object>> rows = null;
		try{
			rows = jdbcTemplate.queryForList(CREDIT_REPORT, new Object[]{"CREDIT",customerID,customerID}, new int[] {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR});
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
		
		// process rows
		ReportsResponseWrapper respWrapper = new ReportsResponseWrapper();
		List<ReportRespObject> listOfObjs = new ArrayList<>();
		ReportRespObject respObj = new ReportRespObject();
		String lastKey = "";
		
		for(Map<String,Object> row : rows){
			String custId = row.get("customer_id").toString();
			
			// TODO
			/* if(!lastKey.equals(custId)){
				
			}*/
			
			respObj.setCustomerID(custId);
			respObj.setDate(CommonUtils.getDate(row.get("date").toString()));
			respObj.setCredit(Double.parseDouble(row.get("credit").toString()));
			respObj.setRecovery(Double.parseDouble(row.get("recovery").toString()));
			
			listOfObjs.add(respObj);			
		}
		
		respWrapper.setReportRespList(listOfObjs);
		
		return respWrapper;
		
	}
	
	private int indexOfRespObj(List<ReportRespObject> listOfObjs, ReportRespObject respObj){
		
		return 1;
		
		
	}
	
	
}
