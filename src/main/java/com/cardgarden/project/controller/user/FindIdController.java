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
public class FindIdController {

	@Autowired
	UserInfoService userInfoSerivce;

	// 1-1. 이름 입력
	@GetMapping("/find-id")
	public String inputNameForm(HttpSession session) {
		return "login/findIdByName";
	}
	
	// 1-2. 이름 세션에 저장
	@PostMapping("/find-id")
	public String setName(HttpSession session, String name) {
		/* 세션에 이름 저장 */
		session.setAttribute("nameForFind", name);
		log.info(name);
		
		return "redirect:/user/find-id/email";
	}
	
	// 2-1. 이메일 입력
	@GetMapping("/find-id/email")
	public String verifyEmailView(Model model) {
		
		model.addAttribute("isJoin", false);
		model.addAttribute("title", "아이디 찾기");
		model.addAttribute("actionLink", "find-id/email");
		
		return "auth/verifyEmail";
	}
	
	// 2-2. 이메일 인증 성공 및 아이디 찾기
	@PostMapping("/find-id/email")
	public String verifyEmailComplete(HttpSession session, RedirectAttributes redirectAttributes) {
		
		Boolean rightAccess = (Boolean) session.getAttribute("emailVerified");
		
		if(Boolean.FALSE.equals(rightAccess)) {
			return "redirect:/wrong";
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String name = (String) session.getAttribute("nameForFind");
		String email = (String) session.getAttribute("verifiedEmail");
		paramMap.put("name", name);
		paramMap.put("email", email);
		log.info(paramMap.toString());
		
		String foundId = userInfoSerivce.getLoginIdByNameAndEmail(paramMap);
		log.info(foundId);
		
		if(foundId == null) {
			redirectAttributes.addFlashAttribute("alertMsg", 
					"입력하신 이름과 이메일이 일치하는 회원정보를 찾을 수 없습니다.");
			return "redirect:/user/find-id";
		}
		
		session.setAttribute("foundId", foundId);
		
		session.removeAttribute("nameForFind");
		session.removeAttribute("emailCode");
		session.removeAttribute("emailExpire");
		session.removeAttribute("emailToVerify");
		session.removeAttribute("emailVerified");
		session.removeAttribute("verifiedEmail");
		
		return "redirect:/user/find-id/success";
	}
	
	// 3. 아이디 찾기 성공
	@GetMapping("/find-id/success")
	public String findIdComplete(HttpSession session, Model model) {
		
		String foundId = (String) session.getAttribute("foundId");	
		
		if(foundId == null || foundId.equals("")) {
			return "redirect:/wrong";
		}
		
		model.addAttribute("foundId", foundId);
		
		return "login/findIdSuccess";
	}
	
}