package com.cardgarden.project.controller.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/wrong")
public class WrongAccessController {
	
	// 잘못된 접근
	@GetMapping("")
	public String wrongAccess() {
		return "/common/wrongAccess";
	}
	
}