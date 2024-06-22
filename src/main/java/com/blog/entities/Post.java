package com.blog.entities;

import java.sql.Timestamp;

public class Post {
	private int pid;
	private String title, content, pcode;
	private Timestamp pdate;
	private int cid,userId;
	
	
	public Post() {
		
	}

	public Post(int pid, String title, String content, String pcode, Timestamp pdate, int cid,int userId) {
		super();
		this.pid = pid;
		this.title = title;
		this.content = content;
		this.pcode = pcode;
		this.pdate = pdate;
		this.cid = cid;
		this.userId = userId;
	}

	public Post(String title, String content, String pcode,  Timestamp pdate, int cid,int userId) {
		super();
		this.title = title;
		this.content = content;
		this.pcode = pcode;
		this.pdate = pdate;
		this.cid = cid;
		this.userId = userId;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	public Timestamp getPdate() {
		return pdate;
	}

	public void setPdate(Timestamp pdate) {
		this.pdate = pdate;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	

};