package com.cardgarden.project.model.userCardLike;

import java.util.Map;

import com.cardgarden.project.model.cardDetail.CardDTO;

public interface CardLikeDAOInterface {
	public int cardLikeInsert(CardLikeDTO cardlike);
	
	public int cardLikeDelete(CardLikeDTO cardlike);
	
	public CardDTO selectByIdWithLike(Map<String, Object> params);
}
