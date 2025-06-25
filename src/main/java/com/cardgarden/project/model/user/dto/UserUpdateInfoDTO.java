package com.cardgarden.project.model.user.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class UserUpdateInfoDTO {
	private int user_id;
	private String user_name;
	private String user_password;
	private String email;
	private String nickname;
	private String name;
	private String gender;
	private String phone;
	private String address;
	private Date created_at;
	private String is_admin;
}