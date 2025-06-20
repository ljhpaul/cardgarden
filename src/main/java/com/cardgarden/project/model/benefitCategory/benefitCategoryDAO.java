package com.cardgarden.project.model.benefitCategory;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class benefitCategoryDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.cardgarden.benefitCategory.";
	
	public List<benefitCategoryDTO> selectAll() {
		List<benefitCategoryDTO> benefitCategorylist = sqlSession.selectList(namespace + "selectAll");
		return benefitCategorylist;
	}

}
