package com.cardgarden.project.model.cardSelectAll;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;




@Service //@Componet + ���� ����
public class UserConsumptionPatternService {
	
	@Autowired
	UserConsumptionPatternDAO UserConDAO;
	
	public List<UserConsumptionPatternDTO> selectAll() {
		List<UserConsumptionPatternDTO>  benefitCategorylist = UserConDAO.selectAll();
		return benefitCategorylist;
	}

}
