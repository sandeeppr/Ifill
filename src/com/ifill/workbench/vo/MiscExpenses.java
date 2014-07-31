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
public class MiscExpenses {
	
	private String desc;
	private double amount;
	private Date date;
	private int expense_id;
	
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	
	@JsonSerialize(using=IFillDateSerializer.class)
	public Date getDate() {
		return date;
	}
	
	@JsonDeserialize(using=JsonDateDeserializer.class)
	public void setDate(Date date) {
		this.date = date;
	}
	public int getExpense_id() {
		return expense_id;
	}
	public void setExpense_id(int expense_id) {
		this.expense_id = expense_id;
	}	
}
