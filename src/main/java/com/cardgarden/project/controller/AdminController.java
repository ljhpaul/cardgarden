package com.cardgarden.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	
	@GetMapping("/admin")
	public String AdminMainView() {
		
		return "admin/adminMainView";
	}

}
