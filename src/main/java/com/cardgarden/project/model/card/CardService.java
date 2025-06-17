package com.cardgarden.project.model.card;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CardService {

    @Autowired
    private CardDAOInterface cardDAO;

    // ī�� �˻� (���������̼� ����)
    public List<CardDTO> searchCards(String keyword, String sort, int page, int pageSize) {
        return cardDAO.searchCards(keyword, sort, page, pageSize);
    }

    // ��ü ���� ��ȸ
    public int countCards(String keyword) {
        return cardDAO.countCards(keyword);
    }
}
