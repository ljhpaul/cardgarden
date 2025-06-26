package com.cardgarden.project.controller;

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
import com.cardgarden.project.model.cardDetail.CardDetailDTO;
import com.cardgarden.project.model.cardDetail.CardService;
import com.cardgarden.project.model.recommendAI.CardRecommendationDTO;
import com.cardgarden.project.model.recommendAI.CardRecommendationService;
import com.cardgarden.project.model.userCardLike.CardLikeService;
import com.cardgarden.project.model.userPatternBenefit.UserPatternBenefitDTO;
import com.cardgarden.project.model.userPatternBenefit.UserPatternBenefitService;

@Controller
@RequestMapping("/card")
public class CardDetailController {

    @Autowired
    private CardService cardService;
    
    @Autowired
    private UserPatternBenefitService userPatternBenefitService;
    
    @Autowired
    private CardLikeService cardLkieService;
    @Autowired
    private CardRecommendationService cardRecommendationService;

    @RequestMapping("/detail")
    public String cardDetail(@RequestParam("cardid") int cardid,
    	    @RequestParam(value="patternId", required=false) Integer patternId,
    	    Model model,
    	    HttpSession session) {
    	Integer userId = (Integer) session.getAttribute("loginUserId");
 
    	if (userId!=null) {
    		CardDTO card = cardLkieService.selectByIdWithLike(cardid, userId);
    		List<CardDTO> cardList = new ArrayList<>();
        	cardList.add(card);
        	model.addAttribute("cardList", cardList);
        	List<UserPatternBenefitDTO> dataList = userPatternBenefitService.selectByIdConsumPattern(userId);

            Map<Integer, List<UserPatternBenefitDTO>> mapPattern = new LinkedHashMap<>();
            for (UserPatternBenefitDTO dto : dataList) {
                int groupKey = dto.getPattern().getPattern_id();
                mapPattern.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(dto);
            }
            model.addAttribute("patternList", mapPattern);
            
          //해당 카드와 유사한 카드 top 3
        	List<CardRecommendationDTO> cardCosineList = cardRecommendationService.getRecommendCosine(cardid);
        	Map<Integer,List<CardDTO>> cosineData = new LinkedHashMap<>();
        	for (CardRecommendationDTO dto: cardCosineList) {
        		int groupKey = dto.getCard_id();
        		List<CardDTO> cardList1 = cardService.selectById(groupKey);
        		cosineData.computeIfAbsent(groupKey, k -> new ArrayList<>()).addAll(cardList1);
        		System.out.println(cosineData);
        	}
        	model.addAttribute("cosineData",cosineData);
        	
//        	
//        	List<CardDTO> cardList = cardService.selectById(cardid);
//        	model.addAttribute("cardList", cardList);
        	
            List<CardDetailDTO> detailList = cardService.selectDetailByID(cardid);
            Map<String, List<CardDetailDTO>> mapData = new LinkedHashMap<>();

            for (CardDetailDTO dto : detailList) {
                String groupKey = dto.getBenefitdetail_name();
                mapData.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(dto);
            }
            model.addAttribute("cardDetail", mapData);
            
                    
            session.setAttribute("cardid", cardid);
            
            System.out.println("patternId: " + patternId + ", cardid: " + cardid);

            if(patternId != null){
                List<CardRecommendationDTO> aiDetailResult = 
                    cardRecommendationService.getRecommendDetailResult(patternId, cardid);
                model.addAttribute("aiDetailResult", aiDetailResult);
                System.out.println(aiDetailResult);
            }
            

    	}else if (userId==null) {
    		List<CardDTO> cardList = cardService.selectById(cardid);
        	model.addAttribute("cardList", cardList);
    		
    		//해당 카드와 유사한 카드 top 3
        	List<CardRecommendationDTO> cardCosineList = cardRecommendationService.getRecommendCosine(cardid);
        	Map<Integer,List<CardDTO>> cosineData = new LinkedHashMap<>();
        	for (CardRecommendationDTO dto: cardCosineList) {
        		int groupKey = dto.getCard_id();
        		List<CardDTO> cardList1 = cardService.selectById(groupKey);
        		cosineData.computeIfAbsent(groupKey, k -> new ArrayList<>()).addAll(cardList1);
        		System.out.println(cosineData);
        	}
        	model.addAttribute("cosineData",cosineData);
        	
        	
            List<CardDetailDTO> detailList = cardService.selectDetailByID(cardid);
            Map<String, List<CardDetailDTO>> mapData = new LinkedHashMap<>();

            for (CardDetailDTO dto : detailList) {
                String groupKey = dto.getBenefitdetail_name();
                mapData.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(dto);
            }
            model.addAttribute("cardDetail", mapData);
            
                    
            session.setAttribute("cardid", cardid);
            
            System.out.println("patternId: " + patternId + ", cardid: " + cardid);

            if(patternId != null){
                List<CardRecommendationDTO> aiDetailResult = 
                    cardRecommendationService.getRecommendDetailResult(patternId, cardid);
                model.addAttribute("aiDetailResult", aiDetailResult);
                System.out.println(aiDetailResult);
            }
            
    	}
    	
    	return "card/cardDetail";
    	
    }
}
