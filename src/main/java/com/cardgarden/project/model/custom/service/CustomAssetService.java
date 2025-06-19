package com.cardgarden.project.model.custom.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cardgarden.project.model.custom.dao.CustomAssetDAOInterface;
import com.cardgarden.project.model.custom.dto.CustomAssetDTO;

@Service
public class CustomAssetService {

    @Autowired
    private CustomAssetDAOInterface dao;

    public List<CustomAssetDTO> getTopAssets(String assetType, String sortBy) {
        return dao.selectTopAssets(assetType, sortBy);
    }

    public List<CustomAssetDTO> getDailyDiscountAssets() {
        return dao.selectDailyDiscount();
    }

    public List<CustomAssetDTO> getDailyFreeAssets() {
        return dao.selectDailyFree();
    }

    public CustomAssetDTO getAssetDetail(int assetId) {
        return dao.selectAssetDetail(assetId);
    }

    public int checkLiked(int userId, int assetId) {
        return dao.isLiked(userId, assetId);
    }

    public int checkOwned(int userId, int assetId) {
        return dao.isOwned(userId, assetId);
    }

    public List<CustomAssetDTO> getSameBrandAssets(String assetBrand, String assetType) {
        return dao.selectSameBrand(assetBrand, assetType);
    }

    public int getUserPoint(int userId) {
        return dao.selectUserPoint(userId);
    }

    public void deductUserPoint(Map<String, Object> param) {
        dao.updateUserPoint(param);
    }

    public void registerOwnership(Map<String, Object> param) {
        dao.insertOwnedAsset(param);
    }

    public void likeAsset(Map<String, Object> param) {
        dao.insertLikeAsset(param);
        dao.increaseAssetLike((int) param.get("asset_id"));
    }

    public void unlikeAsset(Map<String, Object> param) {
        dao.deleteLikeAsset(param);
        dao.decreaseAssetLike((int) param.get("asset_id"));
    }
}
