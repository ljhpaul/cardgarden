package com.cardgarden.project.model.recommendAI;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

@Repository
public class CardRecommendationDAO implements CardRecommendationDAOInterface{
	

    @Value("${recommend.api.url}")
    private String recommendApiUrl;

    @Value("${recommend.detail.url}")
    private String recommendDetailUrl;
    
    
    @Value("${recommend.cosine.url}")
    private String recommendCosineUrl;

    @Override
    public List<CardRecommendationDTO> getRecommendResult(int patternId) {
        String url = recommendApiUrl + "?pattern_id=" + patternId;
        RestTemplate restTemplate = new RestTemplate();
        CardRecommendationDTO[] response = restTemplate.getForObject(url, CardRecommendationDTO[].class);
        return Arrays.asList(response);
    }

    @Override
    public List<CardRecommendationDTO> getRecommendDetailResult(int patternId, int cardId) {
    	System.out.println(patternId);
    	System.out.println(cardId);
        String url = recommendDetailUrl + "?pattern_id=" + patternId + "&card_id=" + cardId;
        RestTemplate restTemplate = new RestTemplate();
        ResultWrapper response = restTemplate.getForObject(url, ResultWrapper.class);

        // 여기서부터 아래로는 중복 없이!
        Double resultValue = response != null ? response.getResult() : null;
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

        System.out.println("API 응답값: " + response); 
        System.out.println("결과값: " + resultValue);
        System.out.println("메시지: " + message);

        CardRecommendationDTO result = CardRecommendationDTO.builder()
                .card_id(cardId)
                .resultValue(resultValue)
                .message(message)
                .build();
        return Arrays.asList(result);
    }
    
    
    @Override
    public List<CardRecommendationDTO> getRecommendCosine(int cardid) {
        String url = recommendCosineUrl + "?card_id=" + cardid;
        RestTemplate restTemplate = new RestTemplate();
        CardRecommendationDTO[] response = restTemplate.getForObject(url, CardRecommendationDTO[].class);

        return Arrays.asList(response);
    }

}
