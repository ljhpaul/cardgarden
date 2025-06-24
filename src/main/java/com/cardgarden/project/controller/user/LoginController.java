package com.cardgarden.project.controller.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cardgarden.project.model.user.dto.LoginRequestDTO;
import com.cardgarden.project.model.term.service.TermService;
import com.cardgarden.project.model.user.service.UserAgreementService;
import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
public class LoginController {

	@Autowired
	UserInfoService userInfoSerivce;

	// 1-1. 로그인 입력창
	@GetMapping("/login")
	public String loginFormView() {
		return "login/loginForm";
	}

	// 1-2. 로그인 처리
	@PostMapping("/login")
	public String loginProcess(HttpSession session, LoginRequestDTO inputData) {

		String inputLoginId = inputData.getUser_name();
		String inputLoginPassword = inputData.getUser_password();

		log.info("(" + inputLoginId + ", " + inputLoginPassword + ")");

		boolean userExist = userInfoSerivce.existsByLoginId(inputLoginId);
		if(!userExist) {
			log.info("존재하지 않는 아이디입니다.");
			return "login/loginForm";
		}
		
		String password = userInfoSerivce.getPasswordByLoginId(inputLoginId);
		log.info("비밀번호: " + password);
		
		if(!inputLoginPassword.equals(password)) {
			log.info("비밀번호가 일치하지 않습니다.");
			return "login/loginForm";
		}
		
		int loginUserId = userInfoSerivce.getUserIdByLoginId(inputLoginId);
		log.info("로그인 성공");
		session.setAttribute("loginUserId", loginUserId);
		return "main";
	}
	
	// 2. 로그아웃
	@GetMapping("/logout")
	public String logoutProcess(HttpSession session) {
		session.removeAttribute("loginUserId");
		return "redirect:/main";
	}

}