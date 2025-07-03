package com.cardgarden.project.model.cardDetail;

import com.cardgarden.project.model.benefitDetail.BenefitDetailDTO;
import com.cardgarden.project.model.userConsumptionPatternDetail.UserConsumptionPatternDetailDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class CardBenefitRankDTO {
	private BenefitDetailDTO benefitDetailDTO;
	private int amount_Rank;
	private UserConsumptionPatternDetailDTO userConsumptionPatternDetailDTO;

}
