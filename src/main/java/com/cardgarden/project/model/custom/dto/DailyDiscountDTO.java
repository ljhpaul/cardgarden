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
public class DailyDiscountDTO {
    private int dd_id;
    private int asset_id;
    private LocalDate date;
}
