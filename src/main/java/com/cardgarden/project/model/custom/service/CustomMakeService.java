package com.cardgarden.project.model.custom.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cardgarden.project.model.custom.dao.CustomMakeDAOInterface;
import com.cardgarden.project.model.custom.dto.CustomAssetDTO;

@Service
public class CustomMakeService {

    @Autowired
    private CustomMakeDAOInterface dao;

    public List<CustomAssetDTO> getBackgroundList() {
        return dao.selectBackgroundList();
    }
}
