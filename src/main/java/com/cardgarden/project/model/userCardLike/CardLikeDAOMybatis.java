package com.cardgarden.project.model.userCardLike;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CardLikeDAOMybatis implements CardLikeDAOInterface {
	
	@Autowired
    private SqlSessionTemplate sqlSession;

    private final String namespace = "com.firstzone.cardLike";

    @Override
	public int cardLikeInsert(CardLikeDTO cardlike) {
		System.out.println(cardlike);
		int result = sqlSession.insert(namespace+".cardLikeInsert",cardlike);
		return result;
	}
    
    @Override
	public int cardLikeDelete(CardLikeDTO cardlike) {
		System.out.println(cardlike);
		int result = sqlSession.insert(namespace+".cardLikeDelete",cardlike);
		return result;
	}
}