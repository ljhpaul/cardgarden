package com.cardgarden.project.model.card;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CardRankService {
	 @Autowired
	    private CardRankDAOInterface cardRankDAO;

	    public List<CardDTO> getTop10All() {
	        return cardRankDAO.getTop10All();
	    }

	    public List<CardDTO> getTop10ByType(String type) {
	        return cardRankDAO.getTop10ByType(type);
	    }

	    public List<CardDTO> getTop10ByCompany(String company) {
	        return cardRankDAO.getTop10ByCompany(company);
	    }

	    public List<CardDTO> getTop10ByBenefit(String benefitCategoryName) {
	        return cardRankDAO.getTop10ByBenefit(benefitCategoryName);
	    }
}
