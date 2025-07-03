package com.cardgarden.project.controller.card.like;

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
    
    @SuppressWarnings("unused")
	@PostMapping("/cardLike")
    public Map<String, Object> cardLikeInsert(@RequestParam("card_id")int cardId,
    		HttpSession session) {
        Integer userId = (Integer) session.getAttribute("loginUserId");
    	if (userId == null) {
            Map<String, Object> loginResult = new HashMap<>();
            loginResult.put("result", "need_login");
            return loginResult;
        }

        CardLikeDTO dto = CardLikeDTO.builder()
                .card_id(cardId)
                .user_id(userId)
                .build();

        int row = cardLikeService.cardLikeInsert(dto);

        Map<String, Object> result = new HashMap<>();
        if (row > 0) {
            int likeCount = cardLikeService.cardLikeSelectCount(userId);
            session.setAttribute("userLike", likeCount);
            result.put("result", "success");
            result.put("userLike", likeCount);
        } else {
            result.put("result", "fail");
        }

        return result;
    }
    
    
    @PostMapping("/cardLike/pageSave")
    public boolean cardLikeInsert(HttpSession session, String path){
    	if (path == null) {
    		return false;
    	}
    	session.setAttribute("redirectAfterLogin", path);
    	return true; 
    }

    @SuppressWarnings("unused")
	@PostMapping("/cardUnlike")
    public Map<String, Object> cardLikeDelete(@RequestParam("card_id") int cardId, HttpSession session) {
    	 Integer userId = (Integer) session.getAttribute("loginUserId");
     	if (userId == null) {
             Map<String, Object> loginResult = new HashMap<>();
             loginResult.put("result", "need_login");
             return loginResult;
         }

        CardLikeDTO dto = CardLikeDTO.builder()
                .card_id(cardId)
                .user_id(userId)
                .build();
        int row = cardLikeService.cardLikeDelete(dto);
        Map<String, Object> result = new HashMap<>();
        if (row > 0) {
            int likeCount = cardLikeService.cardLikeSelectCount(userId);
            session.setAttribute("userLike", likeCount);
            result.put("result", "success");
            result.put("userLike", likeCount);
        } else {
            result.put("result", "fail");
        }

        return result;
    }
    
    
    
    
}
