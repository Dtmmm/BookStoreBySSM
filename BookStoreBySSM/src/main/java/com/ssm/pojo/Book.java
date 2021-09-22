package com.ssm.pojo;

public class Book {
	private String bookId;
	private String bookName;
	private String author;
	private float price;
	private String publisher;
	private String date;
	private int inventory;
	private String img;
	private String intro;
	private String bClassification;
	private String sClassification;
	private boolean fresh;
	private boolean hot;
	private boolean recommended;
	private boolean sole;
	private int totalSaleNumber;
	
	public Book() {
		super();
	}

	public Book(String bookId, String bookName, String author, float price, String publisher, String date,
			int inventory, String img, String intro, String bClassification, String sClassification, boolean fresh,
			boolean hot, boolean recommended, boolean sole, int totalSaleNumber) {
		super();
		this.bookId = bookId;
		this.bookName = bookName;
		this.author = author;
		this.price = price;
		this.publisher = publisher;
		this.date = date;
		this.inventory = inventory;
		this.img = img;
		this.intro = intro;
		this.bClassification = bClassification;
		this.sClassification = sClassification;
		this.fresh = fresh;
		this.hot = hot;
		this.recommended = recommended;
		this.sole = sole;
		this.totalSaleNumber = totalSaleNumber;
	}

	public String getBookId() {
		return bookId;
	}

	public void setBookId(String bookId) {
		this.bookId = bookId;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getInventory() {
		return inventory;
	}

	public void setInventory(int inventory) {
		this.inventory = inventory;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}


	public String getbClassification() {
		return bClassification;
	}

	public void setbClassification(String bClassification) {
		this.bClassification = bClassification;
	}

	public String getsClassification() {
		return sClassification;
	}

	public void setsClassification(String sClassification) {
		this.sClassification = sClassification;
	}

	public boolean isFresh() {
		return fresh;
	}

	public void setFresh(boolean fresh) {
		this.fresh = fresh;
	}

	public boolean isHot() {
		return hot;
	}

	public void setHot(boolean hot) {
		this.hot = hot;
	}

	public boolean isRecommended() {
		return recommended;
	}

	public void setRecommended(boolean recommended) {
		this.recommended = recommended;
	}

	public boolean isSole() {
		return sole;
	}

	public void setSole(boolean sole) {
		this.sole = sole;
	}

	public int getTotalSaleNumber() {
		return totalSaleNumber;
	}

	public void setTotalSaleNumber(int totalSaleNumber) {
		this.totalSaleNumber = totalSaleNumber;
	}
	
	
}
