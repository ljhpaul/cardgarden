package com.cardgarden.project.model.benefitCategory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;




@Service //@Componet + ���� ����
public class benefitCategoryService {
	
	@Autowired
	benefitCategoryDAO UserConDAO;
	
	public List<benefitCategoryDTO> selectAll() {
		List<benefitCategoryDTO>  benefitCategorylist = UserConDAO.selectAll();
		return benefitCategorylist;
	}

}
