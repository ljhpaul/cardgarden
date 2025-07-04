package com.cardgarden.project.model.cardDetail;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class CardDetailDTO {
    private int card_id;
    private int cardbenefitdetail_id;
    private int benefitdetail_id;
    private String cardbenefitdetail_text;    
    private String cardbenefitdetail_info;
    private String benefitdetail_name;
    private String title;
    private String description;
    private String benefitdetail_image;

    public void setDescription(String description) {
        if (description != null) {
            this.description = description.replace("\n", "<br/>");
        } else {
            this.description = null;
        }
    }

    public static class CardDetailDTOBuilder {
        public CardDetailDTOBuilder description(String description) {
            if (description != null) {
                this.description = description.replace("\n", "<br/>");
            } else {
                this.description = null;
            }
            return this;
        }
    }
}
