package com.cardgarden.project.controller.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cardgarden.project.model.user.service.UserInfoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
public class FindPasswordController {

	@Autowired
	UserInfoService userInfoSerivce;

	// 1-1. 로그인 아이디 입력
	@GetMapping("/find-password")
	public String inputNameForm(HttpSession session) {
		return "login/findPwdById";
	}
	
	// 1-2. 로그인 아이디 세션에 저장
	@PostMapping("/find-password")
	public String setName(HttpSession session, String loginId) {
		/* 세션에 로그인 아이디 저장 */
		session.setAttribute("loginIdForFind", loginId);
		log.info(loginId);
		
		return "redirect:/user/find-password/email";
	}
	
	// 2-1. 이메일 입력
	@GetMapping("/find-password/email")
	public String verifyEmailView(Model model) {
		
		model.addAttribute("isJoin", false);
		model.addAttribute("title", "비밀번호 찾기");
		model.addAttribute("actionLink", "find-password/email");
		
		return "auth/verifyEmail";
	}
	
	// 2-2. 이메일 인증 성공 및 비밀번호 찾기
	@PostMapping("/find-password/email")
	public String verifyEmailComplete(HttpSession session, RedirectAttributes redirectAttributes) {
		
		Boolean rightAccess = (Boolean) session.getAttribute("emailVerified");
		
		if(Boolean.FALSE.equals(rightAccess)) {
			return "redirect:/wrong";
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String user_name = (String) session.getAttribute("loginIdForFind");
		String email = (String) session.getAttribute("verifiedEmail");
		paramMap.put("user_name", user_name);
		paramMap.put("email", email);
		log.info(paramMap.toString());
		
		String foundPwd = userInfoSerivce.getPasswordByLoginIdAndEmail(paramMap);
		log.info(foundPwd);
		
		if(foundPwd == null) {
			redirectAttributes.addFlashAttribute("alertMsg", 
					"입력하신 아이디와 이메일이 일치하는 회원정보를 찾을 수 없습니다.");
			return "redirect:/user/find-password";
		}
		
		session.setAttribute("foundPwd", foundPwd);
		
		session.removeAttribute("loginIdForFind");
		session.removeAttribute("emailCode");
		session.removeAttribute("emailExpire");
		session.removeAttribute("emailToVerify");
		session.removeAttribute("emailVerified");
		session.removeAttribute("verifiedEmail");
		
		return "redirect:/user/find-password/success";
	}
	
	// 3. 아이디 찾기 성공
	@GetMapping("/find-password/success")
	public String findPwdComplete(HttpSession session, Model model) {
		
		String foundPwd = (String) session.getAttribute("foundPwd");	
		
		if(foundPwd == null || foundPwd.equals("")) {
			return "redirect:/wrong";
		}
		
		model.addAttribute("foundPwd", foundPwd);
		
		return "login/findPwdSuccess";
	}
	
}