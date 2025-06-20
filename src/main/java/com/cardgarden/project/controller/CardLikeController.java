package com.cardgarden.project.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cardgarden.project.model.userCardLike.CardLikeDTO;
import com.cardgarden.project.model.userCardLike.CardLikeService;

@RestController
@RequestMapping("/card")
public class CardLikeController {

    @Autowired
    private CardLikeService cardLikeService;
    
    
//    @PostMapping("/cardLike")
//    public Map<String, Object> cardLikeInsert(@RequestParam("card_id") int cardId, HttpSession session) {
//        System.out.println("cardLikeInsert 호출됨, card_id=" + cardId); // 로그 추가
//        Map<String, Object> result = new HashMap<>();
//        result.put("result", "success"); // 임시 고정값
//        return result;
//    }

    
    
    // 좋아요 추가 (POST)
    @SuppressWarnings("unused")
	@PostMapping("/cardLike")
    public Map<String, Object> cardLikeInsert(@RequestParam("card_id") int cardId, HttpSession session) {
//        Integer userId = (Integer) session.getAttribute("userid");
    	Integer userId = 1;
    	if (userId == null) {
            Map<String, Object> loginResult = new HashMap<>();
            loginResult.put("result", "need_login");
            return loginResult;
        }

        CardLikeDTO dto = CardLikeDTO.builder()
                .card_id(cardId)
                .user_id(userId)
                .build();

        // 실제 insert 로직 예시 (service 사용 가정)
        int row = cardLikeService.cardLikeInsert(dto);

        Map<String, Object> result = new HashMap<>();
        result.put("result", row > 0 ? "success" : "fail");
        return result;
    }

    // 좋아요 취소 (POST)
    @SuppressWarnings("unused")
	@PostMapping("/cardUnlike")
    public String cardLikeDelete(@RequestParam("card_id") int cardId, HttpSession session) {
//        Integer userId = (Integer) session.getAttribute("userid");
    	Integer userId = 1;
        if (userId == null) {
            return "로그인 필요";
        }

        CardLikeDTO dto = CardLikeDTO.builder()
                .card_id(cardId)
                .user_id(userId)
                .build();

        int result = cardLikeService.cardLikeDelete(dto);
        return result > 0 ? "success" : "fail";
    }
}
