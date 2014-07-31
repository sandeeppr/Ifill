/**
 * 
 */
package com.ifill.common.metadata.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.common.exceptions.ServiceLayerException;
import com.ifill.common.metadata.dao.MetadataDao;
import com.ifill.common.metadata.service.MetadataServiceI;

/**
 * @author Sandy
 *
 */
@Service
public class MetadataServiceImpl implements MetadataServiceI{
	
	@Autowired
	MetadataDao metadataDao;

	@Override
	public Double findPriceById(String id) {
		Double price = 0.0;
		try{
			price  = metadataDao.findPriceById(id);
		}catch(DataAccessLayerException dale){
			dale.printStackTrace();
			throw new ServiceLayerException(dale.getMessage());
		}
		return price;
	}
	
	@Override
	public List<String> findPumpsByFuel(String product_id){
		try{
			return metadataDao.findPumpsByFuel(product_id);
		}catch(DataAccessLayerException ex){
			ex.printStackTrace();
			throw new ServiceLayerException(ex.getMessage());
		}	
	}
	
	@Override
	public List<String> findAllLubes(){
		try{
			return metadataDao.pullLubes();
		}catch(DataAccessLayerException ex){
			ex.printStackTrace();
			throw new ServiceLayerException(ex.getMessage());
		}	
	}

	@Override
	public List<String> findAllFuels() {
		try{
			return metadataDao.findAllFuels();
		}catch(DataAccessLayerException ex){
			ex.printStackTrace();
			throw new ServiceLayerException(ex.getMessage());
		}
	}
}
