package com.cardgarden.project.model.sample;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//DTO(Data Transfer Object) ... data���۽� ���Ǵ� ��ü�� Ʋ(template)
//JavaBeans����� default�����ڰ� �־���Ѵ�.
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class SampleDTO {
	private int id;
	private String name;
}