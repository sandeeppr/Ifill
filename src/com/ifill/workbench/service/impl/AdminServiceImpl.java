/**
 * 
 */
package com.ifill.workbench.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.common.exceptions.ServiceLayerException;
import com.ifill.common.metadata.dao.Item;
import com.ifill.common.utils.IfillConstants;
import com.ifill.workbench.dao.AdminDao;
import com.ifill.workbench.service.AdminServiceI;
import com.ifill.workbench.vo.Pumps;

/**
 * @author Sandy
 *
 */
@Service
public class AdminServiceImpl implements AdminServiceI {

	@Autowired
	AdminDao adminDao;
	
	@Override
	public String configPumpById(String pumpid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String addPump(Pumps pump) {
		try{
			adminDao.createPump(pump);
		}catch(DataAccessLayerException dale){
			throw new ServiceLayerException(dale.getMessage());
		}
		return IfillConstants.STATUS_SUCCESS;
	}

	@Override
	public String addProduct(Item item) {
		try{
			adminDao.addProduct(item);
		}catch(DataAccessLayerException dale){
			throw new ServiceLayerException(dale.getMessage());
		}
		return IfillConstants.STATUS_SUCCESS;
	}
	
	@Override
	public String updateProduct(Item item) {
		try{
			adminDao.updateProduct(item);
		}catch(DataAccessLayerException dale){
			throw new ServiceLayerException(dale.getMessage());
		}
		return IfillConstants.STATUS_SUCCESS;
	}

	
}
