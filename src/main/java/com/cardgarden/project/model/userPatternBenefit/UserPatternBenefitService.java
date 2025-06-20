package com.cardgarden.project.model.userPatternBenefit;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserPatternBenefitService {
	
	@Autowired
	private UserPatternBenefitDAOInterface userPatternBenefitDAO;
	
	public List<UserPatternBenefitDTO> selectByIdConsumPattern(int userid){
		List<UserPatternBenefitDTO> patternList = userPatternBenefitDAO.selectByIdConsumPattern(userid);
		return patternList;
	}
	
}
