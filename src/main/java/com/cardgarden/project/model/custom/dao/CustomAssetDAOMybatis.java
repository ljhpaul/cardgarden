package com.cardgarden.project.model.custom.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cardgarden.project.model.custom.dto.CustomAssetDTO;

@Repository
public class CustomAssetDAOMybatis implements CustomAssetDAOInterface {

    @Autowired
    private SqlSessionTemplate sqlSession;

    private final String namespace = "com.cardgarden.customasset";


    @Override
    public List<CustomAssetDTO> selectTopAssets(String assetType, String sortBy, String brand) {
        Map<String, Object> param = new HashMap<>();
        param.put("asset_type", assetType);
        param.put("sortBy", sortBy);
        param.put("asset_brand", brand);

        return sqlSession.selectList(namespace + ".selectTopAssets", param);
    }

    @Override
    public List<CustomAssetDTO> selectDailyDiscount() {
        return sqlSession.selectList(namespace + ".selectDailyDiscount");
    }

    @Override
    public List<CustomAssetDTO> selectDailyFree() {
        return sqlSession.selectList(namespace + ".selectDailyFree");
    }

    @Override
    public CustomAssetDTO selectAssetDetail(int assetId) {
        return sqlSession.selectOne(namespace + ".selectAssetDetail", assetId);
    }

    @Override
    public int isLiked(int userId, int assetId) {
        Map<String, Object> map = new HashMap<>();
        map.put("user_id", userId);
        map.put("asset_id", assetId);
        return sqlSession.selectOne(namespace + ".isLiked", map);
    }

    @Override
    public int isOwned(int userId, int assetId) {
        Map<String, Object> map = new HashMap<>();
        map.put("user_id", userId);
        map.put("asset_id", assetId);
        return sqlSession.selectOne(namespace + ".isOwned", map);
    }

    @Override
    public List<CustomAssetDTO> selectSameBrand(String assetBrand, String assetType) {
        Map<String, Object> map = new HashMap<>();
        map.put("asset_brand", assetBrand);
        map.put("asset_type", assetType);
        return sqlSession.selectList(namespace + ".selectSameBrand", map);
    }

    @Override
    public int selectUserPoint(int userId) {
        return sqlSession.selectOne(namespace + ".selectUserPoint", userId);
    }

    @Override
    public void updateUserPoint(Map<String, Object> param) {
        sqlSession.update(namespace + ".updateUserPoint", param);
    }

    @Override
    public void insertOwnedAsset(Map<String, Object> param) {
        sqlSession.insert(namespace + ".insertOwnedAsset", param);
    }

    @Override
    public void insertLikeAsset(Map<String, Object> param) {
        sqlSession.insert(namespace + ".insertLikeAsset", param);
    }

    @Override
    public void deleteLikeAsset(Map<String, Object> param) {
        sqlSession.delete(namespace + ".deleteLikeAsset", param);
    }

    @Override
    public void increaseAssetLike(int assetId) {
        sqlSession.update(namespace + ".increaseAssetLike", assetId);
    }

    @Override
    public void decreaseAssetLike(int assetId) {
        sqlSession.update(namespace + ".decreaseAssetLike", assetId);
    }
    @Override
    public int selectAssetLikeCount(int assetId) {
        return sqlSession.selectOne(namespace + ".selectAssetLikeCount", assetId);
    }
    @Override
    public List<CustomAssetDTO> selectOwnedMascots(int userId) {
        return sqlSession.selectList(namespace + ".selectOwnedMascots", userId);
    }

}
