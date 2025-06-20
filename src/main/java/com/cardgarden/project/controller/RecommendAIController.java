package com.cardgarden.project.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cardgarden.project.model.recommendAI.CardRecommendationService;

@Controller
@RequestMapping("/recommend")
public class RecommendAIController {
	
	@Autowired
	private CardRecommendationService cardRecommendationService;
	
	
	@RequestMapping("/aiResult")
	public String cardDetail(@RequestParam("patternId") int patternId, Model model) {
		System.out.println("현재 작업 디렉토리: " + new File(".").getAbsolutePath());
		
		try {
			model.addAttribute("aiList",cardRecommendationService.getRecommendResult(patternId));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "recommend/aiResult";
	}
	
}
