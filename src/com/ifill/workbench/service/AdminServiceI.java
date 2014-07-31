/**
 * 
 */
package com.ifill.workbench.service;

import com.ifill.common.metadata.dao.Item;
import com.ifill.workbench.vo.Pumps;

/**
 * @author Sandy
 *
 */
public interface AdminServiceI {

	public String configPumpById(String pumpid);
	public String addPump(Pumps pump);
	public String addProduct(Item item);
	String updateProduct(Item item);
}
