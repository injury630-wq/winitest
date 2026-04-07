package com.wini.winitest.service;

import com.wini.winitest.vo.UserVO;

public interface UserService {
	UserVO login(UserVO userVO) throws Exception;

	int idCheck(String userId) throws Exception; // 중복확인 0 사용가능 1 중복

	int register(UserVO userVO) throws Exception;
}
