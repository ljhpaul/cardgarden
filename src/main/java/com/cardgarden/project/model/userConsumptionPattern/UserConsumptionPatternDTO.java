package com.cardgarden.project.model.userConsumptionPattern;

import java.sql.Timestamp;

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

}
