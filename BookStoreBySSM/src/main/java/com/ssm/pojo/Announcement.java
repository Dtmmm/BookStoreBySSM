package com.ssm.pojo;

public class Announcement {
	private String announcementId;
	private String announcementTitle;
	private String announcementContent;
	private boolean announcementShow;
	
	public Announcement() {
		super();
	}

	public Announcement(String announcementId, String announcementTitle, String announcementContent, boolean announcementShow) {
		super();
		this.announcementId = announcementId;
		this.announcementTitle = announcementTitle;
		this.announcementContent = announcementContent;
		this.announcementShow = announcementShow;
	}

	public String getAnnouncementId() {
		return announcementId;
	}

	public void setAnnouncementId(String announcementId) {
		this.announcementId = announcementId;
	}

	public String getAnnouncementTitle() {
		return announcementTitle;
	}

	public void setAnnouncementTitle(String announcementTitle) {
		this.announcementTitle = announcementTitle;
	}

	public String getAnnouncementContent() {
		return announcementContent;
	}

	public void setAnnouncementContent(String announcementContent) {
		this.announcementContent = announcementContent;
	}

	public boolean isAnnouncementShow() {
		return announcementShow;
	}

	public void setAnnouncementShow(boolean announcementShow) {
		this.announcementShow = announcementShow;
	}


}
