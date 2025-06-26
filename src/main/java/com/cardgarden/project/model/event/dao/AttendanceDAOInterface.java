package com.cardgarden.project.model.event.dao;

import java.util.List;
import java.util.Map;

import com.cardgarden.project.model.event.dto.AttendanceDTO;
import com.cardgarden.project.model.event.dto.WeeklyBonusDTO;
import com.cardgarden.project.model.event.dto.MonthlyBonusDTO;

public interface AttendanceDAOInterface {

    AttendanceDTO getTodayAttendance(Map<String, Object> map);

    int insertAttendance(AttendanceDTO attendanceDTO);

    WeeklyBonusDTO checkWeeklyBonus(Map<String, Object> map);

    int getWeeklyAttendanceCount(Map<String, Object> map);

    int insertWeeklyBonus(WeeklyBonusDTO weeklyBonusDTO);

    MonthlyBonusDTO checkMonthlyBonus(Map<String, Object> map);

    int insertMonthlyBonus(MonthlyBonusDTO monthlyBonusDTO);

    int getBirthdayCheck(Map<String, Object> map);

    int addPoint(Map<String, Object> map);
    
    List<Integer> selectAttendedDays(Map<String, Object> param);

}
