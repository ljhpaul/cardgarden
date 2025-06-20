package com.cardgarden.project.model.userCardLike;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CardLikeService {

	@Autowired
	private CardLikeDAOInterface cardLikeDAO;
	
	private final String namespace = "com.firstzone.cardLike";
	
	
	public int cardLikeInsert(CardLikeDTO cardlike) {
		return cardLikeDAO.cardLikeInsert(cardlike);
	}
	
	public int cardLikeDelete(CardLikeDTO cardlike) {
		return cardLikeDAO.cardLikeDelete(cardlike);
	}
}
