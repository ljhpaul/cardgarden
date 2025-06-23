package com.cardgarden.project.model.recommendAI;

import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

@Repository
public class CardRecommendationDAO implements CardRecommendationDAOInterface {
	
	@Override
    public List<CardRecommendationDTO> getRecommendResult(int patternId) {
        String url = "http://192.168.0.13:5001/recommend?pattern_id=" + patternId;
        RestTemplate restTemplate = new RestTemplate();
        CardRecommendationDTO[] response = restTemplate.getForObject(url, CardRecommendationDTO[].class);
        return Arrays.asList(response);
    }
    
}
