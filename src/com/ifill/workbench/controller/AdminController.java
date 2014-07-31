/**
 * 
 */
package com.ifill.workbench.controller;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ifill.userMgmt.service.ProfileMgmtI;
import com.ifill.userMgmt.vo.User;
import com.ifill.workbench.service.AdminServiceI;
import com.ifill.workbench.vo.Pumps;

/**
 * @author Sandy
 *
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private ProfileMgmtI profileMgmtService;
	
	@Autowired
	private AdminServiceI adminService;
	
	@RequestMapping(method = RequestMethod.POST, value = "/postPumpConfigs", consumes = "application/json")
	public @ResponseBody String pushPumpConfigs(@RequestBody Pumps feed, HttpServletRequest req) throws ParseException{
		
		//if(profileMgmtService.isUserLoggedIn(req.getSession())){			
			return adminService.addPump(feed);	
		//}else
			//return IfillConstants.SESSION_TIMED_OUT;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/postCreateUser", consumes = "application/json")
	public @ResponseBody String pushNewUser(@RequestBody User user, HttpServletRequest req) throws ParseException{
		
		//if(profileMgmtService.isUserLoggedIn(req.getSession())){			
			return profileMgmtService.createUser(user);	
		//}else
			//return IfillConstants.SESSION_TIMED_OUT;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/postUserCreds", consumes = "application/json")
	public @ResponseBody String pushUserCreds(@RequestBody User user, HttpServletRequest req) throws ParseException{
		
		//if(profileMgmtService.isUserLoggedIn(req.getSession())){			
			return profileMgmtService.createUserCreds(user);	
		//}else
			//return IfillConstants.SESSION_TIMED_OUT;
	}
	
	
}
