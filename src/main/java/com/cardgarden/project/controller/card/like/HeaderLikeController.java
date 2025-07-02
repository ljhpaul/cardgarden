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
        // 만약 redirect 요청이면 Model에 담지 않도록 차단
        String uri = request.getRequestURI();
        if (uri.startsWith("/user/join/email") || uri.startsWith("/user/join/info") || uri.startsWith("/user/join/term")) {
            return; // 이 경로에선 userLike 모델 추가 X
        }

        Integer userId = (Integer) session.getAttribute("loginUserId");
        Integer likeCount = null;

        if (userId != null) {
            try {
                likeCount = cardLikeService.cardLikeSelectCount(userId);
            } catch (Exception e) {
                System.out.println("cardLikeSelectCount 실행 오류: " + e.getMessage());
            }
        }

        model.addAttribute("userLike", likeCount);
    }
}