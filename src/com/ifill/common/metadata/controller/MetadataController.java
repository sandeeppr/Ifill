/**
 * 
 */
package com.ifill.common.metadata.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ifill.common.metadata.service.MetadataServiceI;

/**
 * @author Sandy
 *
 */
@Controller
@RequestMapping(value="/metadata")
public class MetadataController {
	
	@Autowired
	MetadataServiceI metadataService;

	@RequestMapping(method=RequestMethod.GET, value="/{id}/itemprice")
	public @ResponseBody Double priceByItem(@PathVariable String id){
		return metadataService.findPriceById(id);
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/{id}/pumps")
	public @ResponseBody List<String> pumpsByFuel(@PathVariable String id){
		return metadataService.findPumpsByFuel(id);
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/lubes")
	public @ResponseBody List<String> findAllLubes(){
		return metadataService.findAllLubes();
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/fuels")
	public @ResponseBody List<String> findAllFuels(){
		return metadataService.findAllFuels();
	}
	
}
