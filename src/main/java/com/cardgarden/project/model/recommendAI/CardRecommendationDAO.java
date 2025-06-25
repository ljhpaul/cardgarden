package com.cardgarden.project.model.recommendAI;

import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

@Repository
public class CardRecommendationDAO implements CardRecommendationDAOInterface{
	
	
	
	@Override
    public List<CardRecommendationDTO> getRecommendResult(int patternId) {
        String url = "http://192.168.0.9:5001/recommend?pattern_id=" + patternId;
        RestTemplate restTemplate = new RestTemplate();
        CardRecommendationDTO[] response = restTemplate.getForObject(url, CardRecommendationDTO[].class);
        return Arrays.asList(response);
    }
	
	@Override
    public List<CardRecommendationDTO> getRecommendDetailResult(int patternId, int cardId) {
		String url = "http://192.168.0.9:5002/recommendDetail?pattern_id=" + patternId + "&card_id=" + cardId;
	    RestTemplate restTemplate = new RestTemplate();
	    ResultWrapper response = restTemplate.getForObject(url, ResultWrapper.class);

	    Double resultValue = response.getResult();
	    String message = "";

	    if (resultValue != null) {
	        if (resultValue >= 0.6) {
	            message = "해당카드는 당신의 소비패턴에 매우 적합한 혜택을 가지고 있습니다.";
	        } else if (resultValue >= 0.4) {
	            message = "해당카드는 당신의 소비패턴에 적합한 혜택을 가지고 있습니다.";
	        } else {
	            message = "해당카드는 당신의 소비패턴에 적합하지 않습니다.";
	        }
	    } else {
	        message = "결과를 찾을 수 없습니다.";
	    }

	    System.out.println("예상 매칭률: " + resultValue);
	    System.out.println("메시지: " + message);
	    CardRecommendationDTO result = CardRecommendationDTO.builder()
	    	    .card_id(cardId)
	    	    .resultValue(resultValue)
	    	    .message(message)
	    	    .build();
	    return Arrays.asList(result);
	    
	}
    
}
