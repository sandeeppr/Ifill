/**
 * 
 */
package com.ifill.common.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * @author Sandy
 *
 */
public class CommonUtils {

	private static DateFormat dateformat = new SimpleDateFormat("dd-MM-yyyy");
	
	public static Date getCurrentDate(){	
		Date today = Calendar.getInstance().getTime(); 
		return today;
	}
	
	public static String getCurrentDateAsString(){	
		Date today = Calendar.getInstance().getTime(); 
		return dateformat.format(today);
	}
	
	public static String getFormattedDateAsString(Date date){
		if(date != null)
			return dateformat.format(date);
		return null;
	}
	
	public static Date getDate(String str){
		if(str != null)
			try {
				return dateformat.parse(str);
			} catch (ParseException e) {
				e.printStackTrace();
				return null;
			}
		return null;
	}
	
	
}
