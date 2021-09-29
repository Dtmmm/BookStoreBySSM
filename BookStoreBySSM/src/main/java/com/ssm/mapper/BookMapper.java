package com.ssm.mapper;

import java.util.List;

import com.ssm.pojo.Book;


public interface BookMapper {
	
	//查询所有图书
	public List<Book> queryAllBooksDao();
	
	//根据id查询图书
	public Book queryBookByBookIdDao(String id);
	
	//添加图书
	public boolean addBookDao(Book book);
	
	//修改图书
	public boolean updateBookDao(Book book);
	
	//删除图书
	public boolean deleteBookDao(String id);
	
	//根据书名、作者名、出版社名模糊查询图书
	public List<Book> searchBookDao(Book book);
	
	//更新图书库存信息
	public boolean updateBookInventoryDao(Book book);
	
	//根据分类查询图书(分页)
	public List<Book> queryBookByClassificationDao(Book book);
	
}
