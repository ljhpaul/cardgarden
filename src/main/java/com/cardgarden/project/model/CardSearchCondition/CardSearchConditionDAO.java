package com.cardgarden.project.model.CardSearchCondition;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CardSearchConditionDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.cardgarden.cardSearchcondition.";

	public List<CardDTO> cardSearchcondition(Map<String, Object> param) {
		
		List<CardDTO> CardList = sqlSession.selectList(namespace + "selectByConditions",param);
		
		return CardList;
	}

	public List<CardDTO> cardSelectByCompany(String company) {
		
		List<CardDTO> CardList = sqlSession.selectList(namespace + "cardSelectByCompany",company);
		
		return CardList;
	}

	public List<CardDTO> selectByViews() {
			
		List<CardDTO> CardList = sqlSession.selectList(namespace + "selectByViews");
		
		return CardList;
	}

}
