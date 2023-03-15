package com.example.springboot.exception;

/**
 * 自定义业务异常
 */
public class ServiceException extends RuntimeException{

    private String code;

    public String getCode() {
        return code;
    }

    public ServiceException(String message, Throwable cause) {
        super(message, cause);
    }

    public ServiceException(String message) {   // 接受自定义异常信息
        super(message);
    }

    public ServiceException(String code, String message) {
        super(message);
        this.code = code;
    }

}
