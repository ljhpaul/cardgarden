package com.cardgarden.project.model.userConsumptionPattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cardgarden.project.model.userConsumptionPatternDetail.UserConsumptionPatternDetailDAO;
import com.cardgarden.project.model.userConsumptionPatternDetail.UserConsumptionPatternDetailDTO;

@Service
public class UserConsumptionPatternService {
	
	@Autowired
	UserConsumptionPatternDAO ucpDAO;
	
	@Autowired
	UserConsumptionPatternDetailDAO ucpdDAO;

	@Transactional
	public void insertUserConsumptionPatternWithDetails(UserConsumptionPatternDTO ucp,int[] selectedCategories,int[] amount) {
		
		ucpDAO.insertUserConsumptionPattern(ucp);
		
		// 위에서 insert된 pattern_id값 가져오기
		int pattern_id = ucp.getPattern_id();
		
		// UserConsumptionPatternDetail insert
		for(int i = 0; i < selectedCategories.length; i++) {
			UserConsumptionPatternDetailDTO ucpd = UserConsumptionPatternDetailDTO.builder()
				.pattern_id(pattern_id)
				.amount(amount[i])
				.benefitcategory_id(selectedCategories[i]).build();
			
			ucpdDAO.insertUserConsumptionPattern(ucpd);
		
		}
		
	}
	
	

}
