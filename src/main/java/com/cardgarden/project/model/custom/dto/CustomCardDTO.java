package com.cardgarden.project.model.custom.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CustomCardDTO {
    private int customcard_id;
    private String customcard_name;
    private int user_id;
    private LocalDateTime created_at;
}
