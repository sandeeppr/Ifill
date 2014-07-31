/**
 * 
 */
package com.ifill.common.exceptions;

import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * @author Sandy
 *
 */
@ResponseStatus(value = HttpStatus.NOT_FOUND, reason = "Requested data does not exist")
public class NoDataFoundException extends DataAccessException {

	private static final long serialVersionUID = 1L;

	public NoDataFoundException(String argMsg, Throwable argCause) {
		super(argMsg, argCause);
	}

	public NoDataFoundException(String argMsg) {
		super(argMsg);
	}
}
