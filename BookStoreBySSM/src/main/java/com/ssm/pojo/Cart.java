package com.ssm.pojo;

public class Cart {
	private String bookId;
	private int number;
	//为了方便执行SQL语句更新用户购物车信息，添加购物车表名的字段
	private String tableName;
	
	public Cart() {
		super();
	}

	public Cart(String bookId, int number) {
		super();
		this.bookId = bookId;
		this.number = number;
	}

	public Cart(String bookId, int number, String tableName) {
		super();
		this.bookId = bookId;
		this.number = number;
		this.tableName = tableName;
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

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	
}
