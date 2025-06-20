package com.cardgarden.project.model.term.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class TermDTO {
	private int term_id;
	private String term_name;
	private String term_content;
	private String is_required;
	private Date created_at;
}