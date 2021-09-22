package com.ssm.pojo;

public class Deal {
	private String id;
	private String bookId;
	private int number;
	private float price;
	private String time;
	private String address;
	private String payWay;
	
	public Deal() {
		super();
	}

	public Deal(String id, String bookId, int number, float price, String time, String address, String payWay) {
		super();
		this.id = id;
		this.bookId = bookId;
		this.number = number;
		this.price = price;
		this.time = time;
		this.address = address;
		this.payWay = payWay;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBookId() {
		return bookId;
	}

	public void setBookId(String bookId) {
		this.bookId = bookId;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPayWay() {
		return payWay;
	}

	public void setPayWay(String payWay) {
		this.payWay = payWay;
	}
	
}
