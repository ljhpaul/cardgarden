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

}
