package com.blog.entities;

public class Category {
	private int cid;
	private String title, content;

	public Category(int cid, String title, String content) {
		super();
		this.cid = cid;
		this.title = title;
		this.content = content;
	}

	public Category(String title, String content) {
		super();
		this.title = title;
		this.content = content;
	}

	public Category() {

	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
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

}
