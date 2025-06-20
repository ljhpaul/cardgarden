package com.cardgarden.project.model.CardSearchCondition;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CardSearchConditionService {
	
	@Autowired
	CardSearchConditionDAO cacDAO;

	public List<CardDTO> cardSearchcondition(Map<String, Object> param) {
	List<CardDTO> CardList = cacDAO.cardSearchcondition(param);
		
		return CardList;
		
	}

}
