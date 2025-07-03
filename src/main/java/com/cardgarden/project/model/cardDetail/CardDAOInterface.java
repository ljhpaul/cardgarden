package com.cardgarden.project.model.cardDetail;

import java.util.List;
import java.util.Map;

import com.cardgarden.project.model.benefitDetail.BenefitDetailDTO;

public interface CardDAOInterface {
	public List<BenefitDetailDTO> selectPatternCardID(int patternid, int cardid);
	public List<CardDTO> selectById(int cardId);
	public List<CardDetailDTO> selectDetailByID(int cardId);
	public List<CardDTO> selectTopLikeCardByCompany();
}
