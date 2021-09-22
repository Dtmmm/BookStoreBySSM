package com.ssm.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssm.mapper.BookMapper;
import com.ssm.pojo.Book;
import com.ssm.service.BookService;

@Service("bookService")
public class BookServiceImpl implements BookService{
	//生成dao层对象
	@Autowired
	@Qualifier("bookMapper")
	private BookMapper bookMapper;
	
	
	
	//查询所有图书
	@Override
	public List<Book> queryAllBooks() {
		List<Book> allBooks = bookMapper.queryAllBooksDao();
		return allBooks;
	}
	
	//根据id查询图书
	@Override
	public Book queryBookByBookId(String id) {
		Book book = bookMapper.queryBookByBookIdDao(id);
		return book;
	}
	
	//添加图书
	@Override
	public boolean addBook(Book book) {
		boolean result = bookMapper.addBookDao(book);
		return result;
	}
	
	//修改图书
	@Override
	public boolean updateBook(Book book) {
		boolean result = bookMapper.updateBookDao(book);
		return result;
	}
	
	//删除图书
	@Override
	public boolean deleteBook(String id) {
		boolean result = bookMapper.deleteBookDao(id);
		return result;
	}
	
	//根据书名、作者名、出版社名模糊查询图书
	@Override
	public List<Book> searchBook(Book book) {
		List<Book> searchdBooks = bookMapper.searchBookDao(book);
		return searchdBooks;
	}
	
	//更新图书库存信息
	@Override
	public boolean updateBookInventory(String bookId, int number) {
		//获取该书的库存
		Book book = bookMapper.queryBookByBookIdDao(bookId);
		int inventory = book.getInventory();
	
		//封装更新条件
		Book updatedbook = new Book();
		updatedbook.setBookId(bookId);
		updatedbook.setInventory(inventory-number);
		
		boolean result = bookMapper.updateBookInventoryDao(updatedbook);
		return result;
	}
	
	//查询fresh书
	@Override
	public List<Book> queryFreshBook() {
		List<Book> allBooks = bookMapper.queryAllBooksDao();
		List<Book> freshBooks = new ArrayList<>();
		for(Book book : allBooks) {
			boolean fresh = book.isFresh();
			if(fresh==true) {
				freshBooks.add(book);
			} 
		}
		return freshBooks;
	}
	
	//查询hot书
	@Override
	public List<Book> queryHotSoleBook() {
		List<Book> allBooks = bookMapper.queryAllBooksDao();
		List<Book> hotSoleBooks = new ArrayList<>();
		for(Book book : allBooks) {
			boolean fresh = book.isHot();
			if(fresh==true) {
				hotSoleBooks.add(book);
			} 
		}
		return hotSoleBooks;
	}
	
	//查询recommend书
	public List<Book> queryRecommendedBook() {
		List<Book> allBooks = bookMapper.queryAllBooksDao();
		List<Book> recommendedBooks = new ArrayList<>();
		for(Book book : allBooks) {
			boolean recommended = book.isRecommended();
			if(recommended==true) recommendedBooks.add(book);
		}
		return recommendedBooks;
	}
	
	//查询sole书
	@Override
	public List<Book> querySoleBook() {
		List<Book> allBooks = bookMapper.queryAllBooksDao();
		List<Book> soleBooks = new ArrayList<>();
		for(Book book : allBooks) {
			boolean sole = book.isSole();
			if(sole==true) soleBooks.add(book);
		}
		return soleBooks;
	}
	
	//根据分类查询图书
	@Override
	public List<Book> queryClassificationBook(String bClassification, String sClassification) {
		List<Book> allBooks = bookMapper.queryAllBooksDao();
		List<Book> classificationBooks = new ArrayList<>();
		if(sClassification.equals("null")) {
			for(Book book : allBooks) {
				String DBbClassification = book.getbClassification();
				if(DBbClassification.equals(bClassification)) classificationBooks.add(book);
			}
		}else {
			for(Book book : allBooks) {
				String DBbClassification = book.getbClassification();
				String DBsClassification = book.getsClassification();
				if(DBbClassification.equals(bClassification)&&DBsClassification.equals(sClassification)) classificationBooks.add(book);
			}
		}
		return classificationBooks;
	}
	

	
}
