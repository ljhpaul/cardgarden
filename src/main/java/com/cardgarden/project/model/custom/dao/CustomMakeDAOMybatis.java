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

    private final String namespace = "com.cardgarden.custommake";

    public List<CustomAssetDTO> selectBackgroundList() {
        return sqlSession.selectList(namespace + ".selectBackgroundList");
    }
}
