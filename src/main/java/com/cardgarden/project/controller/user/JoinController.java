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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user/join")
public class JoinController {
	
	@Autowired
	TermService termService;
	
	//0.회원가입 방법 선택
	@GetMapping("/method")
	public String joinMethodView() {
		return "join/joinMethod";
	}
	
	//1-1.약관 동의
	@GetMapping("/term")
	public String termAgreeView(Model model) {
		List<TermDTO> termList = termService.selectAll();
		model.addAttribute("termList", termList);
		return "join/termAgree";
	}
	
	//1-2.약관 동의 여부 확인
	@PostMapping("/term")
	public String termAgreeCheck(
			@RequestParam List<Integer> checkedTermList, 
			HttpSession session) {
		
		log.info(checkedTermList.toString());
		
		//사용자가 뒤로가기 등으로 다시 약관 동의를 수정할 경우 덮어쓰기됨
		session.setAttribute("checkedTermList", checkedTermList);
		
		String socialJoin = (String) session.getAttribute("socialJoin");
		
		if(socialJoin == null || "".equals(socialJoin)) {
			return "redirect:/user/join/email";
		} else {
			/* 정보입력 자동완성 */
			
			return "redirect:/user/join/inputInfo";
		}
	}
	
	@GetMapping("/email")
	public String verifyEmailView() {
	    return "join/verifyEmail";
	}
	
}
















