package com.cardgarden.project.model.card;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class CardDTO {
	private int card_id;	
	private String card_name;
	private String company;
	private String card_type;	
	private String brand;	
	private String card_image;	
	private String card_url;	
	private int fee_domestic;	
	private int fee_foreign;	
	private int prev_month_cost;	
	private int card_like;	
	private int card_views;
}
