package com.cardgarden.project.model.term.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cardgarden.project.model.term.dto.TermDTO;

import lombok.extern.slf4j.Slf4j;

@Repository //DAO + Bean등록 + DB예외 Spring 예외로 처리
@Slf4j
public class TermDAO implements TermDAOInterface {
   
   @Autowired
   SqlSession sqlSession;
   
   String namespace = "com.cardgarden.sample.";

   @Override
   public List<TermDTO> selectAll() {
      List<TermDTO> dtolist = sqlSession.selectList(namespace + "selectAll");
      log.info(dtolist.size() + "건 조회됨(lombok_Slf4j)");
      return dtolist;
   }

   @Override
   public TermDTO selectById(int id) {
      TermDTO sample = sqlSession.selectOne(namespace + "selectById", id);
      log.info(sample.toString() + " ... (lombok_Slf4j)");
      return sample;
   }

   @Override
   public int insert(TermDTO dto) {
      int result = sqlSession.insert(namespace + "insert", dto);
      log.info(result + "건 입력됨(lombok_Slf4j)");
      return result;
   }

   @Override
   public int update(TermDTO dto) {
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
