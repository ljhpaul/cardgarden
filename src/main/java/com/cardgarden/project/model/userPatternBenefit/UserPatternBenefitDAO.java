package com.cardgarden.project.model.userPatternBenefit;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserPatternBenefitDAO implements UserPatternBenefitDAOInterface{
	@Autowired
    private SqlSessionTemplate sqlSession;
	
	private final String namespace="com.cardgarden.UserPatternBenefit";
	@Override
	public List<UserPatternBenefitDTO> selectByIdConsumPattern(int userid){
		List<UserPatternBenefitDTO> patternList = sqlSession.selectList(namespace+".selectUserConsumptionPattern",userid);
		return patternList;	
	}
}
