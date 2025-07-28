package com.cardgarden.project.model.custom.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OwnedAssetDTO {
    private int user_id;
    private int asset_id;
}
