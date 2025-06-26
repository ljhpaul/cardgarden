package com.cardgarden.project.model.event.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cardgarden.project.model.event.dao.AttendanceDAOInterface;
import com.cardgarden.project.model.event.dto.AttendanceDTO;
import com.cardgarden.project.model.event.dto.WeeklyBonusDTO;
import com.cardgarden.project.model.event.dto.MonthlyBonusDTO;

@Service
public class AttendanceService {

    @Autowired
    private AttendanceDAOInterface dao;

    public AttendanceDTO getTodayAttendance(Map<String, Object> map) {
        return dao.getTodayAttendance(map);
    }

    public void insertAttendance(AttendanceDTO dto) {
        dao.insertAttendance(dto);
    }

    public WeeklyBonusDTO checkWeeklyBonus(Map<String, Object> map) {
        return dao.checkWeeklyBonus(map);
    }

    public int getWeeklyAttendanceCount(Map<String, Object> map) {
        return dao.getWeeklyAttendanceCount(map);
    }

    public void insertWeeklyBonus(WeeklyBonusDTO dto) {
        dao.insertWeeklyBonus(dto);
    }

    public MonthlyBonusDTO checkMonthlyBonus(Map<String, Object> map) {
        return dao.checkMonthlyBonus(map);
    }

    public void insertMonthlyBonus(MonthlyBonusDTO dto) {
        dao.insertMonthlyBonus(dto);
    }

    public int getBirthdayCheck(Map<String, Object> map) {
        return dao.getBirthdayCheck(map);
    }

    public void addPoint(Map<String, Object> map) {
        dao.addPoint(map);
    }
    
    public List<Integer> getAttendedDays(Map<String, Object> map) {
        return dao.selectAttendedDays(map);
    }
}
