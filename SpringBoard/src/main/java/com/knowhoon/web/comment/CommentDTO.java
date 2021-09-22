package com.knowhoon.web.comment;

public class CommentDTO {
	private int sc_no, sb_nno, sb_no, sb_cate, sm_no, sc_like, sc_del, sm_grade;
	private String sc_comment, sc_date, sc_modifydate, sm_name, sm_id;
	public int getSc_no() {
		return sc_no;
	}
	public int getSc_like() {
		return sc_like;
	}
	public void setSc_like(int sc_like) {
		this.sc_like = sc_like;
	}
	public int getSm_grade() {
		return sm_grade;
	}
	public void setSm_grade(int sm_grade) {
		this.sm_grade = sm_grade;
	}
	public String getSm_name() {
		return sm_name;
	}
	public void setSm_name(String sm_name) {
		this.sm_name = sm_name;
	}
	public String getSm_id() {
		return sm_id;
	}
	public void setSm_id(String sm_id) {
		this.sm_id = sm_id;
	}
	public void setSc_no(int sc_no) {
		this.sc_no = sc_no;
	}
	public int getSb_no() {
		return sb_no;
	}
	public void setSb_no(int sb_no) {
		this.sb_no = sb_no;
	}
	public int getSm_no() {
		return sm_no;
	}
	public void setSm_no(int sm_no) {
		this.sm_no = sm_no;
	}
	public int getSc_del() {
		return sc_del;
	}
	public void setSc_del(int sc_del) {
		this.sc_del = sc_del;
	}
	public String getSc_comment() {
		return sc_comment;
	}
	public void setSc_comment(String sc_comment) {
		this.sc_comment = sc_comment;
	}
	public String getSc_date() {
		return sc_date;
	}
	public void setSc_date(String sc_date) {
		this.sc_date = sc_date;
	}
	public String getSc_modifydate() {
		return sc_modifydate;
	}
	public void setSc_modifydate(String sc_modifydate) {
		this.sc_modifydate = sc_modifydate;
	}
	public int getSb_nno() {
		return sb_nno;
	}
	public void setSb_nno(int sb_nno) {
		this.sb_nno = sb_nno;
	}
	public int getSb_cate() {
		return sb_cate;
	}
	public void setSb_cate(int sb_cate) {
		this.sb_cate = sb_cate;
	}

}
