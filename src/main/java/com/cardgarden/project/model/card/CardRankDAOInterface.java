package com.cardgarden.project.model.card;

import java.util.List;
import java.util.Map;

public interface CardRankDAOInterface {
		List<CardDTO> getTop10All();
	    List<CardDTO> getTop10ByType(String type);
	    List<CardDTO> getTop10ByCompany(String company);
	    List<CardDTO> getTop10ByBenefit(String benefitCategoryName);
}
