package com.wini.winitest.service;

import java.util.List;

import com.wini.winitest.vo.CityVO;

public interface CityService {
    List<CityVO> getCityList() throws Exception;
}