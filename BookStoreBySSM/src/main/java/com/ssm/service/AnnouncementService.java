package com.ssm.service;

import java.util.List;

import com.ssm.pojo.Announcement;

public interface AnnouncementService {
	
	//查询所有通知
	List<Announcement> queryAllAnnouncements();
	
	//根据announcementId查询通知
	Announcement queryAnnouncement(String announcementId);
	
	//添加通知
	boolean addAnnouncement(Announcement announcement);
	
	//删除通知
	boolean deleteAnnouncement(String announcementId);
	
	//修改通知
	boolean updateAnnouncement(Announcement announcement);
	
	//查询所有要展示的通知
	public List<Announcement> queryAllShowedAnnouncements();

}
