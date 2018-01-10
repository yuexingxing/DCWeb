package com.fh.entity;

public class Product {

	private String id;
	private String code;
	private String name;
	private String phone;
	private String credit_max_amount;
	private String credit_min_amount;
	private String rate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCredit_max_amount() {
		return credit_max_amount;
	}
	public void setCredit_max_amount(String credit_max_amount) {
		this.credit_max_amount = credit_max_amount;
	}
	public String getCredit_min_amount() {
		return credit_min_amount;
	}
	public void setCredit_min_amount(String credit_min_amount) {
		this.credit_min_amount = credit_min_amount;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
}
