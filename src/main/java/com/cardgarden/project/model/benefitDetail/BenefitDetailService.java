package com.cardgarden.project.model.benefitDetail;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cardgarden.project.model.benefitCategory.benefitCategoryDTO;

@Service
public class BenefitDetailService {

	@Autowired
	BenefitDetailDAO bfdDAO;

	public List<BenefitDetailDTO> selectAll() {

		return bfdDAO.selectAll();
	}
	
	public List<benefitCategoryDTO> selectAllBenefitCategory() {

		return bfdDAO.selectAllBenefitCategory();
	}

}
