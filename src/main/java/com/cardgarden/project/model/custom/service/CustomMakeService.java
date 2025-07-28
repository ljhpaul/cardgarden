package com.cardgarden.project.model.custom.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cardgarden.project.model.custom.dao.CustomMakeDAOInterface;
import com.cardgarden.project.model.custom.dto.CustomAssetDTO;
import com.cardgarden.project.model.custom.dto.CustomCardDTO;

@Service
public class CustomMakeService {

    @Autowired
    private CustomMakeDAOInterface dao;

    public List<CustomAssetDTO> getBackgroundList() {
        return dao.selectBackgroundList();
    }
    public List<Integer> getOwnedBackgroundList(int userId) {
        return dao.selectOwnedBackgroundList(userId);
    }

    public List<CustomAssetDTO> getStickerList() {
        return dao.selectStickerList();
    }

    public List<Integer> getOwnedStickerList(int userId) {
        return dao.selectOwnedStickerList(userId);
    }

    public void incrementUsed(int assetId) {
        dao.plusUsed(assetId);
    }

    public void decrementUsed(int assetId) {
        dao.minusUsed(assetId);
    }
    
    public void saveCustomCard(CustomCardDTO dto) {
        dao.insertCustomCard(dto);
    }
    public CustomCardDTO getLatestCustomCardByUser(int userId) {
        return dao.selectLatestCustomCardByUser(userId);
    }
}
