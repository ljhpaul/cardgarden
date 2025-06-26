package com.cardgarden.project.model.event.dto;

import lombok.Data;
import java.sql.Date;

@Data
public class WeeklyBonusDTO {

    private int userId;       // 사용자
    private Date weekStart;   // 그 주 월요일 날짜
    private String bonusGiven; // 이미 지급됐는지 여부 (Y/N)
}
