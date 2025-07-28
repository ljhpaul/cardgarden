package com.cardgarden.project.controller.card.like;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.ui.Model;

import com.cardgarden.project.model.userCardLike.CardLikeService;

@ControllerAdvice
public class HeaderLikeController {

    @Autowired
    private CardLikeService cardLikeService;

    @ModelAttribute
    public void addUserLikeToModel(HttpServletRequest request, HttpSession session, Model model) {
        String uri = request.getRequestURI();
        if (uri.startsWith("/user/join/email") || uri.startsWith("/user/join/info") || uri.startsWith("/user/join/term")) {
            return;
        }

        Integer userId = (Integer) session.getAttribute("loginUserId");
        Integer likeCount = (Integer) session.getAttribute("userLike");

        if (userId != null) {
            try {
                likeCount = cardLikeService.cardLikeSelectCount(userId);
                session.setAttribute("userLike", likeCount); 
            } catch (Exception e) {
                System.out.println("cardLikeSelectCount 실행 오류: " + e.getMessage());
                likeCount = null; // 실패 시 기본값
            }
        } else {
            likeCount = null; // 로그인 안된 경우 null으로 처리
            session.removeAttribute("userLike");
        }

        model.addAttribute("userLike", likeCount);
    }
}