/**
 * 
 */
package com.ifill.reports.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.common.exceptions.ServiceLayerException;
import com.ifill.reports.dao.ReportsDao;
import com.ifill.reports.service.ReportsServiceI;
import com.ifill.reports.vo.ReportReqObject;
import com.ifill.reports.vo.ReportRespObject;
import com.ifill.reports.vo.ReportsResponseWrapper;

/**
 * @author Sandy
 *
 */
@Service
public class ReportsServiceImpl implements ReportsServiceI{
	
	@Autowired
	private ReportsDao reportsDao;
	
	@Override
	public ReportsResponseWrapper generateCashPosition(){
		
		ReportsResponseWrapper respWrapper = null;
		
		try{
			Map<String,String> sales = reportsDao.generateCashReportData();
			if(sales != null){
				respWrapper = new ReportsResponseWrapper();
				respWrapper.setReports(sales);
			}			
		}catch(DataAccessLayerException dale){
			throw new ServiceLayerException(dale.getMessage());
		}
		
		return respWrapper;
	}

	@Override
	public List<ReportRespObject> generateSalesReport() {
		List<ReportRespObject> reportRespList;
		try{
			reportRespList = reportsDao.generateSalesReportData();
						
		}catch(DataAccessLayerException dale){
			throw new ServiceLayerException(dale.getMessage());
		}
		
		return reportRespList;
	}
	
	@Override
	public List<ReportRespObject> generateSalesReport(Date date) {
		List<ReportRespObject> reportRespList;
		try{
			reportRespList = reportsDao.generateSalesReportData(date);
						
		}catch(DataAccessLayerException dale){
			throw new ServiceLayerException(dale.getMessage());
		}
		
		return reportRespList;
	}

	@Override
	public ReportsResponseWrapper generateCreditReport(String custId) {
		
		ReportsResponseWrapper reportRespList;
		try{
			reportRespList = reportsDao.generateCreditData(custId);
						
		}catch(DataAccessLayerException dale){
			throw new ServiceLayerException(dale.getMessage());
		}
		
		return reportRespList;
	}
}
