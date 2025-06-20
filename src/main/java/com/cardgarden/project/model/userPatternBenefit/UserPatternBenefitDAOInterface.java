package com.cardgarden.project.model.userPatternBenefit;

import java.util.List;

public interface UserPatternBenefitDAOInterface {
	public abstract List<UserPatternBenefitDTO> selectByIdConsumPattern(int userid);
}
