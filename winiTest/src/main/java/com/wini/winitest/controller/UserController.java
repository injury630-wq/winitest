package com.wini.winitest.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import com.wini.winitest.service.UserService;
import com.wini.winitest.sessionlistener.EgovHttpSessionBindingListener;
import com.wini.winitest.vo.UserVO;

@Controller
public class UserController {

	@Resource(name = "userService")
	private UserService userService;

	// 로그인 페이지
	@RequestMapping(value = "/user/login.do", method = RequestMethod.GET)
	public String loginView(HttpSession session) {
		// 이미 로그인된 경우 게시판으로 이동
		if (session.getAttribute("loginUser") != null) {
			return "redirect:/board/list.do";
		}
		return "user/login";
	}

	// 일반 로그인 처리 (session)
	// @RequestMapping(value = "/user/login.do", method = RequestMethod.POST)
	// public String login(@ModelAttribute UserVO userVO, HttpSession session) //Spring이 세션을 주입해줌
	// throws Exception {
	// UserVO loginUser = userService.login(userVO);
	// if(loginUser != null) {
	// session.setAttribute("loginUser", loginUser);
	// return "redirect:/board/list.do";
	// }
	// return "redirect:/user/login.do?error=1";
	// }

	// 중복 로그인 처리 (requestsession)
	@RequestMapping(value = "/user/login.do", method = RequestMethod.POST)
	public String login(@ModelAttribute UserVO userVO, HttpServletRequest request, ModelMap model) throws Exception {
		System.out.println("로그인 요청..");
		UserVO resultVO = userService.login(userVO);
		if (resultVO != null && resultVO.getUserId() != null) {
			request.getSession().setAttribute("loginUser", resultVO);
			EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
			// 세션에 userId로 listener 바인딩 이 순간 valueBound() 자동 호출
			request.getSession().setAttribute(resultVO.getUserId(), listener);

			return "redirect:/board/list.do";
		} else {
			return "redirect:/user/login.do?error=1";
		}
	}

	// 중복로그인 로그아웃
	@RequestMapping(value = "/user/logout.do", method = RequestMethod.POST)
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		System.out.println("로그아웃 요청...");
		try {
			RequestContextHolder.getRequestAttributes().removeAttribute("loginUser", RequestAttributes.SCOPE_SESSION);

			request.getSession().invalidate();

		} catch (Exception e) {
		}
		return "redirect:/board/list.do";
	}

	// 일반 로그아웃
	// @RequestMapping(value = "/user/logout.do", method = RequestMethod.POST)
	// public String logout(HttpSession session) {
	// session.invalidate();
	// return "redirect:/user/login.do";
	// }

	// 회원가입 페이지
	@RequestMapping(value = "/user/register.do", method = RequestMethod.GET)
	public String registerView() {
		return "user/register";
	}

	// 아이디 중복확인 (Ajax)
	@ResponseBody
	@RequestMapping(value = "/user/idCheck.do", method = RequestMethod.GET)
	public int idCheck(@RequestParam String userId) throws Exception {
		// System.out.println("aaaaaaaaaaaaaaaaaaaaa");
		return userService.idCheck(userId);
	}

	// 회원가입 처리
	@RequestMapping(value = "/user/register.do", method = RequestMethod.POST)
	public String register(@ModelAttribute UserVO userVO) throws Exception {
		int result = userService.register(userVO);
		if (result > 0) {
			return "redirect:/user/login.do?join=1";
		}
		return "redirect:/user/register.do?error=1";
	}
}
