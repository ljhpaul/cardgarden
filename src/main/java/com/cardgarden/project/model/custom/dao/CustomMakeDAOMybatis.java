package com.cardgarden.project.model.custom.dao;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.cardgarden.project.model.custom.dto.CustomAssetDTO;

@Repository
public class CustomMakeDAOMybatis implements CustomMakeDAOInterface {

    @Autowired
    private SqlSessionTemplate sqlSession;
    // 배경
    private final String namespace = "com.cardgarden.custommake";

    public List<CustomAssetDTO> selectBackgroundList() {
        return sqlSession.selectList(namespace + ".selectBackgroundList");
    }
    public List<Integer> selectOwnedBackgroundList(int userId) {
        return sqlSession.selectList(namespace + ".selectOwnedBackgroundList", userId);
    }
    // 스티커
    public List<CustomAssetDTO> selectStickerList() {
        return sqlSession.selectList(namespace + ".selectStickerList");
    }
    public List<Integer> selectOwnedStickerList(int userId) {
        return sqlSession.selectList(namespace + ".selectOwnedStickerList", userId);
    }
    public void plusUsed(int assetId) {
        sqlSession.update(namespace + ".plusUsed", assetId);
    }
    public void minusUsed(int assetId) {
        sqlSession.update(namespace + ".minusUsed", assetId);
    }

}
