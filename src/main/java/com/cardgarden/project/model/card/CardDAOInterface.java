package com.cardgarden.project.model.card;

import java.util.List;
import java.util.Map;

public interface CardDAOInterface {
    List<CardDTO> searchCards(String keyword, String sort, int page, int pageSize);
    int countCards(String keyword);  // ��ü ī�� �� ��ȸ��
}
