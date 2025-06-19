package com.cardgarden.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cardgarden.project.model.recommendAI.CardRecommendationService;

@Controller
@RequestMapping("recommend")
public class RecommendAIController {
	
	@Autowired
	private CardRecommendationService cardRecommendationService;
	
//	@GetMapping("/ai")
//	public List<String> recommend(@RequestParam("patternid") int pattern){
//		
//	}
//	
	
	
}
