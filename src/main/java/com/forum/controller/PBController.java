package com.forum.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.forum.dto.PBCriteria;
import com.forum.dto.PBDto;
import com.forum.dto.PBPageDTO;
import com.forum.dto.PBReply2DTO;
import com.forum.dto.PBReplyDTO;
import com.forum.service.PBReply2Service;
import com.forum.service.PBReplyService;
import com.forum.service.PBService;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@Slf4j
public class PBController {

	@Autowired
	private PBService pservice;

	@Autowired
	private PBReplyService preplyService;
	
	@Autowired
    private PBReply2Service rpreplyService;


	@RequestMapping("/picture_list_old")
	public String list(Model model) {
		log.info("@# list");

		ArrayList<PBDto> picture_list = pservice.picture_list();
		model.addAttribute("picture_list", picture_list);

		return "picture_list";
	}

	@RequestMapping("/picture_list")
	public String plist(HttpSession session, PBCriteria pcri, Model model) {
		log.info("@# plist");
		log.info("@# pcri===>" + pcri);

//		String empno = (String) session.getAttribute("empno");
//		EmpDto dto = empservice.getEmpByEmpno(empno);
//		model.addAttribute("dto", dto);

		model.addAttribute("picture_list", pservice.plist(pcri));
		int total = pservice.getTotalCount(pcri);
		model.addAttribute("pageMaker", new PBPageDTO(total, pcri));

		return "community/pictureboard";
	}

	@RequestMapping("/pwrite")
	public String pwrite(HttpSession session, @RequestParam HashMap<String, String> param,
			@RequestParam("uploadFile") MultipartFile uploadFile, Model model) {

//		String empno = (String) session.getAttribute("empno");
//		EmpDto dto = empservice.getEmpByEmpno(empno);
//		model.addAttribute("dto", dto);
		
//		log.info("empno~~~" + empno);
		
//		PBDto pbDto = new PBDto();
//		try {
//			pbDto.setPempno(Integer.parseInt(empno));
//		} catch(NumberFormatException e) {
//			pbDto.setPempno(0);
//		}
//		
//		pbDto.setPname(dto.getName());
//		
//		log.info("name~~~" + dto.getName());
		
		// 파일 업로드 처리
		String uploadPath = "D:\\dev\\upload";
		String filename = null;
		String savePath = null;

		if (!uploadFile.isEmpty()) {
			filename = uploadFile.getOriginalFilename();
			savePath = uploadPath + File.separator + filename;

			try {
				// 파일 저장
				File saveFile = new File(savePath);
				uploadFile.transferTo(saveFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		// 파일 정보 DB에 저장
		HashMap<String, String> fileData = new HashMap<>();
		fileData.put("pname", param.get("pname"));
		fileData.put("ptitle", param.get("ptitle"));
		fileData.put("pcontent", param.get("pcontent"));
		fileData.put("filename", filename);
		fileData.put("uploadpath", savePath);

		pservice.pwrite(fileData); // DB에 파일 정보 저장

		return "redirect:picture_list";
	}

	@RequestMapping("/picture_write_view")
	public String picture_write_view(HttpSession session, Model model) {
		String empno = (String) session.getAttribute("empno");
//		EmpDto dto = empservice.getEmpByEmpno(empno);
//		model.addAttribute("dto", dto);
//		
//		log.info("empno~~~" + empno);
//		
//		PBDto pbDto = new PBDto();
//		try {
//			pbDto.setPempno(Integer.parseInt(empno));
//		} catch(NumberFormatException e) {
//			pbDto.setPempno(0);
//		}
//		
//		pbDto.setPname(dto.getName());
//		
//		log.info("name~~~" + dto.getName());
		
		return "picture_write_view";
	}

	@RequestMapping("/picture_content_view")
	public String picture_content_view(HttpSession session, @RequestParam HashMap<String, String> param, Model model) {
		
		String empno = (String) session.getAttribute("empno");
//		EmpDto dto = empservice.getEmpByEmpno(empno);
//		model.addAttribute("dto", dto);
		
		log.info("empno~~~" + empno);
		
		PBDto pbDto = new PBDto();
		try {
			pbDto.setPempno(Integer.parseInt(empno));
		} catch(NumberFormatException e) {
			pbDto.setPempno(0);
		}
		
//		pbDto.setPname(dto.getName());
//		
//		log.info("name~~~" + dto.getName());
		
		log.info("pid~~~" + param.get("pid"));
		
		PBDto picturedto = pservice.pcontentView(param);
		model.addAttribute("pcontent_view", picturedto);
		model.addAttribute("pageMaker", param);

		log.info("pid~~~" + param.get("pid"));
		
		// 게시글의 id를 이용하여 댓글 목록을 가져옵니다.
		int pid = Integer.parseInt(param.get("pid").trim());
		model.addAttribute("prlist", preplyService.prlist(pid));

		// pid 값을 Model 객체에 추가
		model.addAttribute("pid", pid);

		pservice.pincreaseHit(param);

		return "picture_content_view";
	}

	@RequestMapping("/picture_modify")
	public String picture_modify(HttpSession session, @RequestParam HashMap<String, String> param, Model model) {
//		String empno = (String) session.getAttribute("empno");
//		EmpDto dto = empservice.getEmpByEmpno(empno);
//		model.addAttribute("dto", dto);
//		
//		log.info("empno~~~" + empno);
//		
//		PBDto pbDto = new PBDto();
//		try {
//			pbDto.setPempno(Integer.parseInt(empno));
//		} catch(NumberFormatException e) {
//			pbDto.setPempno(0);
//		}
		
		PBDto picturedto = pservice.pcontentView(param);
		model.addAttribute("pcontent_view", picturedto);
		model.addAttribute("pageMaker", param);

		pservice.pincreaseHit(param);

		return "picture_modify";
	}

	@RequestMapping("/pmodify")
	public String pmodify(@RequestParam HashMap<String, String> param, @ModelAttribute("pcri") PBCriteria pcri,
			@RequestParam("uploadFile") MultipartFile uploadFile, RedirectAttributes rttr) {
		String filename;
		String uploadPath = "D:\\dev\\upload";
		String savePath;

		if (!uploadFile.isEmpty()) { // 새로운 이미지 파일이 있을 경우
			filename = uploadFile.getOriginalFilename();
			savePath = uploadPath + File.separator + filename;

			try {
				// 파일 저장
				File saveFile = new File(savePath);
				uploadFile.transferTo(saveFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			// 기존 게시글 정보 가져오기
			PBDto picturedto = pservice.pcontentView(param);

			// 기존 파일 이름 가져오기
			filename = picturedto.getFilename();
			savePath = uploadPath + File.separator + filename;
		}

		// DB에 파일 정보 업데이트
		param.put("filename", filename);
		param.put("uploadpath", savePath);

		// 나머지 정보 업데이트
		param.put("pname", param.get("pname"));
		param.put("ptitle", param.get("ptitle"));
		param.put("pcontent", param.get("pcontent"));
//	    try {
//	        param.put("pname", new String(param.get("pname").getBytes("ISO-8859-1"), "UTF-8"));
//	        param.put("ptitle", new String(param.get("ptitle").getBytes("ISO-8859-1"), "UTF-8"));
//	        param.put("pcontent", new String(param.get("pcontent").getBytes("ISO-8859-1"), "UTF-8"));
//	    } catch (UnsupportedEncodingException e) {
//	        e.printStackTrace();
//	    }

		// pid 받아오기 위해 사용
		PBDto picturedto = pservice.pcontentView(param);

		pservice.pmodify(param);
		rttr.addAttribute("ppageNum", pcri.getPpageNum());
		rttr.addAttribute("pamount", pcri.getPamount());

		return "redirect:picture_content_view?ppageNum=" + pcri.getPpageNum() + "&pamount=" + pcri.getPamount()
				+ "&pid=" + picturedto.getPid() + " ";
	}

	@RequestMapping("/pdelete")
	public String pdelete(@RequestParam HashMap<String, String> param, @ModelAttribute("pcri") PBCriteria pcri,
			RedirectAttributes rttr) {
		pservice.pdelete(param);
		rttr.addAttribute("ppageNum", pcri.getPpageNum());
		rttr.addAttribute("pamount", pcri.getPamount());

		return "redirect:picture_list";
	}

	@GetMapping("/display2")
	public ResponseEntity<byte[]> displayFile(String fileName) throws IOException {
		File file = new File("D:/dev/upload/" + fileName);

		if (!file.exists() || !file.isFile()) {
			throw new FileNotFoundException("The file does not exist: " + file.getAbsolutePath());
		}

		// 이미지 크기 조정
		BufferedImage originalImage = ImageIO.read(file);
//		BufferedImage resizedImage = Thumbnails.of(originalImage).size(720, 540).asBufferedImage();
		BufferedImage resizedImage = Thumbnails.of(originalImage).size(720, 540).asBufferedImage();

		// 바이트 배열로 변환
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write(resizedImage, "png", baos);
		byte[] bytes = baos.toByteArray();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_PNG);

		return new ResponseEntity<>(bytes, headers, HttpStatus.OK);
	}

	@GetMapping("/prlist")
	public String prlist(@RequestParam("pid") int pid, Model model) {
		model.addAttribute("prlist", preplyService.prlist(pid)); // pid를 인자로 전달
		return "picture_content_view"; // 뷰 이름
	}

	@GetMapping("/prwrite")
	public String prwrite(@RequestParam("pid") int pid, Model model) {
		model.addAttribute("pid", pid);
		
		return "preply_write"; // 뷰 이름
	}

	@RequestMapping(value = "/prwrite", method = RequestMethod.POST)
	public String prwrite(@ModelAttribute PBReplyDTO dto, @ModelAttribute("pcri") PBCriteria pcri,
			RedirectAttributes rttr) {
		// 댓글 작성
		preplyService.prwrite(dto);

		// 댓글 목록 페이지로 리다이렉트
		return "redirect:picture_content_view?ppageNum=" + pcri.getPpageNum() + "&pamount=" + pcri.getPamount()
				+ "&pid=" + dto.getPid();
	}


	@RequestMapping("/prdelete")
	public String prelete(@ModelAttribute PBReplyDTO dto, @ModelAttribute("pcri") PBCriteria pcri,
			RedirectAttributes rttr) {
		preplyService.prdelete(dto);
		rttr.addAttribute("ppageNum", pcri.getPpageNum());
		rttr.addAttribute("pamount", pcri.getPamount());

		return "redirect:picture_content_view?ppageNum=" + pcri.getPpageNum() + "&pamount=" + pcri.getPamount()
				+ "&pid=" + dto.getPid();
	}
	
	 // 대댓글 목록
    @GetMapping("/rprlist")
    public String rprlist(@RequestParam("pid") int pid, @RequestParam("parentPrid") int parentPrid, Model model) {
        model.addAttribute("rprlist", rpreplyService.rprlist(pid, parentPrid)); // pid와 parentPrid를 인자로 전달
        return "picture_content_view"; // 뷰 이름
    }

    // 대댓글 작성
    @GetMapping("/rprwrite")
    public String rprwrite(@RequestParam("pid") int pid, @RequestParam("parentPrid") int parentPrid, Model model) {
        model.addAttribute("pid", pid);
        model.addAttribute("parentPrid", parentPrid);
        return "rpreply_write"; // 뷰 이름
    }

    @RequestMapping(value = "/rprwrite", method = RequestMethod.POST)
    public String rprwrite(@ModelAttribute PBReply2DTO dto, @ModelAttribute("pcri") PBCriteria pcri,
                           RedirectAttributes rttr) {
        // 대댓글 작성
        rpreplyService.rprwrite(dto);

        // 대댓글 목록 페이지로 리다이렉트
        return "redirect:picture_content_view?ppageNum=" + pcri.getPpageNum() + "&pamount=" + pcri.getPamount()
                + "&pid=" + dto.getPid();
    }

    // 대댓글 삭제
    @RequestMapping("/rprdelete")
    public String rprelete(@ModelAttribute PBReply2DTO dto, @ModelAttribute("pcri") PBCriteria pcri,
                           RedirectAttributes rttr) {
        rpreplyService.rprdelete(dto);
        rttr.addAttribute("ppageNum", pcri.getPpageNum());
        rttr.addAttribute("pamount", pcri.getPamount());

        return "redirect:picture_content_view?ppageNum=" + pcri.getPpageNum() + "&pamount=" + pcri.getPamount()
                + "&pid=" + dto.getPid();
    }
}
