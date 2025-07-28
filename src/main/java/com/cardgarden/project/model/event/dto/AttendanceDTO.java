package com.cardgarden.project.model.event.dto;

import lombok.Data;
import java.sql.Date;

@Data
public class AttendanceDTO {

    private int userId;  
    private Date date;  
}
