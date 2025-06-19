package com.cardgarden.project.model.userConsumptionPatternDetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserConsumptionPatternDetailDTO {
	
	private int pattern_id;
	int benefitcategory_id;
	int amount;

}
