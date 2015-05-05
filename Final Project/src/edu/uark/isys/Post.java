package edu.uark.isys;

import java.util.Date;

//Container for post data
public class Post implements Comparable<Post> {
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPost_text() {
		return post_text;
	}
	public void setPost_text(String post_text) {
		this.post_text = post_text;
	}
	public Date getPost_date() {
		return post_date;
	}
	public void setPost_date(Date post_date) {
		this.post_date = post_date;
	}
	private String username;
	private String post_text;
	private Date post_date;
	
	@Override
	public int compareTo(Post other) {
		return post_date.compareTo(other.getPost_date());
	}
}

