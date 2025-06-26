package com.cardgarden.project.model.event.dto;

import lombok.Data;
import java.sql.Date;

@Data
public class MonthlyBonusDTO {

    private int userId;      
    private Date monthStart;   
    private String bonusGiven; 
}
