package com.cardgarden.project.model.card;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CardSearchDAOMybatis implements CardSearchDAOInterface {

    @Autowired
    private SqlSessionTemplate sqlSession;

    private final String namespace = "com.cardgarden.cardsearch";

    @Override
    public List<CardDTO> searchCards(String keyword, String sort, int page, int pageSize, Integer userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("sort", sort);
        params.put("offset", (page - 1) * pageSize);
        params.put("pageSize", pageSize);
        params.put("user_id", userId);  // 추가
        return sqlSession.selectList(namespace + ".searchCards", params);
    }

    @Override
    public int countCards(String keyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        return sqlSession.selectOne(namespace + ".countCards", params);
    }
}
