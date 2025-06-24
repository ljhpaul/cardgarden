package com.cardgarden.project.model.card;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CardRankDAOMybatis implements CardRankDAOInterface {

	@Autowired
    SqlSession sqlSession;
    
    private final String namespace = "com.cardgarden.cardrank";

    @Override
    public List<CardDTO> getTop10All() {
        return sqlSession.selectList(namespace + ".getTop10All");
    }

    @Override
    public List<CardDTO> getTop10ByType(String type) {
        return sqlSession.selectList(namespace + ".getTop10ByType", type);
    }

    @Override
    public List<CardDTO> getTop10ByCompany(String company) {
        return sqlSession.selectList(namespace + ".getTop10ByCompany", company);
    }

    @Override
    public List<CardDTO> getTop10ByBenefit(String benefitCategoryName) {
        return sqlSession.selectList(namespace + ".getTop10ByBenefit", benefitCategoryName);
    }
}
