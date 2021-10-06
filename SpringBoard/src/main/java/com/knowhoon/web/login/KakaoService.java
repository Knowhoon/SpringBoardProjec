package com.knowhoon.web.login;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.knowhoon.util.HttpURLConnUtil;


@Service
public class KakaoService {
	final String key = "5f932911fbf9bd32c027dd5421cedb62";
	 
	public JSONObject getKakaoAccessToken(String code) throws Exception {
		 
        final String RequestUrl = "https://kauth.kakao.com/oauth/token"; // Host
        final String redirectURL = "http://localhost:8080/web/kakaoLoginReturn";
               
        Map<String, String> params = new HashMap<String, String>();
        params.put("client_id", key);
        params.put("grant_type", "authorization_code");
        params.put("redirect_uri", redirectURL);
        params.put("code", code);
       
        JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser.parse(HttpURLConnUtil.doPostRequest(RequestUrl, null, params));

        return jsonObject;
    }
	public static JSONObject getKakaoUserInfo(String accessToken) throws Exception {
		 
        final String RequestUrl = "https://kapi.kakao.com/v2/user/me";
        
        Map<String, String> properties = new HashMap<String, String>();
        
        JSONParser parser = new JSONParser();
        properties.put("Authorization", "Bearer " + accessToken);
		JSONObject jsonObject = (JSONObject) parser.parse(HttpURLConnUtil.doPostRequest(RequestUrl, properties, null));
 
        return jsonObject;
    }
	public void kakaoLogout(String accessToken) {
		final String RequestUrl = "https://kapi.kakao.com//v1/user/logout";
		Map<String, String> properties = new HashMap<String, String>();
		properties.put("Authorization", "Bearer " + accessToken);
		HttpURLConnUtil.doPostRequest(RequestUrl, properties, null);
		
	}

}


