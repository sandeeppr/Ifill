/**
 * 
 */
package com.ifill.common.metadata.service;

import java.util.List;

/**
 * @author Sandy
 *
 */
public interface MetadataServiceI {
	public Double findPriceById(String id);

	List<String> findPumpsByFuel(String product_id);
	List<String> findAllLubes();
	List<String> findAllFuels();
}
