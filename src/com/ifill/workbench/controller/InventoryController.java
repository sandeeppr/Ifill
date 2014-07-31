/**
 * 
 */
package com.ifill.workbench.controller;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ifill.common.utils.IfillConstants;
import com.ifill.userMgmt.service.ProfileMgmtI;
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
@Controller
@RequestMapping("/inventory")
public class InventoryController {

	@Autowired
	private InventoryServiceI invService;
	
	@Autowired
	private ProfileMgmtI profileMgmtService;
	
	@RequestMapping(method=RequestMethod.GET, value="showHomePage")
	public String showHomeView(HttpServletRequest req){
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "WelcomePage";
		return "index";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showMS")
	public String showMSView(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "DailyReadings_MS";
		resp.sendRedirect("showHomePage");
		return "index";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showHSD")
	public String showHSDView(HttpServletRequest req){
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "DailyReadings_HSD" ;
		return "index";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showStockReciept")
	public String showStockRecieptView(HttpServletRequest req){
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "StockReciept";
		return "index";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showCreditSale")
	public String showCreditSaleView(HttpServletRequest req){
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "CreditSale";
		return "index";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showCreditRecovery")
	public String showCreditRecoveryView(HttpServletRequest req){
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "CreditRecovery";
		return "index";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showMiscExpenses")
	public String showMiscExpencesView(HttpServletRequest req){
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "MiscExpenses";
		return "index";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showDipReadings")
	public String showDipReadingsView(HttpServletRequest req){
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "DailyDips";
		return "index";
	}
	
	
	@RequestMapping(method=RequestMethod.GET, value="showLubesSales")
	public String showLubesSaleView(HttpServletRequest req){
		if(profileMgmtService.isUserLoggedIn(req.getSession()))
			return "LubesSales";
		return "index";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/postDailyReadings", consumes = "application/json")
	public @ResponseBody String pushDailyReadings(@RequestBody PumpFeed feed,HttpServletRequest req) throws ParseException{
		System.out.println("pushing a row");
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			invService.savePumpFeed(feed);		
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;
	}
	
	@RequestMapping(method = RequestMethod.DELETE, value = "/{key}/deleteDailyReadings", consumes = "application/json")
	public @ResponseBody String deleteDailyReadings(@PathVariable String key,HttpServletRequest req) throws ParseException{
		System.out.println("deleting a row");		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			invService.deletePumpFeed(key);	
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;	
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/postStockReciept", consumes = "application/json")
	public @ResponseBody String  pushStockReciept(@RequestBody StockData feed,HttpServletRequest req) throws ParseException{
		System.out.println("pushing a row");		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			invService.saveStockReciept(feed);
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;	
	}	
	
	@RequestMapping(method = RequestMethod.DELETE, value = "/{key}/deleteStockReciept", consumes = "application/json")
	public @ResponseBody String  deleteStockReciept(@PathVariable String key,HttpServletRequest req) throws ParseException{
		System.out.println("deleting a stock row");				
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			try{
				invService.deleteStockReciept(key);
			}catch(Exception e){
				e.printStackTrace();
				return IfillConstants.STATUS_FAILURE;
			}
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;	
	}	
	
	@RequestMapping(method = RequestMethod.POST, value = "/postCreditSale", consumes = "application/json")
	public @ResponseBody String pushCreditSale(@RequestBody Sales feed,HttpServletRequest req) throws ParseException{
		
		System.out.println("pushing a row");
		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			try{
				invService.saveCreditSale(feed);
			}catch(Exception e){
				e.printStackTrace();
				return IfillConstants.STATUS_FAILURE;
			}
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;	
	}
	
	@RequestMapping(method = RequestMethod.DELETE, value = "/{key}/deleteCreditSale", consumes = "application/json")
	public @ResponseBody String deleteCreditSale(@PathVariable String key,HttpServletRequest req) throws ParseException{		
		System.out.println("deleting a row");
		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			try{
				invService.deleteCreditSale(key);
			}catch(Exception e){
				e.printStackTrace();
				return IfillConstants.STATUS_FAILURE;
			}
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;	
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/postCreditRecovery", consumes = "application/json")
	public @ResponseBody String  pushCreditRecovery(@RequestBody Sales feed,HttpServletRequest req) throws ParseException{
		
		System.out.println("pushing a recovery row");		
		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			try{
				invService.saveCreditRecovery(feed);
			}catch(Exception e){
				e.printStackTrace();
				return IfillConstants.STATUS_FAILURE;
			}
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;	
		
		
	}
	
	@RequestMapping(method = RequestMethod.DELETE, value = "/{key}/deleteCreditRecovery", consumes = "application/json")
	public  @ResponseBody String  deleteCreditRecovery(@PathVariable String key,HttpServletRequest req) throws ParseException{		
		System.out.println("deleting a row");
		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			try{
				invService.deleteCreditRecovery(key);		
			}catch(Exception e){
				e.printStackTrace();
				return IfillConstants.STATUS_FAILURE;
			}
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;	
		
	}
	
	// returns -1 or expense id.
	@RequestMapping(method = RequestMethod.POST, value = "/postMiscExpenses", consumes = "application/json")
	public @ResponseBody int pushMiscExpenses(@RequestBody MiscExpenses expenses,HttpServletRequest req) throws ParseException{		
		System.out.println("pushing a row");
			
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			return invService.saveMiscExpenses(expenses);
		}else
			return -1;	
	}
	
	@RequestMapping(method = RequestMethod.DELETE, value = "/{key}/deleteMiscExpenses", consumes = "application/json")
	public @ResponseBody String deleteMiscExpenses(@PathVariable String key,HttpServletRequest req) throws ParseException{		
		System.out.println("deleting a row");
		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			try{
				invService.deleteMiscExpenses(key);		
			}catch(Exception e){
				e.printStackTrace();
				return IfillConstants.STATUS_FAILURE;
			}
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;	
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/postDipReadings", consumes = "application/json")
	public @ResponseBody String pushDipReadings(@RequestBody DipReading dips,HttpServletRequest req) throws ParseException{		
		System.out.println("pushing a row");
			
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			invService.saveDips(dips);	
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;		
	}
	
	@RequestMapping(method = RequestMethod.DELETE, value = "/{key}/deleteDipReadings", consumes = "application/json")
	public @ResponseBody String deleteDipReadings(@PathVariable String key,HttpServletRequest req) throws ParseException{		
		System.out.println("deleting a row");	
		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			invService.deleteDips(key);	
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;		
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/postLubeSales", consumes = "application/json")
	public @ResponseBody int pushLubeSales(@RequestBody Sales lubes,HttpServletRequest req) throws ParseException{		
		System.out.println("pushing a row");
		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			return invService.saveLubes(lubes);	
		}else
			return -1;	
	}

	@RequestMapping(method = RequestMethod.DELETE, value = "/{key}/deleteLubeSales", consumes = "application/json")
	public @ResponseBody String deleteLubeSales(@PathVariable String key,HttpServletRequest req) throws ParseException{
		System.out.println("deleting a lubes row");
		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			try{
				invService.deleteLubes(key);
			}catch(Exception e){
				e.printStackTrace();
				return IfillConstants.STATUS_FAILURE;
			}
			return IfillConstants.STATUS_SUCCESS;
		}else
			return IfillConstants.SESSION_TIMED_OUT;	
	}

	
	@RequestMapping(method=RequestMethod.GET, value="/{pumpid}/{curDate}/lastDayReading", produces="application/json")
	public @ResponseBody double lastDayReadings(@PathVariable String pumpid, @PathVariable String curDate,HttpServletRequest req){		
		
		if(profileMgmtService.isUserLoggedIn(req.getSession())){
			return invService.findLDReadings(pumpid,curDate);			
		}else
			return -1;	
	}	
	
}
