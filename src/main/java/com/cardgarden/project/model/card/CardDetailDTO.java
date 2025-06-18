package com.cardgarden.project.model.card;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class CardDetailDTO {
	private int card_id;
	private int cardbenefitdetail_id;
	private int benefitdetail_id;
	private String cardbenefitdetail_text;	
	private String cardbenefitdetail_info;
	
	private String benefitdetail_name;
	private String title;
	private String description;
	private String benefitdetail_image;
	
}

