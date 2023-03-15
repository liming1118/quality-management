package com.example.springboot.controller;

import com.example.springboot.common.Result;
// 用户列表分页 入参类
import com.example.springboot.controller.request.UserPageRequest;
import com.example.springboot.entity.User;
import com.example.springboot.service.IUserService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
// controller里面是暴露给前端的接口，前端->controller->service->mapper-数据库
@CrossOrigin
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired  // 申明下，才能调用service里的方法
    IUserService userService;

    @PostMapping("/save")
    public Result save(@RequestBody User user) {
        userService.save(user);
        return Result.success();
    }
    // 充值积分
    @PostMapping("/account")
    public Result account(@RequestBody User user) {
        userService.handleAccount(user);
        return Result.success();
    }

    @PutMapping("/update")
    public Result update(@RequestBody User user) {
        userService.update(user);
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        userService.deleteById(id);
        return Result.success();
    }
//对于get请求，返回值是对象的，需要调用有参success(Obj data) 方法！！！
    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id) {
        User user = userService.getById(id);
        return Result.success(user);
    }

    @GetMapping("/list")
    public Result list() {
        List<User> users = userService.list();
        return Result.success(users);
    }
// 分页
    @GetMapping("/page")
    public Result page(UserPageRequest userPageRequest) {
        PageInfo<User> page = userService.page(userPageRequest);
        return Result.success(page);
    }

}
