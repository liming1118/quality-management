package com.example.springboot.controller.dto;

import lombok.Data;

/**
 * 封装登录接口的返回字段  就是dto
 */
@Data
public class LoginDTO {
    private Integer id;
    private String username;
    private String phone;
    private String email;
    private String token;
}
