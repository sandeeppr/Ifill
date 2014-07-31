/**
 * 
 */
package com.ifill.reports.vo;

import java.util.List;
import java.util.Map;

/**
 * @author Sandy
 *
 */
public class ReportsResponseWrapper {

	private Map<String,String> reports;
	private List<ReportRespObject> reportRespList;

	public Map<String, String> getReports() {
		return reports;
	}

	public void setReports(Map<String, String> reports) {
		this.reports = reports;
	}
	
	public String getValue(String key){
		if(reports.containsKey(key))
			return reports.get(key);
		else 
			return null;
	}

	public List<ReportRespObject> getReportRespList() {
		return reportRespList;
	}

	public void setReportRespList(List<ReportRespObject> reportRespList) {
		this.reportRespList = reportRespList;
	}
}
