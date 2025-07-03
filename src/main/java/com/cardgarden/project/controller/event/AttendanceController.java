package com.cardgarden.project.controller.event;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

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

    private AttendanceDAOInterface dao;  
    @Autowired
    private AttendanceService service;

    @GetMapping("/event/attendance")
    public String attendancePage(HttpSession session, Model model) {

        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
        	session.setAttribute("msg", "로그인이 필요한 기능입니다");
        	session.setAttribute("redirectAfterLogin", "/event/attendance");
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
        String targetMonth = new SimpleDateFormat("yyyy-MM").format(todayDate);
        Map<String, Object> monthParam = new HashMap<>();
        monthParam.put("userId", userId);
        monthParam.put("targetMonth", targetMonth);
        model.addAttribute("attendedDays", service.getAttendedDays(monthParam));

        // 보상 상태 체크
        Map<String, Boolean> rewardStatus = new HashMap<>();
        String weekStartStr = getWeekStart(todayDate);
        Date weekStartDate = Date.valueOf(weekStartStr);
        param.put("weekStart", weekStartDate);

        int weeklyCount = service.getWeeklyAttendanceCount(param);
        rewardStatus.put("weekly3", weeklyCount >= 3);
        rewardStatus.put("weekly5", weeklyCount >= 5);

        param.put("todayMMDD", new SimpleDateFormat("MM-dd").format(todayDate));
        rewardStatus.put("birthday", service.getBirthdayCheck(param) > 0);

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
        String today = new SimpleDateFormat("yyyy-MM-dd").format(todayDate);

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

            String weekStartStr = getWeekStart(todayDate);
            Date weekStartDate = Date.valueOf(weekStartStr);
            param.put("weekStart", weekStartDate);

            int weeklyCount = service.getWeeklyAttendanceCount(param);

            if (weeklyCount == 3 && service.checkWeeklyBonus(param) == null) {
                param.put("point", 100);
                service.addPoint(param);
                totalPoint += 100;

                WeeklyBonusDTO weekly = new WeeklyBonusDTO();
                weekly.setUserId(userId);
                weekly.setWeekStart(weekStartDate);
                weekly.setBonusGiven("Y");
                service.insertWeeklyBonus(weekly);
            }

            if (weeklyCount == 5 && service.checkMonthlyBonus(param) == null) {
                param.put("point", 150);
                service.addPoint(param);
                totalPoint += 150;

                MonthlyBonusDTO monthly = new MonthlyBonusDTO();
                monthly.setUserId(userId);
                monthly.setMonthStart(weekStartDate);
                monthly.setBonusGiven("Y");
                service.insertMonthlyBonus(monthly);
            }

            Calendar cal = Calendar.getInstance();
            cal.setTime(todayDate);
            if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.WEDNESDAY) {
                param.put("point", 50);
                service.addPoint(param);
                totalPoint += 50;
            }

            param.put("todayMMDD", new SimpleDateFormat("MM-dd").format(todayDate));
            if (service.getBirthdayCheck(param) > 0) {
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
        return new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
    }
}
