package com.wini.winitest.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wini.winitest.mapper.CityMapper;
import com.wini.winitest.vo.CityVO;

@Service("cityService")
public class CityServiceImpl implements CityService {
	
	@Resource(name = "cityMapper")
	private CityMapper cityMapper;

	@Override
	public List<CityVO> getCityList() throws Exception {
		return cityMapper.getCityList();
	}

}
