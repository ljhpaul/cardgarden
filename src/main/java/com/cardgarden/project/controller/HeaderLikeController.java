package com.cardgarden.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.cardgarden.project.model.userCardLike.CardLikeService;


@ControllerAdvice 
public class HeaderLikeController {
	
    @Autowired
    private CardLikeService cardLikeService;
	
    @ModelAttribute("userLike")
    public Integer getUserLike(HttpSession session) {
    	Integer userId = (Integer) session.getAttribute("loginUserId");
        if (userId == null) {
            return 0;
        }
        try {
            return cardLikeService.cardLikeSelectCount(userId);
        } catch (Exception e) {
            // DB 연결 오류 등 예외 발생 시
            System.out.println("cardLikeSelectCount 실행 오류: " + e.getMessage());
            return 0;
        }
    }
}   
