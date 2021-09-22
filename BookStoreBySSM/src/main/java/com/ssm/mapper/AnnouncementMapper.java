package com.ssm.mapper;

import java.util.List;

import com.ssm.pojo.Announcement;

public interface AnnouncementMapper {
	
	//查询所有通知
	List<Announcement> queryAllAnnouncementsDao();
	
	//根据announcementId查询通知
	Announcement queryAnnouncementDao(String announcementId);
	
	//添加通知
	boolean addAnnouncementDao(Announcement announcement);
	
	//删除通知
	boolean deleteAnnouncementDao(String announcementId);
	
	//修改通知
	boolean updateAnnouncementDao(Announcement announcement);
	
	
}
