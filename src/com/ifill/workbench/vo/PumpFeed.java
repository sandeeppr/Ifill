package com.ifill.workbench.vo;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.ifill.reports.vo.util.IFillDateSerializer;
import com.ifill.reports.vo.util.JsonDateDeserializer;

public class PumpFeed {

	private String pumpId;
	
	private Date dayDate;
	
	private double quantity;
	
	private double mechReading;
	
	private double pumpTest;
	
	private double effcSaleLtrs;
	
	private double effcSaleRs;
	
	private double effcMechSaleLtrs;
	
	private double effcMechSaleRs;

	public String getPumpId() {
		return pumpId;
	}

	public void setPumpId(String pumpId) {
		this.pumpId = pumpId;
	}
	
	public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	@JsonSerialize(using=IFillDateSerializer.class)
	public Date getDayDate() {
		return dayDate;
	}

	@JsonDeserialize(using=JsonDateDeserializer.class)
	public void setDayDate(Date dayDate) {
		this.dayDate = dayDate;
	}

	public double getPumpTest() {
		return pumpTest;
	}

	public void setPumpTest(double pumpTest) {
		this.pumpTest = pumpTest;
	}

	public double getEffcSaleLtrs() {
		return effcSaleLtrs;
	}

	public void setEffcSaleLtrs(double effcSaleLtrs) {
		this.effcSaleLtrs = effcSaleLtrs;
	}

	public double getEffcSaleRs() {
		return effcSaleRs;
	}

	public void setEffcSaleRs(double effcSaleRs) {
		this.effcSaleRs = effcSaleRs;
	}

	public double getEffcMechSaleLtrs() {
		return effcMechSaleLtrs;
	}

	public void setEffcMechSaleLtrs(double effcMechSaleLtrs) {
		this.effcMechSaleLtrs = effcMechSaleLtrs;
	}

	public double getEffcMechSaleRs() {
		return effcMechSaleRs;
	}

	public void setEffcMechSaleRs(double effcMechSaleRs) {
		this.effcMechSaleRs = effcMechSaleRs;
	}

	public double getMechReading() {
		return mechReading;
	}

	public void setMechReading(double mechReading) {
		this.mechReading = mechReading;
	}
	
	
}
