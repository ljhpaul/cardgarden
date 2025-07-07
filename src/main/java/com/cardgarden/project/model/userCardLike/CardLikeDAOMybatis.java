package com.cardgarden.project.model.userCardLike;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cardgarden.project.model.cardDetail.CardDTO;

@Repository
public class CardLikeDAOMybatis implements CardLikeDAOInterface {
	
	@Autowired
    private SqlSessionTemplate sqlSession;

    private final String namespace = "com.cardgarden.cardLike";

    @Override
	public int cardLikeInsert(CardLikeDTO cardlike) {
		System.out.println(cardlike);
		int result = sqlSession.insert(namespace+".cardLikeInsert",cardlike);
		return result;
	}
    
    @Override
	public int cardLikeDelete(CardLikeDTO cardlike) {
		System.out.println(cardlike);
		int result = sqlSession.delete(namespace+".cardLikeDelete",cardlike);
		return result;
	}
    
    @Override
    public CardDTO selectByIdWithLike(Map<String, Object> params) {
        return sqlSession.selectOne("com.cardgarden.card.selectLike", params);
    }
    
    @Override
    public int cardLikeSelectCount(int userId) {
        int result =  sqlSession.selectOne(namespace+".cardLikeSelectCount", userId);
        return result;
    }
    @Override
    public int cardLikeCount(int cardId) {
        int result =  sqlSession.selectOne(namespace+".cardLikeCount", cardId);
        return result;
    }

}