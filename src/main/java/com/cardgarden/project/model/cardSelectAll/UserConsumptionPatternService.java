package com.cardgarden.project.model.cardSelectAll;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;




@Service //@Componet + 서비스 역할
public class UserConsumptionPatternService {
	
	@Autowired
	UserConsumptionPatternDAO UserConDAO;
	
	public List<UserConsumptionPatternDTO> selectAll() {
		List<UserConsumptionPatternDTO>  benefitCategorylist = UserConDAO.selectAll();
		return benefitCategorylist;
	}

}
