/**
 * 
 */
package com.ifill.workbench.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.common.exceptions.ServiceLayerException;
import com.ifill.workbench.dao.InventoryDao;
import com.ifill.workbench.service.InventoryServiceI;
import com.ifill.workbench.vo.DipReading;
import com.ifill.workbench.vo.MiscExpenses;
import com.ifill.workbench.vo.PumpFeed;
import com.ifill.workbench.vo.Sales;
import com.ifill.workbench.vo.StockData;

/**
 * @author Sandy
 *
 */
@Service
public class InventoryServiceImpl implements InventoryServiceI {

	@Autowired
	private InventoryDao invDao;
	
	@Override
	public void savePumpFeed(PumpFeed feed) {
		try{
			invDao.savePumpFeed(feed);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}
		
	}
	
	@Override
	public void deletePumpFeed(String key) {
		try{
			invDao.deletePumpFeed(key);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}
		
	}

	@Override
	public void saveStockReciept(StockData data) {
		try{
			invDao.saveStockReciept(data);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}
	
	@Override
	public void deleteStockReciept(String key) {
		System.out.println("service : "+key);
		try{
			invDao.deleteStockReciept(key);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}

	@Override
	public void saveCreditSale(Sales data) {
		try{
			invDao.saveCreditSales(data);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}
	
	@Override
	public void deleteCreditSale(String key) {
		try{
			invDao.deleteCreditSales(key);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}
	
	@Override
	public int saveMiscExpenses(MiscExpenses data) {
		int id = -1;
		try{
			id = invDao.saveExpenses(data);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}	
		return id;
	}
	
	@Override
	public void deleteMiscExpenses(String key) {
		try{
			invDao.deleteExpenses(key);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}
	
	@Override
	public void saveDips(DipReading data) {
		try{
			invDao.saveDips(data);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}
	
	@Override
	public void deleteDips(String key) {
		try{
			invDao.deleteDips(key);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}
	
	@Override
	public int saveLubes(Sales data) {
		int id = -1;
		try{
			id = invDao.saveLubes(data);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}	
		return id;
	}
	
	@Override
	public void deleteLubes(String key) {
		try{
			invDao.deleteLubes(key);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}
	
	@Override
	public void saveCreditRecovery(Sales recovery) {
		try{
			invDao.saveCreditRecovery(recovery);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}
	
	@Override
	public void deleteCreditRecovery(String key) {
		try{
			invDao.deleteCreditRecovery(key);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}
	
	@Override
	public double findLDReadings(String pumpid,String curDate) {
		try{
			return invDao.findLDReadings(pumpid,curDate);
		}catch(DataAccessLayerException ex){
			// TODO
			throw new ServiceLayerException(ex.getMessage());
		}		
	}
	
}
