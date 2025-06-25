package com.cardgarden.project.model.userConsumptionPattern;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserConsumptionPatternDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.cardgarden.UserConsumptionPattern.";
	
	public int insertUserConsumptionPattern(UserConsumptionPatternDTO ucp) {
		int result = 0;
		
		result = sqlSession.insert(namespace + "insertUserConsumptionPattern",ucp);
		
		return result;
	}

	// 패턴 제목,갱신일자 수정
	public int updatetUserConsumptionPattern(UserConsumptionPatternDTO ucp) {
		int result = 0;
		
		result = sqlSession.insert(namespace + "updatetUserConsumptionPattern",ucp);
		
		return result;
		
	}

	public int deleteByPatternId(int pattern_id) {
		int result = 0;
		
		result = sqlSession.delete(namespace + "deleteConsumPattern",pattern_id);
		
		return result;
	}

}
