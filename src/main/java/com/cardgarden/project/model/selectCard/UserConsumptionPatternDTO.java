package com.cardgarden.project.model.selectCard;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class UserConsumptionPatternDTO {
	
	private int benefitcategory_id;
	private String benefitCategory_name;

}
