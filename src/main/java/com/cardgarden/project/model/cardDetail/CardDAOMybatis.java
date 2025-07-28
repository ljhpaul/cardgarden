package com.cardgarden.project.model.cardDetail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cardgarden.project.model.benefitDetail.BenefitDetailDTO;

@Repository
public class CardDAOMybatis implements CardDAOInterface {
	@Autowired
    private SqlSessionTemplate sqlSession;

    private final String namespace = "com.cardgarden.card";
	
    @Override
    public List<CardDTO> selectTopLikeCardByCompany() {
        return sqlSession.selectList(namespace + ".selectTopLikeCardByCompany");
    }
    
	@Override
	public List<CardDTO> selectById(int cardId){
		List<CardDTO> cardList = sqlSession.selectList(namespace+".selectById",cardId);
		return cardList;
	}
	
	public List<CardBenefitRankDTO> selectPatternCardID(int patternid, int cardid){
	    Map<String, Object> param = new HashMap<>();
	    param.put("patternid", patternid);
	    param.put("cardid", cardid);
	    return sqlSession.selectList("com.cardgarden.benefitDetail.selectPatternCardID", param);
	}
	
	@Override
	public List<CardDetailDTO> selectDetailByID(int cardId) {
	    List<CardDetailDTO> cardlist = sqlSession.selectList(namespace + ".selectDetailByID", cardId);
	    
	    List<CardDetailDTO> resultList = new ArrayList<>();
	    JSONParser parser = new JSONParser();

	    for (CardDetailDTO dto : cardlist) {
	        String json = dto.getCardbenefitdetail_info();
	        if (json == null || json.trim().isEmpty()) continue;

	        try {
	            JSONArray jsonArray = (JSONArray) parser.parse(json);
	            for (Object obj : jsonArray) {	            	
	                JSONObject jsonObj = (JSONObject) obj;
	                String title = (String) jsonObj.get("title");
	                String description = (String) jsonObj.get("description");
	                CardDetailDTO item = CardDetailDTO.builder()
	                        .card_id(dto.getCard_id())
	                        .cardbenefitdetail_id(dto.getCardbenefitdetail_id())
	                        .benefitdetail_id(dto.getBenefitdetail_id())
	                        .cardbenefitdetail_text(dto.getCardbenefitdetail_text())
	                        .cardbenefitdetail_info(dto.getCardbenefitdetail_info())
	                        .title(title)
	                        .description(description)
	                        .benefitdetail_image(dto.getBenefitdetail_image())
	                        .benefitdetail_name(dto.getBenefitdetail_name())
	                        .build();
	                resultList.add(item);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return resultList;
	}
}
