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
	private double expected_match;
     
}
