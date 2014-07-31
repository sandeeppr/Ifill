/**
 * 
 */
package com.ifill.workbench.vo;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.ifill.reports.vo.util.IFillDateSerializer;
import com.ifill.reports.vo.util.JsonDateDeserializer;

/**
 * @author Sandy
 *
 */
public class Sales {
	private String billno;
	private String name;
	private String type;
	private String saleType;
	private double quantity;
	private double saleInRs;
	private Date date;
	private String product;
	private String customerId;
	private String modeOfPayment;
	
	public String getBillno() {
		return billno;
	}
	public void setBillno(String billno) {
		this.billno = billno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	public double getSaleInRs() {
		return saleInRs;
	}
	public void setSaleInRs(double saleInRs) {
		this.saleInRs = saleInRs;
	}
	/*public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}*/
	public String getSaleType() {
		return saleType;
	}
	public void setSaleType(String saleType) {
		this.saleType = saleType;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	
	@JsonSerialize(using=IFillDateSerializer.class)
	public Date getDate() {
		return date;
	}
	
	@JsonDeserialize(using=JsonDateDeserializer.class)
	public void setDate(Date date) {
		this.date = date;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getModeOfPayment() {
		return modeOfPayment;
	}
	public void setModeOfPayment(String modeOfPayment) {
		this.modeOfPayment = modeOfPayment;
	}	
}
