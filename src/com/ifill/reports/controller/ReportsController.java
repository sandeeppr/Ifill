/**
 * 
 */
package com.ifill.reports.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ifill.common.exceptions.ServiceLayerException;
import com.ifill.common.utils.CommonUtils;
import com.ifill.reports.service.ReportsServiceI;
import com.ifill.reports.vo.ReportReqObject;
import com.ifill.reports.vo.ReportRespObject;
import com.ifill.reports.vo.ReportsResponseWrapper;
import com.ifill.reports.vo.util.JsonDateDeserializer;
import com.ifill.userMgmt.service.ProfileMgmtI;
import com.ifill.workbench.vo.PumpFeed;

/**
 * @author Sandy
 *
 */
@Controller
@RequestMapping("/reports")
public class ReportsController {
	@Autowired
	ReportsServiceI reportsService;
	
	@Autowired
	private ProfileMgmtI profileMgmtService;
	
	@RequestMapping(method=RequestMethod.GET, value="/showCashPositionStmt",  produces="application/json")
	public String showDailyCashPosition(HttpServletRequest req, HttpServletResponse resp){
		resp.addHeader("Access-Control-Allow-Origin", "*");
		HttpSession session = req.getSession();
		ReportsResponseWrapper respWrapper = null;
		try{
			respWrapper = reportsService.generateCashPosition();
		}catch(ServiceLayerException sle){
			return null;
		}
		
		session.setAttribute("resp", respWrapper.getReports());
		session.setAttribute("MS", respWrapper.getValue("MS"));
		session.setAttribute("HSD", respWrapper.getValue("HSD"));
		session.setAttribute("CREDITS", respWrapper.getValue("CREDITS"));
		session.setAttribute("LUBES", respWrapper.getValue("LUBES"));
		session.setAttribute("CREDIT_RECOVERY", respWrapper.getValue("CREDIT_RECOVERY"));
		session.setAttribute("MISC_EXPENSES", respWrapper.getValue("MISC_EXPENSES"));
		
		String date = CommonUtils.getCurrentDateAsString();
		session.setAttribute("Date", date);
		
		return "CashPositionStatement";
	}
	
	
	@RequestMapping(method=RequestMethod.GET, value="/salesReportData",  produces="application/json")
	public  @ResponseBody List<ReportRespObject> retrieveSalesData(HttpServletRequest req, HttpServletResponse resp){
		List<ReportRespObject> reportRespList;
		try{
			reportRespList = reportsService.generateSalesReport(CommonUtils.getCurrentDate());
		}catch(ServiceLayerException sle){
			return null;
		}
		return reportRespList;
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/salesReportData/{reportDate}",  produces="application/json")
	public  @ResponseBody List<ReportRespObject> retrieveSalesData(@PathVariable("reportDate") String reportDate, HttpServletRequest req, HttpServletResponse resp){
		System.out.println("diff date");
		
		Date report_Date = CommonUtils.getDate(reportDate);
		
		List<ReportRespObject> reportRespList;
		try{
			reportRespList = reportsService.generateSalesReport(report_Date);
		}catch(ServiceLayerException sle){
			return null;
		}
		return reportRespList;
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/showSalesReport",  produces="application/json")
	public String showSalesReportView(HttpServletRequest req, HttpServletResponse resp){
		resp.addHeader("Access-Control-Allow-Origin", "*");
		
		// add date details to session
		HttpSession session = req.getSession();
		String date = CommonUtils.getCurrentDateAsString();
		session.setAttribute("Date", date);
		
		return "DailySalesReport";
	}
	
	/*@RequestMapping(method=RequestMethod.GET, value="/showSalesReport/{reportDate}",  produces="application/json")
	public String showSalesReportView(@PathVariable("reportDate") String reportDate, HttpServletRequest req, HttpServletResponse resp) throws ParseException{
		resp.addHeader("Access-Control-Allow-Origin", "*");
		
		// add date details to session
		HttpSession session = req.getSession();
		session.setAttribute("Date", reportDate);	
		session.setAttribute("ReportDate",reportDate);
		
		return "DailySalesReport";
	}*/
	
	@RequestMapping(method=RequestMethod.GET, value="showMiscReport")
	public String showMiscReports(HttpServletRequest req){
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "MiscReports";
		return "index";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/showReport", consumes = "application/json")
	public @ResponseBody String pushStockReciept(@RequestBody ReportReqObject feed, HttpServletRequest req, HttpServletResponse resp) throws ParseException, IOException{

		// add date details to session
		HttpSession session = req.getSession();
		String dt = CommonUtils.getFormattedDateAsString(feed.getDate());
		session.setAttribute("ReportDate", dt);
		
		if(feed.getType().equals("sales_report")){	
			return "showSalesReport";
		}else if(feed.getType().equals("cash_report")){
			resp.sendRedirect("CashPositionStatement");
		}
		//return "";
		return null;
	}
	
/*	@RequestMapping(method = RequestMethod.POST, value = "/showReports", consumes = "application/json")
	public @ResponseBody String showReports(@RequestBody ReportReqObject feed) throws ParseException{
		//System.out.println("found meee:"+feed.getDate());
		return "success";
	}*/
	
	@RequestMapping(method=RequestMethod.GET, value="/showCreditReport")
	public String showCreditReport(HttpServletRequest req){
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "CreditReports";
		return "index";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/showCreditStatement",  produces="application/json")
	public String showCreditReportView(HttpServletRequest req, HttpServletResponse resp){
		resp.addHeader("Access-Control-Allow-Origin", "*");
		
		// add date details to session
		HttpSession session = req.getSession();
		String date = CommonUtils.getCurrentDateAsString();
		session.setAttribute("Date", date);
		
		return "CreditStatement";
	}
	
	@RequestMapping(method=RequestMethod.POST, value="postCreditDetails")
	public @ResponseBody void showCreditReport(@RequestBody ReportReqObject feed, HttpServletRequest req){
		
		// add customer id details to session
		HttpSession session = req.getSession();		
		session.setAttribute("customerID", feed.getId());
		String date = CommonUtils.getCurrentDateAsString();
		session.setAttribute("Date", date);
		
		//return "CreditStatement";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/salesCreditData/{customer}",  produces="application/json")
	public  @ResponseBody ReportsResponseWrapper retrieveCreditData(@PathVariable("customer") String customer, HttpServletRequest req, HttpServletResponse resp){
		
		ReportsResponseWrapper reportRespList;
		try{
			reportRespList = reportsService.generateCreditReport(customer);
		}catch(ServiceLayerException sle){
			return null;
		}
		return reportRespList;
	}
}
