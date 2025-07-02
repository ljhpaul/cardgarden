package com.cardgarden.project.model.cardDetail;

import java.util.List;
import java.util.Map;

public interface CardDAOInterface {
	public List<CardDTO> selectById(int cardId);
	public List<CardDetailDTO> selectDetailByID(int cardId);
	public List<CardDTO> selectTopLikeCardByCompany();
}
