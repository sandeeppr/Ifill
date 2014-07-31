/**
 * 
 */
package com.ifill.common.exceptions;

/**
 * @author Sandy
 *
 */
public class ServiceLayerException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	
	public ServiceLayerException() {
    }

    public ServiceLayerException(String message) {
        super(message);
    }

    public ServiceLayerException(Throwable cause) {
        super(cause);
    }

    public ServiceLayerException(String message, Throwable cause) {
        super(message, cause);
    }
	
}
