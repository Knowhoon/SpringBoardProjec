package com.knowhoon.util;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class ImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware  {
	
	@SuppressWarnings("unused")
	private ServletContext servletContext;

	public ImagePaginationRenderer() {

	}

	public void initVariables() {
//		firstPageLabel = " <a href=\"?pageIndex={1}\" class=\"paginationInfoText\" onclick=\"{0}({1});return false; \">처음</a> ";
//		previousPageLabel = " <a href=\"?pageIndex={1}\" class=\"paginationInfoText\"  onclick=\"{0}({1});return false; \">이전</a> ";
//		currentPageLabel = " <strong style=\"color: red; font-size: 18px;\">{0}</strong> ";
//		otherPageLabel = " <a href=\"?pageIndex={1}\" style=\"color: black; font-size: 18px;\" onclick=\"{0}({1});return false; \">{2}</a> ";
//		nextPageLabel = " <a href=\"?pageIndex={1}\" class=\"paginationInfoText\"  onclick=\"{0}({1});return false; \">다음</a> ";
//		lastPageLabel = " <a href=\"?pageIndex={1}\" class=\"paginationInfoText\" onclick=\"{0}({1});return false; \">끝</a> ";
		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">처음</a>&#160;"; 
		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">이전</a>&#160;";
		currentPageLabel = "<strong>{0}</strong>&#160;";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
		nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">다음</a>&#160;";
		lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">끝</a>&#160;";
		}

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
