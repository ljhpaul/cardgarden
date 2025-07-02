package com.cardgarden.project.model.cardDetail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CardService {

    @Autowired
    private CardDAOInterface cardDAO;
	
    public List<CardDTO> getTopLikeCardByCompany() {
        return cardDAO.selectTopLikeCardByCompany();
    }
    
    
    
	public List<CardDTO> selectById(int cardId){
		List<CardDTO> cardList = cardDAO.selectById(cardId);
		return cardList;
	}
	
	
	
	public List<CardDetailDTO> selectDetailByID(int cardId){
		List<CardDetailDTO> cardList = cardDAO.selectDetailByID(cardId);
		return cardList;
	}
}
