package com.wini.winitest.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wini.winitest.mapper.UserMapper;
import com.wini.winitest.vo.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Resource(name = "userMapper")
	private UserMapper userMapper;

	@Override
    public UserVO login(UserVO userVO) throws Exception {
        return userMapper.login(userVO);
    }

    @Override
    public int idCheck(String userId) throws Exception {
        return userMapper.idCheck(userId);
    }

    @Override
    public int register(UserVO userVO) throws Exception {
        return userMapper.register(userVO);
    }
}
