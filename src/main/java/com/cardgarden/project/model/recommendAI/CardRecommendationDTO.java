package com.cardgarden.project.model.recommendAI;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class CardRecommendationDTO {
	
	private int card_id;
	private Double expected_match;
	private Double resultValue;
    private String message;
    public CardRecommendationDTO(int card_id, double resultValue, String message) {
    	this.card_id = card_id;
    	this.resultValue = resultValue;
    	this.message = message;
    }

    
    
}
