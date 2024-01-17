package com.pcwk.ehr.user.domain;

import com.pcwk.ehr.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor //default 생성자
@AllArgsConstructor//모든인자 생성자
public class UserVO extends DTO {
	private String email;
	private String name;
	private String password;
	private int tel;
	private String edu;
	private String role;
	@Override
	
	public String toString() {
		return "UserVO [email=" + email + ", name=" + name + ", password=" + password + ", tel=" + tel + ", edu=" + edu
				+ ", role=" + role + ", toString()=" + super.toString() + "]";
	}

}
