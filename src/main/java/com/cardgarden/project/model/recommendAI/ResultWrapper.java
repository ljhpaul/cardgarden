package com.cardgarden.project.model.recommendAI;

import java.util.List;

import lombok.Data;

@Data
public class ResultWrapper {
//    private Double result;
    private List<CardRecommendationDTO> result;
}
