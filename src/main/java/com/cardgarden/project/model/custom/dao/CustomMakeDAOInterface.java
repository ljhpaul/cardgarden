package com.cardgarden.project.model.custom.dao;

import java.util.List;

import com.cardgarden.project.model.custom.dto.CustomAssetDTO;

public interface CustomMakeDAOInterface {
	List<CustomAssetDTO> selectBackgroundList();
	
	List<Integer> selectOwnedBackgroundList(int userId);

}
