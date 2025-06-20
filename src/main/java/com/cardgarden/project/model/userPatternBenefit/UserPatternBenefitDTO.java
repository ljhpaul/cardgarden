package com.cardgarden.project.model.userPatternBenefit;

import com.cardgarden.project.model.benefitCategory.benefitCategoryDTO;
import com.cardgarden.project.model.userConsumptionPattern.UserConsumptionPatternDTO;
import com.cardgarden.project.model.userConsumptionPatternDetail.UserConsumptionPatternDetailDTO;

import lombok.Builder;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;



@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserPatternBenefitDTO {
    //통합DTO
	private UserConsumptionPatternDTO pattern;
    private UserConsumptionPatternDetailDTO detail;
    private benefitCategoryDTO category;
}
