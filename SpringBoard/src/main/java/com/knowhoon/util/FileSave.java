package com.knowhoon.util;
//파일 저장

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileSave {
	//Spring에서 제공하는 fileCopyUtil 이용 파일 저장
	public String save(String realPath, MultipartFile files) throws IOException {
		File file = new File(realPath);
		if(!file.exists()) {
			file.mkdirs();
		}
		//UUID 유니크
		String fileName = UUID.randomUUID().toString();
		fileName = fileName + "_" + files.getOriginalFilename();
		//System.out.println("만들어진 fileName : " + fileName);
		
		file = new File(file, fileName);
		FileCopyUtils.copy(files.getBytes(), file);
		
		return fileName;		
	}
	
	//multipart에서 제공하는 업로드로 저장
	public String save2(String realPath, MultipartFile files) throws IllegalStateException, IOException {
		File file = new File(realPath);
		if(!file.exists()) {
			file.mkdirs();
		}
		String fileName = UUID.randomUUID().toString();
		fileName += "_" + files.getOriginalFilename();
		
		file = new File(file, fileName);
		files.transferTo(file);	
		
		return fileName;		
	}
	
}
