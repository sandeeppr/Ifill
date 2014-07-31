/**
 * 
 */
package com.ifill.workbench.service;

import java.util.List;

import com.ifill.workbench.vo.DipReading;
import com.ifill.workbench.vo.MiscExpenses;
import com.ifill.workbench.vo.PumpFeed;
import com.ifill.workbench.vo.Sales;
import com.ifill.workbench.vo.StockData;

/**
 * @author Sandy
 *
 */
public interface InventoryServiceI {

	public void savePumpFeed(PumpFeed feed);
	public void saveStockReciept(StockData data);
	void saveCreditSale(Sales data);
	int saveMiscExpenses(MiscExpenses data);
	void saveDips(DipReading data);
	int saveLubes(Sales data);
	void saveCreditRecovery(Sales recovery);
	double findLDReadings(String pumpid, String curDate);
	void deletePumpFeed(String key);
	void deleteStockReciept(String key);
	void deleteCreditSale(String key);
	void deleteMiscExpenses(String key);
	void deleteDips(String key);
	void deleteLubes(String key);
	void deleteCreditRecovery(String key);
}
