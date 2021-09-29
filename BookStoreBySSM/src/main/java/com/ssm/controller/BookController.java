package com.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.pojo.Book;
import com.ssm.service.BookService;

@Controller("bookController")
@RequestMapping("/bookController")
public class BookController {
	//生成service层对象
	@Autowired
	@Qualifier("bookService")
	private BookService bookService;
	
	
	//查询所有图书
	@RequestMapping("/queryAllBooks")
	public String queryAllBooks(Model model) {
		List<Book> allBooks = bookService.queryAllBooks();
		model.addAttribute("allBooks", allBooks);
		return "BookManager";
	}
	
	
//	//根据id查询图书
//	@RequestMapping("/queryBookByBookId")
//	public String queryBookByBookId(@RequestParam("bookId") String bookId, Model model) {
//		Book book = bookService.queryBookByBookId(bookId);
//		model.addAttribute("book", book);
//		return "testBook";
//	}
	
	
	//添加图书
	@RequestMapping("/addBook")
	//使用Spring的自动绑定入参，将前端的值自动绑定到book中
	public String addBook(Book book) {
		boolean result = bookService.addBook(book);
		if(result) return "redirect:queryAllBooks";
		return "error";
	}
	
	
	//修改图书
	@RequestMapping("/updateBook")
	//使用Spring的自动绑定入参，将前端的值自动绑定到book中
	public String updateBook(Book book, Model model) {
		boolean result = bookService.updateBook(book);
		if(result) {
			model.addAttribute("bookId", book.getBookId());
			model.addAttribute("id", "000");
			return "Info";
		}
		return "error";
	}
	
	
	//删除图书
	@RequestMapping("/deleteBook")
	public String deleteBook(@RequestParam("bookId") String bookId) {
		boolean result = bookService.deleteBook(bookId);
		if(result) return "redirect:queryAllBooks";
		return "error";
	}
	
	
	//根据书名、作者名、出版社名模糊查询图书(分页)
	@RequestMapping("/searchBook")
	public String searchBook(
			@RequestParam(name="page",defaultValue="1") Integer page,
			@RequestParam("searchCondition") String searchCondition, Model model) {
		//将查询条件放入request域
		model.addAttribute("searchCondition", searchCondition);
		
		//封装模糊查询的条件
		Book searchConditionBook = new Book();
		searchConditionBook.setBookName(searchCondition);
		searchConditionBook.setAuthor(searchCondition);
		searchConditionBook.setPublisher(searchCondition);
		
		//引入pageHelper分页
		PageHelper.startPage(page, 8);//每页条数=8
		List<Book> searchedBooks = bookService.searchBook(searchConditionBook);
		/**
		 * pageNum:当前页
		 * pageSize:每页的数量
		 * size:当前页的数量
		 * pages:总页数
		 * total:总记录数
		 */
		PageInfo<Book> pageInfo = new PageInfo<Book>(searchedBooks);//把数据放在分页类中
		model.addAttribute("searchedBooks", searchedBooks);
		model.addAttribute("pageInfo", pageInfo);
		return "Search";
	}
	
	
	//根据分类查询图书(分页)
	@RequestMapping("/queryClassificationBook")
	public String queryClassificationBook(
			@RequestParam(name="page",defaultValue="1") Integer page,
			@RequestParam("bClassification") String bClassification, 
			@RequestParam("sClassification") String sClassification, Model model) {
	
		//将查询条件放入request域
		model.addAttribute("classification", sClassification.equals("null")?bClassification:sClassification);
		if("null".equals("sClassification")||"".equals(sClassification)) {
			model.addAttribute("bClassification",bClassification);
		}else {
			model.addAttribute("bClassification",bClassification);
			model.addAttribute("sClassification",sClassification);
		}
		
		//封装查询条件
		Book conditionBook = new Book();
		if(!"null".equals(sClassification)&&!"".equals(sClassification)) {
			conditionBook.setsClassification(sClassification);
		}
		if(!"null".equals(bClassification)&&!"".equals(bClassification)) {
			conditionBook.setbClassification(bClassification);
		}
		
		
		//引入pageHelper分页
		PageHelper.startPage(page, 8);//每页条数=8
		List<Book> classificationBooks = bookService.queryBookByClassification(conditionBook);
		for (Book book : classificationBooks) {
			System.out.println(book.getBookId());
		}
		
		/**
		 * pageNum:当前页
		 * pageSize:每页的数量
		 * size:当前页的数量
		 * pages:总页数
		 * total:总记录数
		 */
		PageInfo<Book> pageInfo = new PageInfo<Book>(classificationBooks);//把数据放在分页类中
		model.addAttribute("classificationBooks", classificationBooks);
		model.addAttribute("pageInfo", pageInfo);
		
		return "Classification";
	}
	
	
	
}
