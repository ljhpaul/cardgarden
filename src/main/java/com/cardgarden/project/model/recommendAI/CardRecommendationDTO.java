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
	
	private int pattern_id;
	private int benefitcategory_id;
	private int amount;
	private int userid;
}
