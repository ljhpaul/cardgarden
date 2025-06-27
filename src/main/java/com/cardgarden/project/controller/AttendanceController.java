package com.cardgarden.project.controller;

import java.sql.Date;  
import java.text.SimpleDateFormat;  
import java.util.*;  
import javax.servlet.http.HttpSession;  

import com.cardgarden.project.model.event.dao.AttendanceDAOInterface;  
import com.cardgarden.project.model.event.dto.AttendanceDTO;  
import com.cardgarden.project.model.event.dto.MonthlyBonusDTO;  
import com.cardgarden.project.model.event.dto.WeeklyBonusDTO;  
import com.cardgarden.project.model.event.service.AttendanceService;  

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.GetMapping;  
import org.springframework.web.bind.annotation.PostMapping;  

@Controller  
public class AttendanceController {  

    @Autowired  
    private AttendanceService service;  

    @Autowired  
    private AttendanceDAOInterface dao;  

    @GetMapping("/event/attendance")  
    public String attendancePage(HttpSession session, Model model) {  

        Object userIdObj = session.getAttribute("loginUserId");  
        if (userIdObj == null) {  
            return "redirect:/user/login";  
        }  

        int userId = (int) userIdObj;  
        Date todayDate = new Date(System.currentTimeMillis());  

        Map<String, Object> param = new HashMap<>();  
        param.put("userId", userId);  
        param.put("today", new SimpleDateFormat("yyyy-MM-dd").format(todayDate));  

        // 오늘 출석 여부  
        boolean alreadyAttended = service.getTodayAttendance(param) != null;  
        model.addAttribute("alreadyAttended", alreadyAttended);  

        // 출석한 날짜 리스트  
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");  
        String targetMonth = sdf.format(todayDate);  
        Map<String, Object> monthParam = new HashMap<>();  
        monthParam.put("userId", userId);  
        monthParam.put("targetMonth", targetMonth);  
        List<Integer> attendedDays = dao.selectAttendedDays(monthParam);  
        model.addAttribute("attendedDays", attendedDays);  

        // 보상 상태 체크  
        Map<String, Boolean> rewardStatus = new HashMap<>();  
        String weekStart = getWeekStart(todayDate);  
        param.put("weekStart", weekStart);  
        int weeklyCount = service.getWeeklyAttendanceCount(param);
        // 주 3일 이상 출석 보상  
        rewardStatus.put("weekly3", weeklyCount >= 3); 

        // 주 5일 이상 출석 보상 (MonthlyBonus로 판단)  
        rewardStatus.put("weekly5", weeklyCount >= 5); 

        // 생일 보상 여부  
        SimpleDateFormat birthFormat = new SimpleDateFormat("MM-dd");  
        param.put("todayMMDD", birthFormat.format(todayDate));  
        rewardStatus.put("birthday", service.getBirthdayCheck(param) > 0);  

        // 수요일 보상 여부  
        Calendar cal = Calendar.getInstance();  
        cal.setTime(todayDate);  
        rewardStatus.put("wednesday", cal.get(Calendar.DAY_OF_WEEK) == Calendar.WEDNESDAY);  

        model.addAttribute("rewardStatus", rewardStatus);  

        // 출석 완료 팝업 처리  
        String attendanceCheck = (String) session.getAttribute("attendanceCheck");  
        if (attendanceCheck != null) {  
            model.addAttribute("attendanceCheck", attendanceCheck);  
            session.removeAttribute("attendanceCheck");  

            Integer receivedPoint = (Integer) session.getAttribute("receivedPoint");  
            if (receivedPoint != null) {  
                model.addAttribute("receivedPoint", receivedPoint);  
                session.removeAttribute("receivedPoint");  
            }  
        }  

        return "event/attendance";  
    }  

    @PostMapping("/event/attendance/check")
    public String checkAttendance(HttpSession session) {

        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/user/login";
        }

        int userId = (int) userIdObj;
        Date todayDate = new Date(System.currentTimeMillis());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String today = sdf.format(todayDate);

        Map<String, Object> param = new HashMap<>();
        param.put("userId", userId);
        param.put("today", today);

        int totalPoint = 0;

        if (service.getTodayAttendance(param) == null) {

            AttendanceDTO dto = new AttendanceDTO();
            dto.setUserId(userId);
            dto.setDate(todayDate);
            service.insertAttendance(dto);

            param.put("point", 50);
            service.addPoint(param);
            totalPoint += 50;

            String weekStart = getWeekStart(todayDate);
            param.put("weekStart", weekStart);

            if (service.checkWeeklyBonus(param) == null) {
                int count = service.getWeeklyAttendanceCount(param);
                if (count >= 3) {
                    param.put("point", 100);
                    service.addPoint(param);
                    totalPoint += 100;

                    WeeklyBonusDTO weekly = new WeeklyBonusDTO();
                    weekly.setUserId(userId);
                    weekly.setWeekStart(Date.valueOf(weekStart));
                    weekly.setBonusGiven("Y");
                    service.insertWeeklyBonus(weekly);
                }
            }

            if (service.checkMonthlyBonus(param) == null) {
                int count = service.getWeeklyAttendanceCount(param);
                if (count >= 5) {
                    param.put("point", 150);
                    service.addPoint(param);
                    totalPoint += 150;

                    MonthlyBonusDTO monthly = new MonthlyBonusDTO();
                    monthly.setUserId(userId);
                    monthly.setMonthStart(Date.valueOf(weekStart));
                    monthly.setBonusGiven("Y");
                    service.insertMonthlyBonus(monthly);
                }
            }

            Calendar cal = Calendar.getInstance();
            cal.setTime(todayDate);
            if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.WEDNESDAY) {
                param.put("point", 50);
                service.addPoint(param);
                totalPoint += 50;
            }

            SimpleDateFormat birthFormat = new SimpleDateFormat("MM-dd");
            param.put("todayMMDD", birthFormat.format(todayDate));
            int isBirthday = service.getBirthdayCheck(param);
            if (isBirthday > 0) {
                param.put("point", 200);
                service.addPoint(param);
                totalPoint += 200;
            }

            session.setAttribute("attendanceCheck", "success");
            session.setAttribute("receivedPoint", totalPoint);
        }

        return "redirect:/event/attendance";
    }

    private String getWeekStart(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(cal.getTime());
    }
}  
