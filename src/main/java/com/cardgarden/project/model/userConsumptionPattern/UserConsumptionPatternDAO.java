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

}
