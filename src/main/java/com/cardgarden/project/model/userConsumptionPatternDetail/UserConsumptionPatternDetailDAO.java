package com.cardgarden.project.model.userConsumptionPatternDetail;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserConsumptionPatternDetailDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.cardgarden.UserConsumptionPatternDetail.";


	public int insertUserConsumptionPattern(UserConsumptionPatternDetailDTO ucpd) {
		int result = 0;
		
		result = sqlSession.insert(namespace + "insertUserConsumptionPatternDetail",ucpd);
		
		return result;
	}

	// 선택된 카테고리, 금액 수정 
	// 기존 데이터 삭제 후 insert 
	public int deleteByPatternId(int pattern_id) {
		int result = 0;
		
		sqlSession.delete(namespace + "deleteDetailsByPatternId", pattern_id);
		
		return result;
	}

}
