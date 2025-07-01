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
	public String setName(HttpSession session, String user_name) {
		/* 세션에 로그인 아이디 저장 */
		session.setAttribute("loginIdForFind", user_name);
		log.info(user_name);
		
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
		
//		session.removeAttribute("loginIdForFind");
		session.removeAttribute("emailCode");
		session.removeAttribute("emailExpire");
		session.removeAttribute("emailToVerify");
//		session.removeAttribute("emailVerified");
//		session.removeAttribute("verifiedEmail");
		
		return "redirect:/user/find-password/reset";
	}
	
	// 3-1. 비밀번호 재설정
	@GetMapping("/find-password/reset")
	public String findPwdResetView() {
		return "login/findPwdReset";
	}
	
	// 3-2. 비밀번호 재설정 검증
	@PostMapping("/find-password/reset")
	public String findPwdResetProcess(HttpSession session, RedirectAttributes redirectAttributes,
			String prevPwd, String user_password) {
		
		String foundPwd = (String) session.getAttribute("foundPwd");
		log.info(foundPwd + "/" + prevPwd + "/" + user_password);
		
		if(!foundPwd.equals(prevPwd)) {
			redirectAttributes.addFlashAttribute("alertMsg", 
					"입력하신 비밀번호가 기존 비밀번호와 일치하지 않습니다.");
			return "redirect:/user/find-password/reset";
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String user_name = (String) session.getAttribute("loginIdForFind");
		String email = (String) session.getAttribute("verifiedEmail");
		paramMap.put("user_name", user_name);
		paramMap.put("user_password", user_password);
		paramMap.put("email", email);
		log.info(paramMap.toString());
		
		int result = userInfoSerivce.setPasswordByLoginIdAndEmail(paramMap);
		log.info(result + "");
		
		if(result == 0) {
			redirectAttributes.addFlashAttribute("alertMsg", 
					"비밀번호 재설정에 실패했습니다.");
			return "redirect:/user/find-password/reset";
		}
		
		session.removeAttribute("loginIdForFind");
		session.removeAttribute("foundPwd");
		session.removeAttribute("emailVerified");
		session.removeAttribute("verifiedEmail");
		
		return "redirect:/user/find-password/success";
	}
	
	// 4. 비밀번호 재설정 성공
	@GetMapping("/find-password/success")
	public String findPwdSuccess() {
		return "login/findPwdSuccess";
	}
	
}