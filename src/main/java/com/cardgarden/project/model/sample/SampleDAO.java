package com.cardgarden.project.model.sample;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository //DAO + Bean등록 + DB예외 Spring 예외로 처리
@Slf4j
public class SampleDAO implements SampleDAOInterface {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.cardgarden.sample.";

	@Override
	public List<SampleDTO> selectAll() {
		List<SampleDTO> dtolist = sqlSession.selectList(namespace + "selectAll");
		log.info(dtolist.size() + "건 조회됨(lombok_Slf4j)");
		return dtolist;
	}

	@Override
	public SampleDTO selectById(int id) {
		SampleDTO sample = sqlSession.selectOne(namespace + "selectById", id);
		log.info(sample.toString() + " ... (lombok_Slf4j)");
		return sample;
	}

	@Override
	public int insert(SampleDTO dto) {
		int result = sqlSession.insert(namespace + "insert", dto);
		log.info(result + "건 입력됨(lombok_Slf4j)");
		return result;
	}

	@Override
	public int update(SampleDTO dto) {
		int result = sqlSession.update(namespace + "update", dto);
		log.info(result + "건 수정됨(lombok_Slf4j)");
		return result;
	}

	@Override
	public int delete(int id) {
		int result = sqlSession.delete(namespace + "delete", id);
		log.info(result + "건 삭제됨(lombok_Slf4j)");
		return result;
	}
	
}
