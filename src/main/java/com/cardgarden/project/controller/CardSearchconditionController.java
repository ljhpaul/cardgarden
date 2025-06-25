package com.cardgarden.project.controller;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cardgarden.project.model.CardSearchCondition.CardDTO;
import com.cardgarden.project.model.CardSearchCondition.CardSearchConditionService;
import com.cardgarden.project.model.benefitCategory.benefitCategoryDTO;
import com.cardgarden.project.model.benefitDetail.BenefitDetailDTO;
import com.cardgarden.project.model.benefitDetail.BenefitDetailService;

@Controller
public class CardSearchconditionController {
	
	@Autowired
	BenefitDetailService btdService;
	
	@Autowired
	CardSearchConditionService cscService;
	
	@GetMapping("/cardSearchcondition")
	public String cardSearchView(Model model) {
		
	    // 모든 혜택 상세 항목과 카테고리 조회
	    List<BenefitDetailDTO> benefitDetailList = btdService.selectAll();
	    List<benefitCategoryDTO> benefitCategoryList = btdService.selectAllBenefitCategory();

	    //각 카테고리별 혜택 상세 개수 카운트
	    Map<Integer, Long> detailCountMap = benefitDetailList.stream()
	        .collect(Collectors.groupingBy(BenefitDetailDTO::getBenefitcategory_id, Collectors.counting()));
	
	    // 카테고리를 혜택 개수 기준으로 내림차순 정렬
	    benefitCategoryList.sort((a, b) -> {
	        Long countA = detailCountMap.getOrDefault(a.getBenefitcategory_id(), 0L);
	        Long countB = detailCountMap.getOrDefault(b.getBenefitcategory_id(), 0L);
	        return Long.compare(countB, countA); // 많은 것부터 앞으로
	    });
	    
		model.addAttribute("benefitDetailList", benefitDetailList);
		model.addAttribute("benefitCategoryList",benefitCategoryList);
		
		return "cardSearchcondition/cardSearchcondition";
	}
	
	@GetMapping("/cardSearchconditionSucces")
	public String cardSearchconditionSuccesView() {
		
		return "cardSearchcondition/cardSearchconditionSucces";
	}
	
	@PostMapping("/cardSearchcondition")
	public String cardSearchcondition(@RequestParam(name = "category", required = false) String[] selectedCategories,
					@RequestParam("cardType") String[] selectedcardType,Model model) {
		System.out.println(Arrays.toString(selectedcardType));
		
	    Map<String, Object> param = new HashMap<>();
	    
	    if (selectedCategories != null) {
			System.out.println(selectedCategories.length);
			System.out.println(Arrays.toString(selectedCategories));
	        param.put("selectedCategories", Arrays.asList(selectedCategories));
	        param.put("categorySize", selectedCategories.length);
	    }
	    param.put("selectedcardType", Arrays.asList(selectedcardType));
		
		//조건에 맞게 검색하기
	    List<CardDTO> CardList = cscService.cardSearchcondition(param);
	    
	    // 카드 잘 넘어오나?
//	    for (CardDTO card : CardList) {
//	        System.out.println(card);
//	    }
		
	    model.addAttribute("CardList", CardList);
	    
	    return "cardSearchcondition/cardSearchconditionSucces";
		
		}
	
	@PostMapping("/cardCount")
	@ResponseBody
	public int getCardCount(@RequestParam(name = "category", required = false) String[] selectedCategories,
	                        @RequestParam("cardType") String[] selectedcardType) {
	    Map<String, Object> param = new HashMap<>();

	    if (selectedCategories != null) {
	        param.put("selectedCategories", Arrays.asList(selectedCategories));
	        param.put("categorySize", selectedCategories.length);
	    }
	    param.put("selectedcardType", Arrays.asList(selectedcardType));

	    List<CardDTO> cardList = cscService.cardSearchcondition(param);
	    return cardList.size(); // ← 개수만 리턴
	}
	
	
	@GetMapping("/cardSelectByCompany")
	@ResponseBody
	public List<CardDTO> getCardsByCompany(@RequestParam String company) {
	    System.out.println("선택된 회사: " + company);
	    
	    List<CardDTO> cardList =  cscService.selectByCompany(company);
	    
	    System.out.println(company + "로 검색된 카드들의 갯수 " + cardList.size());
	    return cardList;
	}
	
	@GetMapping("/cardSortByViews")
	@ResponseBody
	public List<CardDTO> getCardsByViews() {
		
		 List<CardDTO> cardList = cscService.selectByViews();
		 
		 return cardList;
		
	}
	@GetMapping("/cardSortByLike")
	@ResponseBody
	public void getCardsByLike() {
		
	}
	@GetMapping("/cardSortByFeedomestic")
	@ResponseBody
	public void getCardsByFeedomestic() {
		
	}
	

}
