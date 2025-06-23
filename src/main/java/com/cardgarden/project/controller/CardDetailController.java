package com.cardgarden.project.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cardgarden.project.model.cardDetail.CardDTO;
import com.cardgarden.project.model.cardDetail.CardDetailDTO;
import com.cardgarden.project.model.cardDetail.CardService;
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
   

    @RequestMapping("/detail")
    public String cardDetail(@RequestParam("cardid")int cardid, Model model) {
    	int userid1 = 1;
    	CardDTO card = cardLkieService.selectByIdWithLike(cardid, userid1);
    	List<CardDTO> cardList = new ArrayList<>();
    	cardList.add(card);
    	model.addAttribute("cardList", cardList);
        List<CardDetailDTO> detailList = cardService.selectDetailByID(cardid);
        Map<String, List<CardDetailDTO>> mapData = new LinkedHashMap<>();

        for (CardDetailDTO dto : detailList) {
            String groupKey = dto.getBenefitdetail_name();
            mapData.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(dto);
        }
        model.addAttribute("cardDetail", mapData);
        
//        int userId1=1;
        List<UserPatternBenefitDTO> dataList = userPatternBenefitService.selectByIdConsumPattern(userid1);

        Map<Integer, List<UserPatternBenefitDTO>> mapPattern = new LinkedHashMap<>();
        for (UserPatternBenefitDTO dto : dataList) {
            int groupKey = dto.getPattern().getPattern_id();
            mapPattern.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(dto);
        }
        model.addAttribute("patternList", mapPattern);
        
        return "card/cardDetail";
    }
}
