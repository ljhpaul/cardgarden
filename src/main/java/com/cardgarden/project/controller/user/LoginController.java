package com.cardgarden.project.controller.user;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cardgarden.project.model.term.dto.TermDTO;
import com.cardgarden.project.model.term.service.TermService;
import com.cardgarden.project.model.user.dto.UserAgreementDTO;
import com.cardgarden.project.model.user.dto.UserInfoDTO;
import com.cardgarden.project.model.user.service.UserAgreementService;
import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user/login")
public class LoginController {
	
	@Autowired
	TermService termService;
	@Autowired
	UserInfoService userInfoSerivce;
	@Autowired
	UserAgreementService userAgreementService;
	
	//1-1. 로그인 입력창
	@GetMapping("")
	public String loginFormView() {
		return "login/loginForm";
	}
	
	//1-2. 로그인 처리
	@PostMapping("")
	public String loginProcess(
			@RequestParam List<Integer> checkedTermList, 
			HttpSession session) {
			
		return "redirect:/main";
	}
	
}