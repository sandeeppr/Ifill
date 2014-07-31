/**
 * 
 */
package com.ifill.userMgmt.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.userMgmt.service.ProfileMgmtI;
import com.ifill.userMgmt.vo.User;

/**
 * @author Sandy
 *
 */
@Controller
@RequestMapping("/profile")
public class ProfileMgmtController {

	@Autowired
	ProfileMgmtI profileService;
	
	//TODO move them to a common constants file
	private static String SESSION_ID = "SESSION_ID";
	private static String SESSION_LOGGEDIN_STATUS = "loggedIn";
	private static String SESSION_LOGGEDIN_USERNAME = "username";
	private static String SESSION_LOGGEDIN_OBJECT = "userObject";
	private static String FAILURE = "FAILED";
	private static String SUCCESS = "SUCCESS";
	
	@RequestMapping(method = RequestMethod.POST, value = "/authorizeUser", consumes = "application/json")
	public @ResponseBody String loginUser(@RequestBody User user, HttpServletRequest req){
		String name = null;
		HttpSession session = req.getSession();
		System.out.println("isAdmin : "+user.isAdmin());
		try{
			name = profileService.findUserById(user);
		}catch(DataAccessLayerException dale){
			dale.printStackTrace();
			return FAILURE;
		}
		
		if(name != null){
			session.setAttribute(SESSION_ID, RequestContextHolder.currentRequestAttributes().getSessionId());			
			session.setAttribute(SESSION_LOGGEDIN_STATUS, true);
			session.setAttribute(SESSION_LOGGEDIN_USERNAME, name);
			session.setAttribute(SESSION_LOGGEDIN_OBJECT, user);
			//session.setMaxInactiveInterval(15*60);
			
			return SUCCESS;
		}else
			return FAILURE;			
	}
	
	public boolean isSignedIn(HttpSession session){
		
		boolean loggedIn = false;
		Object status = session.getAttribute(SESSION_LOGGEDIN_STATUS);
		if(status != null)
			loggedIn = Boolean.valueOf(status.toString());
		
		//session.getMaxInactiveInterval();
		
		return loggedIn;
	}
	
	@RequestMapping(method=RequestMethod.GET, value="logout", produces="application/json")
	public @ResponseBody String logoutUser(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		System.out.println("logging out");
		HttpSession session = req.getSession();
		session.removeAttribute(SESSION_LOGGEDIN_OBJECT);
		session.removeAttribute(SESSION_LOGGEDIN_USERNAME);
		session.removeAttribute(SESSION_LOGGEDIN_STATUS);
		return SUCCESS;
		//resp.sendRedirect("../views/showHomePage");
	}
}
