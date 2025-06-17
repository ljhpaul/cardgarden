package com.cardgarden.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.cardgarden.project.model.selectCard.UserConsumptionPatternDTO;
import com.cardgarden.project.model.selectCard.UserConsumptionPatternService;
@Controller
public class CardController {
	
	@Autowired
	UserConsumptionPatternService ucpService;
	
	String namespace = "com.cardgarden.inCon.";
	
	@GetMapping("/inCon")
	public String insertView(Model model) {
		
	
		List<UserConsumptionPatternDTO>  benefitCategorylist = ucpService.selectAll();
		
		System.out.println(benefitCategorylist.size());
	    model.addAttribute("benefitCategorylist", benefitCategorylist); // JSP에서 이 이름으로 사용 가능
		
		return "cardgarden/insertUserConsumptionPattern"; // 뷰 이름
		
	}
	
	@GetMapping("/cardAll")
	public String cardall() {
		
		return "cardSelect/cardAll";
	}

	

}
