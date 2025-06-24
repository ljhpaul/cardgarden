package com.cardgarden.project.model.card;

import java.util.List;
import java.util.Map;

public interface CardSearchDAOInterface {
	List<CardDTO> searchCards(String keyword, String sort, int page, int pageSize, Integer userId);
	int countCards(String keyword);  
}
