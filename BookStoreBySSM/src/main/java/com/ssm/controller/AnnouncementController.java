package com.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssm.pojo.Announcement;
import com.ssm.service.AnnouncementService;

@Controller("announcementController")
@RequestMapping("/announcementController")
public class AnnouncementController {
	//生成service层对象
	@Autowired
	@Qualifier("announcementService")
	private AnnouncementService announcementService;
	
	
	//查询所有通知
	@RequestMapping("/queryAllAnnouncements")
	public String queryAllAnnouncements(Model model) {
		List<Announcement> allAnnouncements = announcementService.queryAllAnnouncements();
		model.addAttribute("allAnnouncements", allAnnouncements);
		return "AnnouncementManager";
	}
	
	
	//根据announcementId查询通知
	@RequestMapping("/queryAnnouncement")
	public String queryAnnouncement(String announcementId, Model model) {
		Announcement announcement = announcementService.queryAnnouncement(announcementId);
		model.addAttribute("announcement", announcement);
		return "AnnouncementManager";
	}
	
	
	//添加通知
	@RequestMapping("/addAnnouncement")
	//使用Spring的自动绑定入参，将前端的值自动绑定到announcement中
	public String addAnnouncement(Announcement announcement, Model model) {
		boolean result = announcementService.addAnnouncement(announcement);
		if(result) return "redirect:queryAllAnnouncements";
		return "error";
	}
	
	
	//删除通知
	@RequestMapping("/deleteAnnouncement")
	public String deleteAnnouncement(@RequestParam("announcementId") String announcementId) {
		boolean result = announcementService.deleteAnnouncement(announcementId);
		if(result) return "redirect:queryAllAnnouncements";
		return "error";
	}
	
	
	//修改通知
	@RequestMapping("/updateAnnouncement")
	//使用Spring的自动绑定入参，将前端的值自动绑定到announcement中
	public String updateAnnouncement(Announcement announcement) {
		boolean result = announcementService.updateAnnouncement(announcement);
		if(result) return "redirect:queryAllAnnouncements";
		return "error";
	}
	
	
	
	
}
