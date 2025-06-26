package com.cardgarden.project.model.recommendAI;

import java.util.List;
import java.util.Map;

public interface CardRecommendationDAOInterface {
	public List<CardRecommendationDTO> getRecommendResult(int patternId) throws Exception;
//	public String getRecommendDetailResult(int patternId, int cardId);
	public List<CardRecommendationDTO> getRecommendDetailResult(int patternId, int cardId);
	public List<CardRecommendationDTO> getRecommendCosine(int cardid);
}
