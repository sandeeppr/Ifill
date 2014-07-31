package com.ifill.userMgmt.service.impl;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.common.exceptions.ServiceLayerException;
import com.ifill.common.utils.IfillConstants;
import com.ifill.userMgmt.dao.ProfileMgmtDao;
import com.ifill.userMgmt.service.ProfileMgmtI;
import com.ifill.userMgmt.vo.User;

@Service
public class ProfileMgmtServiceImpl implements ProfileMgmtI{
	
	@Autowired
	ProfileMgmtDao profileDao;
	
	@Override
	public String findUserById(User user){
		
		try{
			return profileDao.findUserByLoginId(user.getUserId(), user.getPassword(), user.isAdmin());
		}catch(DataAccessLayerException dale){
			dale.printStackTrace();
			throw new ServiceLayerException(dale.getMessage());
		}
	
	}

	@Override
	public boolean isUserLoggedIn(HttpSession session) {
		
		boolean loggedIn = false;
		Object status = session.getAttribute(IfillConstants.SESSION_LOGGEDIN_STATUS);
		if(status != null)
			loggedIn = Boolean.valueOf(status.toString());
		
		session.getMaxInactiveInterval();
		
		return loggedIn;
	}

	@Override
	public String createUser(User user) {
		
		try{
			profileDao.createUser(user);
		}catch(DataAccessLayerException dale){
			dale.printStackTrace();
			throw new ServiceLayerException(dale.getMessage());
		}
		return IfillConstants.STATUS_SUCCESS;
	}
	
	@Override
	public String createUserCreds(User user) {
		
		try{
			profileDao.createUserLoginCreds(user);
		}catch(DataAccessLayerException dale){
			dale.printStackTrace();
			throw new ServiceLayerException(dale.getMessage());
		}
		return IfillConstants.STATUS_SUCCESS;
	}
}
