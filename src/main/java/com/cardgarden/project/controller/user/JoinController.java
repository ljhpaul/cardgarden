package com.cardgarden.project.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/join")
public class JoinController {
	
	//0.회원가입 방법 선택
	@GetMapping("/method")
	public String joinMethod() {
		return "join/joinMethod";
	}
	
}
