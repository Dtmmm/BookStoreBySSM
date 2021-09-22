package com.ssm.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssm.mapper.AnnouncementMapper;
import com.ssm.pojo.Announcement;
import com.ssm.service.AnnouncementService;

@Service("announcementService")
public class AnnouncementServiceImpl implements AnnouncementService{
	//生成dao层对象
	@Autowired
	@Qualifier("announcementMapper")
	private AnnouncementMapper announcementMapper;
	
	
	//查询所有通知
	@Override
	public List<Announcement> queryAllAnnouncements() {
		List<Announcement> allAnnouncements = announcementMapper.queryAllAnnouncementsDao();
		return allAnnouncements;
	}
	
	//根据announcementId查询通知
	@Override
	public Announcement queryAnnouncement(String announcementId) {
		Announcement announcement = announcementMapper.queryAnnouncementDao(announcementId);
		return announcement;
	}
	
	//添加通知
	@Override
	public boolean addAnnouncement(Announcement announcement) {
		boolean result = announcementMapper.addAnnouncementDao(announcement);
		return result;
	}
	
	//删除通知
	@Override
	public boolean deleteAnnouncement(String announcementId) {
		boolean result = announcementMapper.deleteAnnouncementDao(announcementId);
		return result;
	}
	
	//修改通知
	@Override
	public boolean updateAnnouncement(Announcement announcement) {
		boolean result = announcementMapper.updateAnnouncementDao(announcement);
		return result;
	}
	
	//查询所有要展示的通知
	@Override
	public List<Announcement> queryAllShowedAnnouncements() {
		List<Announcement> allAnnouncements = announcementMapper.queryAllAnnouncementsDao();
		List<Announcement> allShowedAnnouncements = new ArrayList<>();
		
		for(Announcement announcement : allAnnouncements) {
			if(announcement.isAnnouncementShow()) allShowedAnnouncements.add(announcement);
		}
		return allShowedAnnouncements;
	}
	
}
