/**
 * 
 */
package com.ifill.workbench.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Sandy
 *
 */
@Controller
@RequestMapping("/views")
public class ViewController {
	
	private static String VIEWS_APP_HONME = "index";
	private static String VIEWS_SUPERVISOR_HOME = "WelcomePage";
	private static String VIEWS_ADMIN_HOME = "admin_ui/WelcomePage";
	private static String VIEWS_CONFIG_PUMP = "admin_ui/ConfigPump";

	@RequestMapping(method=RequestMethod.GET, value="showAdminHome")
	public String showWelcomeView(){
		return VIEWS_ADMIN_HOME;
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showPumpConfigView")
	public String showPumpConfigs(){
		return VIEWS_CONFIG_PUMP;
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showHomePage")
	public String showHomeView(){
		return VIEWS_SUPERVISOR_HOME;
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showAppHomePage")
	public String showAppHomeView(){
		return VIEWS_APP_HONME;
	}
	
}
