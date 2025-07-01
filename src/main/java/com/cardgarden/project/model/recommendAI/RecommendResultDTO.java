package com.cardgarden.project.model.recommendAI;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class RecommendResultDTO {
    private int matched_category_count;
    private double q_value;
    private boolean recommend;
}
