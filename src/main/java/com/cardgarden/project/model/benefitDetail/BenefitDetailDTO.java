package com.cardgarden.project.model.benefitDetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class BenefitDetailDTO {
	private int benefitdetail_id;
	private int benefitcategory_id;
	private String benefitdetail_name;
	private String benefitdetail_image;

}
