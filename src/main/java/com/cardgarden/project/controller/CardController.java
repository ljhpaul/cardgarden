package com.cardgarden.project.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CardController {
	
	@GetMapping("/cardAll")
	public String cardall() {
		
		return "cardSelect/cardAll";
	}
	
	@PostMapping("/cardAll")
	public void cardSearch(@RequestParam("category") String[] selectedCategories) {
		System.out.println(selectedCategories.length);
	}
}
