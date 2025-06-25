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

	// 소비패턴 수정
	public void updatetUserConsumptionPatternWithDetails(UserConsumptionPatternDTO ucp, int[] selectedCategories,
			int[] amount) {
		
		//패턴이름, 갱신날짜 => update
		ucpDAO.updatetUserConsumptionPattern(ucp);
		
		//detail 테이블
		// 1. 기존 상세 삭제
		int delresult = ucpdDAO.deleteByPatternId(ucp.getPattern_id());
		
		if(delresult>0) {
			System.out.println("삭제성공");
		}
		// 2. 새로 insert
		for(int i = 0; i < selectedCategories.length; i++) {
			UserConsumptionPatternDetailDTO ucpd = UserConsumptionPatternDetailDTO.builder()
				.pattern_id(ucp.getPattern_id())
				.amount(amount[i])
				.benefitcategory_id(selectedCategories[i])
				.build();
			
			ucpdDAO.insertUserConsumptionPattern(ucpd);
		}
		
	}

	@Transactional
	public int deleteConsumPattern(int pattern_id) {
		
		int deldetailresult =  ucpdDAO.deleteByPatternId(pattern_id);
		
		int delresult =  ucpDAO.deleteByPatternId(pattern_id);
		
		int result= delresult + delresult;
		
		return result;
		
	}
	
	

}
