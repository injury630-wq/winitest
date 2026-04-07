package com.wini.winitest.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wini.winitest.service.CityService;
import com.wini.winitest.vo.CityVO;

@Controller
public class CityController {
	
	@Resource(name = "cityService")
    private CityService cityService;

    @RequestMapping("/city/list")
    public String cityList(Model model) throws Exception {
        List<CityVO> list = cityService.getCityList();
        model.addAttribute("cityList", list);
        return "city/list";
    }
}
