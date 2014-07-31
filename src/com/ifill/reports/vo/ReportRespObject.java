/**
 * 
 */
package com.ifill.reports.vo;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.ifill.reports.vo.util.IFillDateSerializer;
import com.ifill.reports.vo.util.JsonDateDeserializer;

/**
 * @author Sandy
 *
 */
public class ReportRespObject {
	
	// TODO move all these related fields to a class. composition
	private String product;
	private String type;
	private String pumpId;
	private String pumpName;
	private double opening;
	private double closing;
	private double saleLtr;
	private double test;
	private double finalQuantity;
	private double saleRs;
	
	// credit customer details
	private String customerID;
	private Date date;
	private double credit;
	private double recovery;
	
	
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getPumpId() {
		return pumpId;
	}
	public void setPumpId(String pumpId) {
		this.pumpId = pumpId;
	}
	public String getPumpName() {
		return pumpName;
	}
	public void setPumpName(String pumpName) {
		this.pumpName = pumpName;
	}
	public double getOpening() {
		return opening;
	}
	public void setOpening(double opening) {
		this.opening = opening;
	}
	public double getClosing() {
		return closing;
	}
	public void setClosing(double closing) {
		this.closing = closing;
	}
	public double getTest() {
		return test;
	}
	public void setTest(double test) {
		this.test = test;
	}

	public double getSaleRs() {
		return saleRs;
	}
	public void setSaleRs(double saleRs) {
		this.saleRs = saleRs;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public double getSaleLtr() {
		return saleLtr;
	}
	public void setSaleLtr(double saleLtr) {
		this.saleLtr = saleLtr;
	}
	public double getFinalQuantity() {
		return finalQuantity;
	}
	public void setFinalQuantity(double finalQuantity) {
		this.finalQuantity = finalQuantity;
	}
	public String getCustomerID() {
		return customerID;
	}
	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}
	
	@JsonSerialize(using=IFillDateSerializer.class)
	public Date getDate() {
		return date;
	}
	
	@JsonDeserialize(using=JsonDateDeserializer.class)
	public void setDate(Date date) {
		this.date = date;
	}
	public double getCredit() {
		return credit;
	}
	public void setCredit(double credit) {
		this.credit = credit;
	}
	public double getRecovery() {
		return recovery;
	}
	public void setRecovery(double recovery) {
		this.recovery = recovery;
	}
	
	
	
}
