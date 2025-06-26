package com.cardgarden.project.model.event.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cardgarden.project.model.event.dto.AttendanceDTO;
import com.cardgarden.project.model.event.dto.WeeklyBonusDTO;
import com.cardgarden.project.model.event.dto.MonthlyBonusDTO;

@Repository
public class AttendanceDAOMybatis implements AttendanceDAOInterface {

    @Autowired
    private SqlSession sqlSession;

    private final String namespace = "com.cardgarden.attendance";

    @Override
    public AttendanceDTO getTodayAttendance(Map<String, Object> map) {
        return sqlSession.selectOne(namespace + ".getTodayAttendance", map);
    }

    @Override
    public int insertAttendance(AttendanceDTO attendanceDTO) {
        return sqlSession.insert(namespace + ".insertAttendance", attendanceDTO);
    }

    @Override
    public WeeklyBonusDTO checkWeeklyBonus(Map<String, Object> map) {
        return sqlSession.selectOne(namespace + ".checkWeeklyBonus", map);
    }

    @Override
    public int getWeeklyAttendanceCount(Map<String, Object> map) {
        return sqlSession.selectOne(namespace + ".getWeeklyAttendanceCount", map);
    }

    @Override
    public int insertWeeklyBonus(WeeklyBonusDTO weeklyBonusDTO) {
        return sqlSession.insert(namespace + ".insertWeeklyBonus", weeklyBonusDTO);
    }

    @Override
    public MonthlyBonusDTO checkMonthlyBonus(Map<String, Object> map) {
        return sqlSession.selectOne(namespace + ".checkMonthlyBonus", map);
    }

    @Override
    public int insertMonthlyBonus(MonthlyBonusDTO monthlyBonusDTO) {
        return sqlSession.insert(namespace + ".insertMonthlyBonus", monthlyBonusDTO);
    }

    @Override
    public int getBirthdayCheck(Map<String, Object> map) {
        return sqlSession.selectOne(namespace + ".isBirthday", map);
    }

    @Override
    public int addPoint(Map<String, Object> map) {
        return sqlSession.update(namespace + ".addPoint", map);
    }
    @Override
    public List<Integer> selectAttendedDays(Map<String, Object> param) {
        return sqlSession.selectList(namespace + ".selectAttendedDays", param);
    }
}
