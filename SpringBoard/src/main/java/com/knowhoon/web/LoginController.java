package com.knowhoon.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.knowhoon.util.Util;
import com.knowhoon.web.log.LogDTO;
import com.knowhoon.web.log.LogService;
import com.knowhoon.web.login.KakaoService;
import com.knowhoon.web.login.LoginDTO;
import com.knowhoon.web.login.LoginService;

@Controller
public class LoginController {
	@Autowired
	private LoginService loginService;
	@Autowired
	private LogService logService;
	@Autowired
	private Util util;
	 @Autowired
	private KakaoService kakaoService;


	@GetMapping("/login")
	public String login() {
		
		return "login";
	}
	//로그인
	@PostMapping("/login")
	public String loginAction(LoginDTO loginDTO, HttpServletRequest request) {
		String idCheck = checkID(request);
		if(idCheck.equals("1")) {
			//Salt값 가져오기
			String getSalt = loginService.getSalt(loginDTO.getSm_id());
			loginDTO.setSm_salt(getSalt);
			LoginDTO result = loginService.loginAction(loginDTO);
			
			if(result != null) {
				request.getSession().setAttribute("sm_id", result.getSm_id());
				request.getSession().setAttribute("sm_name", result.getSm_name());
				request.getSession().setAttribute("sm_grade", result.getSm_grade());
				String target = "login";
				LogDTO log = new LogDTO(
						util.getIP(request), 
						target , 
						(String)request.getSession().getAttribute("sm_id"), 
						target + "성공");
				logService.insertLog(log);	
				return "redirect:/home";			
			} else {
				if(request.getSession().getAttribute("sm_id") != null) {
					request.getSession().removeAttribute("sm_id");				
				}
				if(request.getSession().getAttribute("sm_name") != null) {
					request.getSession().removeAttribute("sm_name");							
				}
				if(request.getSession().getAttribute("sm_grade") != null) {
					request.getSession().removeAttribute("sm_grade");							
				}
				return "redirect:/login?error=loginError";
			}
		}else {
			return "redirect:/login?error=loginErrorId";
		}	
		
	}
	//카카오 로그인
	@RequestMapping("/kakaoLogin")
	public String kakaoLogin() throws Exception {
		String serviceKey = "5f932911fbf9bd32c027dd5421cedb62";
		String url = "https://kauth.kakao.com/oauth/authorize";
		String redirect_url = "http://localhost:8080/web/kakaoLoginReturn";
		StringBuffer loginUrl = new StringBuffer();
	        loginUrl.append(url);
	        loginUrl.append("?client_id=");
	        loginUrl.append(serviceKey); 
	        loginUrl.append("&redirect_uri=");
	        loginUrl.append(redirect_url); 
	        loginUrl.append("&response_type=code");
	        
	        return "redirect:"+loginUrl.toString();
	}
	//카카오 로그인 리턴
	@RequestMapping("/kakaoLoginReturn")
	public String kakao(@RequestParam String code, HttpSession session) throws Exception {
		String accessToken;
        JSONObject jsonToken = kakaoService.getKakaoAccessToken(code);
        accessToken = jsonToken.get("access_token").toString();
        
        JSONObject userInfo = KakaoService.getKakaoUserInfo(accessToken);
        JSONObject properties = (JSONObject) userInfo.get("properties");
        //JSONObject kakao_account = (JSONObject) userInfo.get("kakao_account");
        //유저 정보 가져오기
        String id = userInfo.get("id").toString();
        String name = properties.get("nickname").toString();
        //String email = kakao_account.get("email").toString();
        String userImg = properties.get("thumbnail_image").toString();
        //세션 등록 추후 회원가입 활용
        session.setAttribute("sm_id", id);
        session.setAttribute("sm_name", name);
        session.setAttribute("userImg", userImg);
        session.setAttribute("kakaoToken", accessToken);
        return "redirect:/home";
	}
	//로그 아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		String target = "logout";
		LogDTO log = new LogDTO(
				util.getIP(request), 
				target , 
				(String)request.getSession().getAttribute("sm_id"), 
				target + "성공");
		logService.insertLog(log);	
		if(request.getSession().getAttribute("kakaoToken") != null) {
			kakaoService.kakaoLogout(request.getSession().getAttribute("kakaoToken").toString());
			request.getSession().removeAttribute("kakaoToken");
		}		
		if(request.getSession().getAttribute("sm_id") != null) {
			request.getSession().removeAttribute("sm_id");
		}
		if(request.getSession().getAttribute("sm_name") != null) {
			request.getSession().removeAttribute("sm_name");							
		}
		if(request.getSession().getAttribute("sm_grade") != null) {
			request.getSession().removeAttribute("sm_grade");							
		}
		if(request.getSession().getAttribute("userImg") != null) {
			request.getSession().removeAttribute("userImg");							
		}
		return "redirect:/home";
	}
	@GetMapping("/join")
	public String join() {		
		return "join";
	}
	//회원 가입
	@PostMapping("/join")
	public String joinAction(HttpServletRequest request, LoginDTO loginDTO) {
		int result = 0;
		result = loginService.joinAction(loginDTO);		
		if(result == 1) {
			String target = "join";
			LogDTO log = new LogDTO(
					util.getIP(request), 
					target , 
					(String)request.getSession().getAttribute("sm_id"), 
					loginDTO.getSm_id()+" 회원가입 성공");
			logService.insertLog(log);	
			return "redirect:/home";			
		}else {
			return "redirect:/join?error=joinError";
		}
		
	}
	//아이디 중복 체크
	@PostMapping("/checkID")
	public @ResponseBody String checkID(HttpServletRequest request) {
		String check = "1";		
		check = loginService.checkID(request.getParameter("sm_id"));		
		return check;
	}
	//이메일 중복 체크
	@PostMapping("/checkEmail")
	public @ResponseBody String checkEmail(HttpServletRequest request) {
		String check = loginService.checkEmail(request.getParameter("sm_email"));		
		return check;
	}
	//이메일 인증번호 전송
	@PostMapping("/emailConfirm")
	public @ResponseBody String emailConfirm(HttpServletRequest request) {
		String authCode = util.getAuthCode(6);
		String email = request.getParameter("sm_email");
		String subject = "[본인인증] 회원가입 인증 이메일 입니다.";
		String content = 
		        "<h2>안녕하세요. 회원가입 인증 메일입니다. 방문해주셔서 감사합니다.</h2><br><br>"
		        +"인증 번호는 [ <b>" + authCode + "</b> ] 입니다." + 
		        "<br><br>" + 
		        "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		util.sendEmail(authCode, email , subject, content);
		return authCode;	
	}
}

