package com.cardgarden.project.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cardgarden.project.model.term.dto.TermDTO;
import com.cardgarden.project.model.term.service.TermService;

@Controller
@RequestMapping("/user/join")
public class JoinController {
	
	@Autowired
	TermService termService;
	
	//0.회원가입 방법 선택
	@GetMapping("/method")
	public String joinMethod() {
		return "join/joinMethod";
	}
	
	//1-1.약관 동의
	@GetMapping("/term")
	public String termAgree(Model model) {
		List<TermDTO> termList = termService.selectAll();
		model.addAttribute("termList", termList);
		return "join/termAgree";
	}
	
	//1-2.약관 동의 여부 확인
	@PostMapping("/term")
	public String termAgreeCheck() {
		return "join/termAgree";
	}
	
}
