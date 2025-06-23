package com.cardgarden.project.model.custom.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DailyFreeDTO {
    private int df_id;
    private int asset_id;
    private LocalDate date;
}
