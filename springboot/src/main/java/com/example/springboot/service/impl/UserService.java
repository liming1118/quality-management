package com.example.springboot.service.impl;
// 导入htool工具，可以生成时间和UUID

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import com.example.springboot.controller.request.BaseRequest;
import com.example.springboot.controller.request.UserPageRequest;
import com.example.springboot.entity.User;
import com.example.springboot.mapper.UserMapper;
import com.example.springboot.service.IUserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class UserService implements IUserService {

    @Autowired  // 申明下，才能调用mappper里的方法
    UserMapper userMapper;

    private static final Integer DEFAULT_ACCOUNT = 100;  // 默认账号积分 int型

    @Override
    public List<User> list() {
        return userMapper.list();
    }

    @Override
    public PageInfo<User> page(BaseRequest baseRequest) {
        PageHelper.startPage(baseRequest.getPageNum(), baseRequest.getPageSize());
        // 在service调用mapper方法，通过pageNum和pageSize查分页用户数据
        List<User> users = userMapper.listByCondition(baseRequest);
        return new PageInfo<>(users);
    }

    @Override
    public void save(User user) {
//        System.out.println("新建用户account="+user.getAccount());  如果为null会报空指针
//         getAccount() 是null会报报空指针错误，所以默认给个值100
        // 判空null应该写在左边，否则先执行getAccount() 还是报空指针
        if (null == user.getAccount()) {
            user.setAccount(DEFAULT_ACCOUNT);
        }
        Date date = new Date();
        // 新建时:设置用户名为时间+uuid,保证唯一，当做会员的卡号；时间戳在并发情况下会重复，雪花id是最好的
        user.setUsername(DateUtil.format(date, "yyyyMMdd") + Math.abs(IdUtil.fastSimpleUUID().hashCode()));
        userMapper.save(user);
    }

    @Override
    public User getById(Integer id) {
        return userMapper.getById(id);
    }

    @Override
    public void update(User user) {
        // 更新时，把更新时间设置上
        user.setUpdatetime(new Date());
        userMapper.updateById(user);
    }

    @Override
    public void deleteById(Integer id) {
        userMapper.deleteById(id);
    }

    @Override
    public void handleAccount(User user) {
        // 前端没有传充值积分就return
        Integer score = user.getScore();
        if (score == null) {
            return;
        }
        Integer id = user.getId();
        // 根据前端所传user,从数据库根据id查一次真正存在的user对象，对前端不信任
        User dbUser = userMapper.getById(id);
        // 设置新积分 是累加后的  getAccount() 是null会报报空指针错误，所以默认给个值100
        dbUser.setAccount(dbUser.getAccount() + score);
        // 更新对象
        userMapper.updateById(dbUser);
    }

}
