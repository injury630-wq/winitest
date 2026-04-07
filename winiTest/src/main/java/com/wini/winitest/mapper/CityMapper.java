package com.wini.winitest.mapper;

import java.util.List;

import com.wini.winitest.vo.CityVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("cityMapper")
public interface CityMapper {
	List<CityVO> getCityList();
}
