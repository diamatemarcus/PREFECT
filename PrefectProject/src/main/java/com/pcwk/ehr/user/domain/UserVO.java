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
	private String tel;
	private String edu;
	private String role;
	private String salt;
	private String gender;
	
	
	@Override
	public String toString() {
		return "UserVO [email=" + email + ", name=" + name + ", password=" + password + ", tel=" + tel + ", edu=" + edu
				+ ", role=" + role + ", salt=" + salt + ", gender=" + gender + ", toString()=" + super.toString() + "]";
	}



	public UserVO(String email, String name, String password, String tel, String edu, String role, String salt) {
		super();
		this.email = email;
		this.name = name;
		this.password = password;
		this.tel = tel;
		this.edu = edu;
		this.role = role;
		this.salt = salt;
	}

}
