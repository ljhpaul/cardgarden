package com.cardgarden.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.cardgarden.project.model.cardSelect.UserConsumptionPatternDTO;
import com.cardgarden.project.model.cardSelect.UserConsumptionPatternService;


@Controller
public class CardController {

	@Autowired
	UserConsumptionPatternService ucpService;

	String namespace = "com.cardgarden.inCon.";
	
	@GetMapping("/inCon.do")
	public String insertView(Model model) {
		
	
		List<UserConsumptionPatternDTO>  benefitCategorylist = ucpService.selectAll();
		
		System.out.println(benefitCategorylist.size());
	    model.addAttribute("benefitCategorylist", benefitCategorylist); // JSP���� �� �̸����� ��� ����
		
		return "cardgarden/insertUserConsumptionPattern"; // �� �̸�
		
	}
	
	@GetMapping("/cardAll.do")
	public String cardall() {
		
		return "cardgarden/cardAll";
	}

	

}
