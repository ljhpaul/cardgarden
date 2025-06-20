package com.cardgarden.project.model.benefitDetail;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cardgarden.project.model.benefitCategory.benefitCategoryDTO;

@Repository
public class BenefitDetailDAO {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.cardgarden.benefitDetail.";
	
	String namespace2 = "com.cardgarden.benefitCategory.";

	public List<BenefitDetailDTO> selectAll() {

		List<BenefitDetailDTO> benefitDetailList = sqlSession.selectList(namespace + "selectAll");
		
		System.out.println(benefitDetailList.size());

		return benefitDetailList;
	}
	
	public List<benefitCategoryDTO> selectAllBenefitCategory() {

		List<benefitCategoryDTO> BenefitCategoryList = sqlSession.selectList(namespace2 + "selectAll");
		
		System.out.println(BenefitCategoryList.size());

		return BenefitCategoryList;
	}

}
