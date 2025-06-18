package com.cardgarden.project.model.card;

import java.util.List;
import java.util.Map;

public interface CardDAOInterface {
	public List<CardDTO> selectById(int cardId);
	public List<CardDetailDTO> selectDetailByID(int cardId);
}
