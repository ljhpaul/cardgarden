package com.cardgarden.project.model.cardSelect;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository //DAO + Bean등록 + DB예외 Spring 예외로 처리
public class UserConsumptionPatternDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.cardgarden.inCon.";
	
	public List<UserConsumptionPatternDTO> selectAll() {
		List<UserConsumptionPatternDTO> benefitCategorylist = sqlSession.selectList(namespace + "selectAll");
		return benefitCategorylist;
	}

}
