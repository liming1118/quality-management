package com.example.springboot.controller.request;

import lombok.Data;
// 分页入参必传的2个参数，作为基类
@Data
public class BaseRequest {
    private Integer pageNum = 1;
    private Integer pageSize = 5;
}
