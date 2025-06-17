package com.cardgarden.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
<<<<<<< HEAD
<<<<<<< Updated upstream

import com.cardgarden.project.model.selectCard.UserConsumptionPatternDTO;
import com.cardgarden.project.model.selectCard.UserConsumptionPatternService;
@Controller
=======
=======
>>>>>>> de1acd047e6abcfe4fd4d33b3d5750bd560c51b4
import org.springframework.web.bind.annotation.RequestMapping;

import com.cardgarden.project.model.cardSelectAll.UserConsumptionPatternDTO;
import com.cardgarden.project.model.cardSelectAll.UserConsumptionPatternService;

@Controller
@RequestMapping("/card")
<<<<<<< HEAD
>>>>>>> Stashed changes
=======
>>>>>>> de1acd047e6abcfe4fd4d33b3d5750bd560c51b4
public class CardController {
	
	@Autowired
	UserConsumptionPatternService ucpService;
<<<<<<< HEAD
<<<<<<< Updated upstream
	
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

=======
>>>>>>> Stashed changes
	
	String namespace = "com.cardgarden.inCon.";
	
=======
	
	String namespace = "com.cardgarden.inCon.";
	
>>>>>>> de1acd047e6abcfe4fd4d33b3d5750bd560c51b4
	@GetMapping("/inCon.do")
	public String insertView(Model model) {
		
	
		List<UserConsumptionPatternDTO>  benefitCategorylist = ucpService.selectAll();
		
		System.out.println(benefitCategorylist.size());
	    model.addAttribute("benefitCategorylist", benefitCategorylist); // JSP에서 이 이름으로 사용 가능
		
		return "cardgarden/insertUserConsumptionPattern"; // 뷰 이름
		
	}
	
	@GetMapping("/cardAll.do")
	public String cardall() {
		
		return "cardSelect/cardAll";
	}

}
