package com.cardgarden.project.model.userCardLike;

public interface CardLikeDAOInterface {
	public int cardLikeInsert(CardLikeDTO cardlike);
	
	public int cardLikeDelete(CardLikeDTO cardlike);
}
