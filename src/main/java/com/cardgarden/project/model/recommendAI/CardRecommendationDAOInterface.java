package com.cardgarden.project.model.recommendAI;

import java.util.List;
import java.util.Map;

public interface CardRecommendationDAOInterface {
	public List<CardRecommendationDTO> getRecommendResult(int patternId) throws Exception;
}
