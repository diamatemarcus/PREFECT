package com.pcwk.ehr.user.domain;

import com.pcwk.ehr.cmn.DTO;

public class UserVO extends DTO {
	//ctrl+shift+y : 소문자로
	//ctrl+shift+x : 대문자로
	private String userId  ;//아이디
	private String name     ;//이름
	private String password ;//비번
	
	//2023.12.01 추가
    private Level level    ;//등급
    private int login      ;//로그인 횟수
    private int recommend  ;//추천수
    private String email   ;//email
    private String regDt  ;//등록일    
	
    private int levelIntValue;//mybatis level -> int
    
    
	public UserVO() {}

	public UserVO(String userId, String name, String password, Level level, int login, int recommend, String email,
			String regDt) {
		super();
		this.userId = userId;
		this.name = name;
		this.password = password;
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.email = email;
		this.regDt = regDt;
		
		this.levelIntValue = level.intValue();
	}

	
	
	public int getLevelIntValue() {
		return levelIntValue;
	}

	public void setLevelIntValue(int levelIntValue) {
		this.levelIntValue = levelIntValue;
		
		//mybatis int -> level
		this.level  = Level.valueOf(levelIntValue);
	}

	//UserVO의 업그레이드
	public void upgradeLevel() {
		Level nextLevel = this.level.nextLevel();
		System.out.println("현재:"+level);
		if(null == nextLevel) {
			throw new IllegalArgumentException(this.level+"는 업그레이드 불가!");
		}else {
			level = nextLevel;
		}
		   
		System.out.println("nextLevel:"+level);
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
		
		if(null !=level) {
			this.levelIntValue = level.intValue();
		}
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", name=" + name + ", password=" + password + ", level=" + level
				+ ", login=" + login + ", recommend=" + recommend + ", email=" + email + ", regDt=" + regDt
				+ ", toString()=" + super.toString() + "]";
	}

	
}
