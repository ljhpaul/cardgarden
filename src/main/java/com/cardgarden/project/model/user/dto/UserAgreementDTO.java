package com.cardgarden.project.model.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class UserAgreementDTO {
	private int user_id;
	private int term_id;
	private String is_agreed;
}