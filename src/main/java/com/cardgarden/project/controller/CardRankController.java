package com.cardgarden.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cardgarden.project.model.card.CardDTO;
import com.cardgarden.project.model.card.CardRankService;

@Controller
@RequestMapping("/card")
public class CardRankController {
	
	@Autowired
    CardRankService cardRankService;
	
	@RequestMapping("/rank")
	public String showCardRankPage() {
	    return "card/cardRank";
	}
	@RequestMapping("/rankResult")
	public String cardRankResult(@RequestParam("type") String type, Model model) {
	    List<CardDTO> cardList = null;

	    switch (type) {
	        case "all":
	            cardList = cardRankService.getTop10All();
	            break;
	        case "credit":
	            cardList = cardRankService.getTop10ByType("신용카드");
	            break;
	        case "check":
	            cardList = cardRankService.getTop10ByType("체크카드");
	            break;
	        case "신한":
	        case "삼성":
	        case "현대":
	        case "롯데":
	        case "우리":
	        case "국민":
	        case "하나":
	        case "농협":
	        case "IBK":
	        case "BC":
	            cardList = cardRankService.getTop10ByCompany(type);
	            break;
	        default:
	            // 혜택카테고리로 판단
	            cardList = cardRankService.getTop10ByBenefit(type);
	            break;
	    }

	    model.addAttribute("cardList", cardList);
	    return "card/cardRankResult";
	}


	
	
}
