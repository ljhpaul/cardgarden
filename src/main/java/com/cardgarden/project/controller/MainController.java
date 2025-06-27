package com.cardgarden.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("")
public class MainController {
	
	//메인으로 리다이렉트
	@GetMapping("")
	public String redirectToMain() {
		return "redirect:/main";
	}
	
	//메인화면 연결
	@GetMapping("/main")
	public String mainView() {
		return "main";
	}
	
}