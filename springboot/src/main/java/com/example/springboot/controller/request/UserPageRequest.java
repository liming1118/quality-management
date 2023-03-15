package com.example.springboot.controller.request;

import lombok.Data;
// 用户列表分页入参，除了必传的pageNum，pageSize（通过继承实现）,还有可以有name,phone
@Data
public class UserPageRequest extends BaseRequest{
    private String name;
    private String phone;
}
