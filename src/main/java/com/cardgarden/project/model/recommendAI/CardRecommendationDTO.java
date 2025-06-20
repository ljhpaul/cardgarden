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
	
	public int card_id;
    public double expected_match;

}
