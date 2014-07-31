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
public class StockData {

	private String product;
	private double quantity;
	private Date date;
	
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	
	@JsonSerialize(using=IFillDateSerializer.class)
	public Date getDate() {
		return date;
	}
	
	@JsonDeserialize(using=JsonDateDeserializer.class)
	public void setDate(Date date) {
		this.date = date;
	}	
}
