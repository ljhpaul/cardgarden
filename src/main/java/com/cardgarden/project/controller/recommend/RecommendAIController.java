package com.cardgarden.project.controller.recommend;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cardgarden.project.model.cardDetail.CardDTO;
import com.cardgarden.project.model.cardDetail.CardService;
import com.cardgarden.project.model.recommendAI.CardRecommendationDTO;
import com.cardgarden.project.model.recommendAI.CardRecommendationService;

@Controller
@RequestMapping("/recommend")
public class RecommendAIController {
	
	@Autowired
	private CardRecommendationService cardRecommendationService;
	
	@Autowired
	private CardService cardService;
	
	@RequestMapping("/aiResult")
	public String cardDetail(Model model, HttpSession session) throws Exception {
		Integer patternId = (Integer) session.getAttribute("patternId");
		System.out.println(patternId);
		if (patternId == null) {
	        return "redirect:/recommend/ai";
	    }
	    List<CardRecommendationDTO> dataList = cardRecommendationService.getRecommendResult(patternId);

	    Map<Integer, List<CardDTO>> mapData = new LinkedHashMap<>();
	    for (CardRecommendationDTO dto : dataList) {
	        Integer groupKey = dto.getCard_id();
	        mapData.computeIfAbsent(groupKey, k -> new ArrayList<>())
	               .addAll(cardService.selectById(groupKey));
	    }
	    try {
	        System.out.println(dataList);
	        model.addAttribute("aiList", dataList);    // 추천 리스트
	        model.addAttribute("cardDetailMap", mapData); // 카드 상세 정보 Map (필요할 때)
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    session.setAttribute("patternId", patternId);
	    return "recommend/aiResult";

	}
	
	
	@RequestMapping("/selectPattern")
	public String selectPattern(@RequestParam("patternId") Integer patternId, HttpSession session) {
	    session.setAttribute("patternId", patternId);
	    return "redirect:/recommend/aiResult";
	}

	
	
}
