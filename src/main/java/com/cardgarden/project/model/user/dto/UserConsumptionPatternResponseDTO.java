package com.cardgarden.project.model.user.dto;

import java.sql.Timestamp;
import java.util.List;

import com.cardgarden.project.model.userConsumptionPattern.UserConsumptionPatternDTO;
import com.cardgarden.project.model.userConsumptionPatternDetail.UserConsumptionPatternDetailDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserConsumptionPatternResponseDTO {
	
	private int user_id;
	private String pattern_name;
	private Timestamp created_at;
	int benefitcategory_id;
	int amount;

}
