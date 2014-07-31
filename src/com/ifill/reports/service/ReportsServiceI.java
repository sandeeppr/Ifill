/**
 * 
 */
package com.ifill.reports.service;

import java.util.Date;
import java.util.List;

import com.ifill.reports.vo.ReportReqObject;
import com.ifill.reports.vo.ReportRespObject;
import com.ifill.reports.vo.ReportsResponseWrapper;

/**
 * @author Sandy
 *
 */
public interface ReportsServiceI {

	ReportsResponseWrapper generateCashPosition();
	List<ReportRespObject> generateSalesReport();
	List<ReportRespObject> generateSalesReport(Date date);
	ReportsResponseWrapper generateCreditReport(String custId);
	
}
