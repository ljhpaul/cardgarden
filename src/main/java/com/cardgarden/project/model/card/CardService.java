package com.cardgarden.project.model.card;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CardService {

    @Autowired
    private CardDAOInterface cardDAO;

    // 카드 검색 (페이지네이션 포함)
    public List<CardDTO> searchCards(String keyword, String sort, int page, int pageSize) {
        return cardDAO.searchCards(keyword, sort, page, pageSize);
    }

    // 전체 개수 조회
    public int countCards(String keyword) {
        return cardDAO.countCards(keyword);
    }
}
