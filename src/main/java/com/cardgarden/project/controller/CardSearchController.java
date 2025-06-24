package com.cardgarden.project.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cardgarden.project.model.card.CardDTO;
import com.cardgarden.project.model.card.CardSearchService;

@Controller
@RequestMapping("/card")
public class CardSearchController {

    @Autowired
    private CardSearchService cardService;

    @RequestMapping("/search")
    public String searchCard(HttpServletRequest request, HttpSession session) {
        String keyword = request.getParameter("keyword");
        String sort = request.getParameter("sort");

        int page = 1;
        int pageSize = 10;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int totalCount = cardService.countCards(keyword);
        Integer userId = (Integer) session.getAttribute("loginUserId"); 

        List<CardDTO> results = cardService.searchCards(keyword, sort, page, pageSize, userId);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        int startPage = Math.max(1, page - 5);
        int endPage = Math.min(totalPages, page + 5);

        request.setAttribute("cardList", results);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        return "card/cardsearch";
    }





}
