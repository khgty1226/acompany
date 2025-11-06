package com.bteam.proj.common.util;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Base64;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bteam.proj.attach.service.AttachServiceImpl;
import com.bteam.proj.attach.vo.AttachVO;

//@Controller
@RestController
public class NextITImageLoader {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private AttachServiceImpl attachService;
	
	
	@RequestMapping(value = "/image/{atchNo:^[0-9]+$}", method = RequestMethod.GET)
	//@ResponseBody
	public byte[] getImageByteArray(@PathVariable("atchNo") int atchNo) 
			throws Exception {
		
		AttachVO attach;
		FileInputStream fis = null;
		byte[] byteData = null;
		
		try {
			attach = attachService.getAttach(atchNo);
			String filePath = attach.getAtchPath();
			String fileName = attach.getAtchFileName();
		 
			fis = new FileInputStream(filePath + File.separator + fileName);
			byteData = IOUtils.toByteArray(fis);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try {fis.close();}catch(IOException e) {e.printStackTrace();}
		}
		return byteData;
	}
	
}
