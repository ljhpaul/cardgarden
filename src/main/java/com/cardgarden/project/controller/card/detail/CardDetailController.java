package com.cardgarden.project.controller.card.detail;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cardgarden.project.model.cardDetail.CardDTO;
import com.cardgarden.project.model.cardDetail.CardDetailDTO;
import com.cardgarden.project.model.cardDetail.CardService;
import com.cardgarden.project.model.recommendAI.CardRecommendationDTO;
import com.cardgarden.project.model.recommendAI.CardRecommendationService;
import com.cardgarden.project.model.recommendAI.RecommendResultDTO;
import com.cardgarden.project.model.user.dto.UserInfoDTO;
import com.cardgarden.project.model.user.service.UserInfoService;
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
    
    @Autowired
    private UserInfoService userInfoService;
    
    @Value("${ai.recommendation.enabled:true}") // 기본값 true
    private boolean aiRecommendationEnabled;
    
    @Value("${recommend.api.url}")
    private String recommendApiUrl;
    
    

    @RequestMapping("/detail")
    public String cardDetail(@RequestParam("cardid") int cardid,
                             @RequestParam(value = "patternId", required = false) Integer patternId,
                             Model model,
                             HttpSession session) {
        Integer userId = (Integer) session.getAttribute("loginUserId");
        
        System.out.println("[DEBUG] aiRecommendationEnabled = " + aiRecommendationEnabled);
        System.out.println("[DEBUG] Properties recommend.api.url = " + recommendApiUrl);
        
        // 카드 기본 정보 (로그인 여부에 따라 다름)
        List<CardDTO> cardList = getCardList(cardid, userId);
        model.addAttribute("cardList", cardList);

        // 카드 상세 혜택 정보
        Map<String, List<CardDetailDTO>> cardDetailMap = getCardDetailMap(cardid);
        model.addAttribute("cardDetail", cardDetailMap);

        // 유사 카드 Top3
        Map<Integer, List<CardDTO>> cosineData = null;
        if(aiRecommendationEnabled) {
        	cosineData = getCosineCardData(cardid);
        } else {
        	cosineData = new LinkedHashMap<>();
        }
        model.addAttribute("cosineData", cosineData);

        // userId가 있을 때만 패턴 관련 정보 추가
        if (userId != null) {
            Map<Integer, List<UserPatternBenefitDTO>> patternList = getPatternList(userId);
            model.addAttribute("patternList", patternList);
            model.addAttribute("userInfo",userInfoService.selectById(userId));
            
        }

        // patternId가 있으면 AI 추천 결과 추가
        if (patternId != null && aiRecommendationEnabled && userId != null) {
            List<RecommendResultDTO> aiDetailResult =
                    cardRecommendationService.getRecommendDetailResult(patternId, cardid);
            model.addAttribute("aiDetailResult", aiDetailResult);
            model.addAttribute("benefitDetail",cardService.selectPatternCardID(patternId, cardid));
            System.out.println(aiDetailResult);
        }
        
        session.setAttribute("cardid", cardid);
        System.out.println("patternId: " + patternId + ", cardid: " + cardid);

        return "card/cardDetail";
    }

    /** 로그인 여부에 따라 카드정보 반환 */
    private List<CardDTO> getCardList(int cardid, Integer userId) {
        if (userId != null) {
            CardDTO card = cardLkieService.selectByIdWithLike(cardid, userId);
            List<CardDTO> cardList = new ArrayList<>();
            cardList.add(card);
            return cardList;
        } else {
            return cardService.selectById(cardid);
        }
    }

    /** 카드 상세 혜택 Map */
    private Map<String, List<CardDetailDTO>> getCardDetailMap(int cardid) {
        List<CardDetailDTO> detailList = cardService.selectDetailByID(cardid);
        Map<String, List<CardDetailDTO>> mapData = new LinkedHashMap<>();
        for (CardDetailDTO dto : detailList) {
            String groupKey = dto.getBenefitdetail_name();
            mapData.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(dto);
        }
        return mapData;
    }

    /** 유사 카드 Map */
    private Map<Integer, List<CardDTO>> getCosineCardData(int cardid) {
    	if (!aiRecommendationEnabled) {
            return new LinkedHashMap<>(); // 로컬에서 호출 차단
        }
        List<CardRecommendationDTO> cardCosineList = cardRecommendationService.getRecommendCosine(cardid);
        Map<Integer, List<CardDTO>> cosineData = new LinkedHashMap<>();
        for (CardRecommendationDTO dto : cardCosineList) {
            int groupKey = dto.getCard_id();
            if (groupKey != cardid) {
                List<CardDTO> cardList1 = cardService.selectById(groupKey);
                cosineData.computeIfAbsent(groupKey, k -> new ArrayList<>()).addAll(cardList1);
            }
        }
        return cosineData;
    }

    /** 사용자 패턴 리스트 Map */
    private Map<Integer, List<UserPatternBenefitDTO>> getPatternList(Integer userId) {
        List<UserPatternBenefitDTO> dataList = userPatternBenefitService.selectByIdConsumPattern(userId);
        Map<Integer, List<UserPatternBenefitDTO>> mapPattern = new LinkedHashMap<>();
        for (UserPatternBenefitDTO dto : dataList) {
            int groupKey = dto.getPattern().getPattern_id();
            mapPattern.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(dto);
        }
        return mapPattern;
    }
}

