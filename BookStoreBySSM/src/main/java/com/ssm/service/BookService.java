package com.ssm.service;

import java.util.List;

import com.ssm.pojo.Book;

public interface BookService {
	
	//查询所有图书
	public List<Book> queryAllBooks();
	
	//根据id查询图书
	public Book queryBookByBookId(String id);
	
	//添加图书
	public boolean addBook(Book book);
	
	//修改图书
	public boolean updateBook(Book book);
	
	//删除图书
	public boolean deleteBook(String id);
	
	//根据书名、作者名、出版社名模糊查询图书
	public List<Book> searchBook(Book book);
	
	//更新图书库存信息
	public boolean updateBookInventory(String bookId, int number);
	
	//查询fresh书
	public List<Book> queryFreshBook();
	
	//查询hot书
	public List<Book> queryHotSoleBook();
	
	//查询recommend书
	public List<Book> queryRecommendedBook();
	
	//查询sole书
	public List<Book> querySoleBook();
	
	//根据分类查询图书(分页)
	public List<Book> queryBookByClassification(Book book);
	
	
	
}
