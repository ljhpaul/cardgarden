package com.cardgarden.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/card")
public class CardRankController {
	
	@RequestMapping("/cardRank")
	public String showCardRankPage() {
	    return "card/cardRank"; // /WEB-INF/views/card/cardRank.jsp 를 렌더링
	}
}
