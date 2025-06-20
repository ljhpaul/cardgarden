package com.cardgarden.project.model.term.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cardgarden.project.model.term.dao.TermDAOInterface;
import com.cardgarden.project.model.term.dto.TermDTO;

import lombok.extern.java.Log;

@Service //@Componet + 서비스 역할
@Log
public class TermService {
   
   @Autowired   //타입이 같으면 Injection, 같은 타입이 여러 개 있으면 이름으로 Injection
   @Qualifier("termDAO")
   TermDAOInterface termDAO;

   public List<TermDTO> selectAll() {
      List<TermDTO> dtolist = termDAO.selectAll();
      log.info("TermService에서 로그출력:" + dtolist.size() + "건");
      return dtolist;
   }

   // 2.Select(Read)..상세보기
   public TermDTO selectById(int id) {
      TermDTO dto = termDAO.selectById(id);
      log.info("TermService에서 로그출력:" + dto.toString());
      return dto;
   }

   // 3.Inert
   public int insert(TermDTO dto) {
      int result = termDAO.insert(dto);
      log.info("TermService에서 로그출력:" + result + "건 insert");
      return result;
   }

   // 4.Update
   public int update(TermDTO dto) {
      int result = termDAO.update(dto);
      log.info("TermService에서 로그출력:" + result + "건 update");
      return result;
   }

   // 5.Delete
   public int delete(int id) {
      int result = termDAO.delete(id);
      log.info("TermService에서 로그출력:" + result + "건 delete");
      return result;
   }
}