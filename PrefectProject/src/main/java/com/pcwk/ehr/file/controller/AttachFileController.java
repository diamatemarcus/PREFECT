package com.pcwk.ehr.file.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.file.domain.FileVO;
import com.pcwk.ehr.file.service.AttachFileService;

@Controller
@RequestMapping("file")
public class AttachFileController implements PcwkLogger {
	
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
	
	@GetMapping(value ="/doDelete.do",produces = "application/json;charset=UTF-8" )//@RequestMapping(value = "/doDelete.do",method = RequestMethod.GET)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public MessageVO doDelete(FileVO inVO) throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDelete                          │");
		LOG.debug("│ FileVO                            │"+inVO);
		LOG.debug("└───────────────────────────────────┘");		
		if(0 == inVO.getSeq() ) {
			LOG.debug("============================");
			LOG.debug("==nullPointerException===");
			LOG.debug("============================");
			MessageVO messageVO=new MessageVO(String.valueOf("3"), "순번을 선택 하세요.");
			return messageVO;
		} 
		
		
		int flag = attachFileService.doDelete(inVO);
		
		String   message = "";
		if(1==flag) {//삭제 성공
			message = inVO.getSeq()+"삭제 되었습니다.";	
		}else {
			message = inVO.getSeq()+"삭제 실패!";
		}
		
		MessageVO messageVO=new MessageVO(String.valueOf(flag), message);
		
		LOG.debug("│ messageVO                           │"+messageVO);
		return messageVO;
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
	public ResponseEntity<List<FileVO>> fileUploadAjax(
			@RequestParam("uuid") String uuid, // 클라이언트로부터 받은 UUID
	        @RequestParam("uploadFile") MultipartFile[] uploadFiles) {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ fileUploadAjax()                          │");
		LOG.debug("└───────────────────────────────────────────┘");
		
		List<FileVO>  list=new ArrayList<FileVO>();
		
		//SEQ
		int seq = 1;
		
		for(MultipartFile multipartFile   :uploadFiles) {
			
			LOG.debug("│ multipartFile                          │"+multipartFile);
			
			FileVO fileVO=new FileVO();
			//UUID설정
			fileVO.setUuid(uuid);
			
			//SEQ
			fileVO.setSeq(seq++);
					
			//원본파일명
			fileVO.setOrgFileName(multipartFile.getOriginalFilename());
			
			//확장자
			String ext = StringUtil.getExt(fileVO.getOrgFileName());
			fileVO.setExtension(ext);			
			
			//저장파일명 :getPK()+확장자
			//getPK(): yyyyMMdd+UUID
			fileVO.setSaveFileName(uuid+ fileVO.getSeq() +"."+ext);
			
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
		
		
		
		return ResponseEntity.ok(list);
	}
	
	/**
	 *  보드 수정 시, 파일 업로드 및 수정
	 * @param uuid
	 * @param uploadFiles
	 * @param session
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@PostMapping(value="/reUpload.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<FileVO>> reUpload(
	        @RequestParam("uuid") String uuid,
	        @RequestParam("uploadFile") MultipartFile[] uploadFiles, // 새로 업로드할 파일
	        HttpSession session) throws SQLException, IOException {

	    LOG.debug("┌───────────────────────────────────┐");
	    LOG.debug("│ reUpload                          │");
	    LOG.debug("└───────────────────────────────────┘");
	    
	    List<FileVO> list = new ArrayList<>();

	    for (MultipartFile multipartFile : uploadFiles) {
	        if (!multipartFile.isEmpty()) {
	            // 클라이언트로부터 받은 seq 값을 사용하지 않고, 대신 fileList에서 계산된 최대 seq + 1 값을 사용
	            // 파일 기본 정보 설정 (원본 파일명, 저장 파일명, 파일 크기, 확장자 등)
	            String originalFilename = multipartFile.getOriginalFilename();
	            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
	            String saveFileName = uuid + "_" + (list.size() + 1) + ext; // 저장 파일명 생성, 여기서 list.size() + 1이 새로운 seq 역할을 함

	            FileVO fileVO = new FileVO();
	            fileVO.setUuid(uuid);
	            fileVO.setSeq(list.size() + 1); // 새로운 seq 할당
	            fileVO.setOrgFileName(originalFilename);
	            fileVO.setSaveFileName(saveFileName);
	            fileVO.setFileSize(multipartFile.getSize());
	            fileVO.setExtension(ext);
	            fileVO.setSavePath(saveFilePath); // 파일 저장 경로 설정

	            // 파일 저장 로직 구현
	            String fullPath = saveFilePath + File.separator + saveFileName;
	            File saveFile = new File(fullPath);
	            multipartFile.transferTo(saveFile); // 파일 저장

	            // 파일 정보 리스트에 추가
	            list.add(fileVO);
	        }
	    }

	    // 새 파일 정보 데이터베이스에 저장
	    if (!list.isEmpty()) {
	        attachFileService.upFileSave(list); // 여러 파일 정보를 한 번에 데이터베이스에 저장
	    }

	    return ResponseEntity.ok(list);
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
