package com.wini.winitest.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import com.wini.winitest.vo.UserVO;

@Mapper("userMapper")
public interface UserMapper {
	UserVO login(UserVO userVO) throws Exception;

	int idCheck(String userId) throws Exception; // 중복확인 0 사용가능 1 중복

	int register(UserVO userVO) throws Exception;
}