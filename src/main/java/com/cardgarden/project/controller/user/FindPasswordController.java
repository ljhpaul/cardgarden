package com.cardgarden.project.controller.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
public class FindPasswordController {

	@Autowired
	UserInfoService userInfoSerivce;

	// 1. 아이디 입력
	@GetMapping("/find-password")
	public String loginFormView(HttpSession session) {
		return "login/findPwdById";
	}

}