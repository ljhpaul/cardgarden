package com.cardgarden.project.model.custom.dao;

import java.util.List;
import java.util.Map;

import com.cardgarden.project.model.custom.dto.CustomAssetDTO;

public interface CustomAssetDAOInterface {

    List<CustomAssetDTO> selectTopAssets(String assetType, String sortBy, String brand);

    List<CustomAssetDTO> selectDailyDiscount();

    List<CustomAssetDTO> selectDailyFree();

    CustomAssetDTO selectAssetDetail(int assetId);

    int isLiked(int userId, int assetId);

    int isOwned(int userId, int assetId);

    List<CustomAssetDTO> selectSameBrand(String assetBrand, String assetType);

    int selectUserPoint(int userId);

    void updateUserPoint(Map<String, Object> param);

    void insertOwnedAsset(Map<String, Object> param);

    void insertLikeAsset(Map<String, Object> param);

    void deleteLikeAsset(Map<String, Object> param);

    void increaseAssetLike(int assetId);

    void decreaseAssetLike(int assetId);
}
