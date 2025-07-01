package com.cardgarden.project.controller;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("")
public class MainController {
	
	//메인으로 리다이렉트
	@GetMapping("")
	public String redirectToMain(RedirectAttributes redirectAttributes) {
		return "redirect:/main";
	}
	
	//메인화면 연결
	@GetMapping("/main")
	public String mainView(HttpServletRequest request) {
		Calendar cal = Calendar.getInstance();
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); // 1: 일요일, 2: 월요일, ..., 7: 토요일
		request.setAttribute("dayOfWeek", dayOfWeek);
		return "main";
	}
	
}