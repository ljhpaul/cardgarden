package com.cardgarden.project.model.userCardLike;

import lombok.Builder;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CardLikeDTO {
	
	private int card_id;
	private int user_id;
	private int card_like;

}
