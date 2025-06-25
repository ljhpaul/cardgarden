package com.cardgarden.project.model.userConsumptionPattern;

import java.sql.Timestamp;
import java.util.List;

import com.cardgarden.project.model.userConsumptionPatternDetail.UserConsumptionPatternDetailDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserConsumptionPatternDTO {
	
	private int pattern_id;
	private int user_id;
	private String pattern_name;
	private Timestamp created_at;
	
	private List<UserConsumptionPatternDetailDTO> details;  // 소비 상세 리스트

}
