package com.pcwk.ehr.file.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.file.domain.FileVO;
import com.pcwk.ehr.file.service.AttachFileService;

@Controller
@RequestMapping("file")
public class AttachFileController {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	AttachFileService attachFileService;
	
	final String FILE_PATH = "C:\\upload";
	final String IMG_PATH  = "C:\\JSPM_0907\\03_WEB\\0305_SPRING\\WORKSPACE\\sw18\\src\\main\\webapp\\resources\\upload";
	String yyyyMMPath = "";//년월을 포함하는 경로
	String saveFilePath = "";
	
	
	
	
	public AttachFileController() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ FileController                            │");
		LOG.debug("└───────────────────────────────────────────┘");
		
		//FILE_PATH 폴더 생성
		File normalFileRoot = new File(FILE_PATH);
		if(normalFileRoot.isDirectory()==false) {
			boolean isMakeDir =  normalFileRoot.mkdirs();
			LOG.debug("FILE_PATH isMakeDir:"+isMakeDir);
		}
		
		//ImagePath 폴터 생성
		File imageFileRoot =new File(IMG_PATH);
		if(imageFileRoot.isDirectory() ==false) {
			boolean isMakeDir = imageFileRoot.mkdirs();
			LOG.debug("ImagePath isMakeDir:"+isMakeDir);
		}
		
		
		//년도 : YYYY
		//월    : MM
		String yyyyStr = StringUtil.getCurrentDate("yyyy");
		String mmStr = StringUtil.getCurrentDate("MM");
		LOG.debug("yyyyStr:"+yyyyStr);
		LOG.debug("yyyyStr:"+mmStr);
		
		
		yyyyMMPath = File.separator + yyyyStr + File.separator+mmStr;
		LOG.debug("yyyyMMPath:"+yyyyMMPath);
		
		normalFileRoot = new File(FILE_PATH+yyyyMMPath);
		if(normalFileRoot.isDirectory()==false) {
			boolean isMakeDir =  normalFileRoot.mkdirs();
			LOG.debug("FILE_PATH isMakeDir:"+isMakeDir);
		}		
		
		imageFileRoot =new File(IMG_PATH+yyyyMMPath);
		if(imageFileRoot.isDirectory() ==false) {
			boolean isMakeDir = imageFileRoot.mkdirs();
			LOG.debug("ImagePath isMakeDir:"+isMakeDir);
		}		
		
		saveFilePath = FILE_PATH+yyyyMMPath;
	}

	
	@PostMapping(value="/download.do",produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> download(FileVO inVO){
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ download                                  │");
		LOG.debug("└───────────────────────────────────────────┘");
		LOG.debug("│ inVO                          │"+inVO);
		String filePath = inVO.getSavePath()+File.separator+inVO.getSaveFileName();
		LOG.debug("│ filePath                          │"+filePath);
		Resource  resource=new FileSystemResource(filePath);
		LOG.debug("│ resource                          │"+resource);
		
		//HttpHeader에 원본 파일명 설정
		HttpHeaders  headers=new HttpHeaders();
		
		try {
			headers.add("Content-Disposition", "attachment; filename="+new String(inVO.getOrgFileName().getBytes("UTF-8"),"ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	}
	
	@PostMapping(value="/fileUploadAjax.do",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<FileVO> fileUploadAjax(ModelAndView modelAndView, MultipartFile[] uploadFile)throws IllegalStateException,IOException {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ fileUploadAjax()                          │");
		LOG.debug("└───────────────────────────────────────────┘");
		
		LOG.debug("│ uploadFile                          │"+uploadFile);
		List<FileVO>  list=new ArrayList<FileVO>();
		
		//UUID
		String UUID = StringUtil.getPK();
		//SEQ
		int    seq  = 1;
		
		for(MultipartFile multipartFile   :uploadFile) {
			FileVO fileVO=new FileVO();
			
			LOG.debug("│ multipartFile                          │"+multipartFile);
			
			//UUID설정
			fileVO.setUuid(UUID);
			
			//SEQ
			fileVO.setSeq(seq++);
			
			//원본파일명
			fileVO.setOrgFileName(multipartFile.getOriginalFilename());
			
			//확장자
			String ext = StringUtil.getExt(fileVO.getOrgFileName());
			fileVO.setExtension(ext);			
			
			//저장파일명 :getPK()+확장자
			//getPK(): yyyyMMdd+UUID
			fileVO.setSaveFileName(StringUtil.getPK()+"."+ext);
			
			//파일크기:byte
			fileVO.setFileSize(multipartFile.getSize());

			//저장경로 : 
			String contentType = multipartFile.getContentType();
			String savePath    = "";
			
			if(contentType.startsWith("image")==true) {//image파일
				savePath = IMG_PATH + yyyyMMPath;
			}else {
				savePath = FILE_PATH+ yyyyMMPath;
			}
			fileVO.setSavePath(savePath);
			
			//------------------------------------------------------------------
			//TO DO: Session에서 사용자 ID가져올것
			//------------------------------------------------------------------
			fileVO.setRegId("Admin");
			
			try {
				//fileUpload
				multipartFile.transferTo(new File(fileVO.getSavePath(),fileVO.getSaveFileName()));
			}catch(Exception e) {
				LOG.debug("│ Exception   │"+e.getMessage());
			}
			LOG.debug("│ fileVO   │"+fileVO);
			list.add(fileVO);
		}//--for end
		
		int countFile = 0;
		try {
			countFile = attachFileService.upFileSave(list);
			LOG.debug("│ countFile   │"+countFile);
		} catch (SQLException e) {
			LOG.debug("====================");
			LOG.debug("=upFileSave SQLException=" + e.getMessage());
			LOG.debug("====================");				
		}
		
		
		
		return list;
	}
	

	@RequestMapping(value="/fileUpload.do",method = RequestMethod.POST)
	public ModelAndView fileUpload(ModelAndView modelAndView, MultipartHttpServletRequest mHttp)throws IllegalStateException,IOException {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ fileUpload()                              │");
		LOG.debug("└───────────────────────────────────────────┘");
		
		String title = StringUtil.nvl(mHttp.getParameter("title"));
		LOG.debug("│ title                              │"+title);
		
		List<FileVO>  list=new ArrayList<FileVO>();
		//html input type="file"인 경우 변수 읽기
		Iterator<String>  fileNames =  mHttp.getFileNames();
		
		//UUID
		String UUID = StringUtil.getPK();
		//SEQ
		int    seq  = 1;
		while(fileNames.hasNext()) {
			FileVO fileVO=new FileVO();
			String uploadFileName = fileNames.next();
			LOG.debug("│ uploadFileName   │"+uploadFileName);
			
			
			MultipartFile  multipartFile  = mHttp.getFile(uploadFileName);
			
			//파일이 없는 경우 처리 
			if(multipartFile.isEmpty()==true) {
				LOG.debug("│ multipartFile.isEmpty()   │"+multipartFile.isEmpty());
				continue;
			}
			
			//UUID설정
			fileVO.setUuid(UUID);
			
			//SEQ
			fileVO.setSeq(seq++);
			
			//원본파일명
			String orgFileName = multipartFile.getOriginalFilename();
			LOG.debug("│ orgFileName   │"+orgFileName);
			
			//원본파일명
			fileVO.setOrgFileName(orgFileName);
			
			//확장자
			String ext = StringUtil.getExt(fileVO.getOrgFileName());
			fileVO.setExtension(ext);
			
			
			//저장파일명 :getPK()+확장자
			//getPK(): yyyyMMdd+UUID
			fileVO.setSaveFileName(StringUtil.getPK()+"."+ext);
			
			//파일크기:byte
			fileVO.setFileSize(multipartFile.getSize());

			//저장경로 : 
			String contentType = multipartFile.getContentType();
			String savePath    = "";
			
			if(contentType.startsWith("image")==true) {//image파일
				savePath = IMG_PATH + yyyyMMPath;
			}else {
				savePath = FILE_PATH+ yyyyMMPath;
			}
			
			LOG.debug("│ savePath   │"+savePath);
			LOG.debug("│ contentType   │"+contentType);
			fileVO.setSavePath(savePath);
			
			//------------------------------------------------------------------
			//TO DO: Session에서 사용자 ID가져올것
			//------------------------------------------------------------------
			fileVO.setRegId("Admin");

			
			LOG.debug("│ fileVO   │"+fileVO);
			try {
				//fileUpload
				multipartFile.transferTo(new File(fileVO.getSavePath(),fileVO.getSaveFileName()));
			}catch(Exception e) {
				LOG.debug("│ Exception   │"+e.getMessage());
			}
			
			list.add(fileVO);			
		}//--while end
		
		int countFile = 0;
		try {
			countFile = attachFileService.upFileSave(list);
		} catch (SQLException e) {
			LOG.debug("====================");
			LOG.debug("=upFileSave SQLException=" + e.getMessage());
			LOG.debug("====================");				
		}
		
		modelAndView.addObject("countFile", countFile);
		modelAndView.addObject("list", list);
		modelAndView.setViewName("file/fileUpload");
		return modelAndView;
	}
	
	@RequestMapping(value = "/dragNDropView.do")
	public ModelAndView dragNDropView(ModelAndView  modelAndView) {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ dragNDropView()                           │");
		LOG.debug("└───────────────────────────────────────────┘");
		
		modelAndView.setViewName("file/dragNDrop");
		return modelAndView;
	}
	
	
	@RequestMapping(value = "/uploadView.do")
	public ModelAndView uploadView(ModelAndView  modelAndView) {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ uploadView()                              │");
		LOG.debug("└───────────────────────────────────────────┘");
		
		modelAndView.setViewName("file/fileUpload");
		return modelAndView;
	}
	
	@RequestMapping(value = "/dragAndDropView.do")
	public ModelAndView dragAndDropView(ModelAndView  modelAndView) {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ uploadView()                              │");
		LOG.debug("└───────────────────────────────────────────┘");
		
		modelAndView.setViewName("file/dragAndDrop");
		return modelAndView;
	}
	
}
