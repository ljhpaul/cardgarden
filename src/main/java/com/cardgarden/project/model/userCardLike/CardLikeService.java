package com.cardgarden.project.model.userCardLike;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cardgarden.project.model.cardDetail.CardDTO;

@Service
public class CardLikeService {

	@Autowired
	private CardLikeDAOInterface cardLikeDAO;
	
	
	public int cardLikeInsert(CardLikeDTO cardlike) {
		return cardLikeDAO.cardLikeInsert(cardlike);
	}
	
	public int cardLikeDelete(CardLikeDTO cardlike) {
		return cardLikeDAO.cardLikeDelete(cardlike);
	}
	public CardDTO selectByIdWithLike(int cardId, int userId) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("cardId", cardId);
	    params.put("userId", userId);
	    return cardLikeDAO.selectByIdWithLike(params);
	}
	public int cardLikeSelectCount(int userId) {
		return cardLikeDAO.cardLikeSelectCount(userId);
	}
	
	public int cardLikeCount(int cardId) {
		return cardLikeDAO.cardLikeCount(cardId);
	}
	
}
