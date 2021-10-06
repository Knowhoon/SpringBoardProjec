package com.knowhoon.web.board;

public class VoteDTO {
	private int sv_no, sb_no, sm_no, sb_vote;
	private String sm_id, sm_date;
	
	public int getSv_no() {
		return sv_no;
	}
	public void setSv_no(int sv_no) {
		this.sv_no = sv_no;
	}
	public int getSb_no() {
		return sb_no;
	}
	public void setSb_no(int sb_no) {
		this.sb_no = sb_no;
	}
	public int getSb_vote() {
		return sb_vote;
	}
	public void setSb_vote(int sb_vote) {
		this.sb_vote = sb_vote;
	}
	public String getSm_id() {
		return sm_id;
	}
	public void setSm_id(String sm_id) {
		this.sm_id = sm_id;
	}
	public String getSm_date() {
		return sm_date;
	}
	public void setSm_date(String sm_date) {
		this.sm_date = sm_date;
	}
	public int getSm_no() {
		return sm_no;
	}
	public void setSm_no(int sm_no) {
		this.sm_no = sm_no;
	}	
}
