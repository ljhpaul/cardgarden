package com.cardgarden.project.model.recommendAI;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CardRecommendationService {
	
	@Autowired
	private CardRecommendationDAOInterface cardRecommendationDAO;
	
	public List<CardRecommendationDTO> getRecommendResult(int patternId) throws Exception {
		List<CardRecommendationDTO> resultList = cardRecommendationDAO.getRecommendResult(patternId);
		return resultList;
	}
	
	public List<CardRecommendationDTO> getRecommendDetailResult(int patternId, int cardId) {
		List<CardRecommendationDTO> resultMessage = cardRecommendationDAO.getRecommendDetailResult(patternId, cardId);
		return resultMessage;
	}
}
