package com.cardgarden.project.model.custom.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CustomAssetDTO {
    private int asset_id;
    private String asset_brand;
    private String asset_type;
    private int asset_no;
    private int asset_like;
    private int used;
    private int point_needed;
    private int discount;
    private String asset_name; 
    
    private int final_price; 
    
    
}