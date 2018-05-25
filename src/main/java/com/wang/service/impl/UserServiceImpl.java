package com.wang.service.impl;

import com.wang.entity.User;
import com.wang.mapper.UserMapper;
import com.wang.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Desc
 * @Author wang926454
 * @Date 2018/5/25 10:06
 */
@Service
public class UserServiceImpl extends BaseServiceImpl<User> implements IUserService {
}
