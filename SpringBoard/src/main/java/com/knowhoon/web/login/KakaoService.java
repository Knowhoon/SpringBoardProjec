package com.knowhoon.web.login;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


@Service
public class KakaoService {
//		public String getAccessToken (String authorize_code) {
//            String access_Token = "";
//            String refresh_Token = "";
//            String reqURL = "https://kauth.kakao.com/oauth/token";
//
//            try {
//                URL url = new URL(reqURL);
//
//                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//
//                //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
//
//                conn.setRequestMethod("POST");
//                conn.setDoOutput(true);
//
//                //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
//                BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
//                StringBuilder sb = new StringBuilder();
//                sb.append("grant_type=authorization_code");
//                sb.append("&client_id=key");  //본인이 발급받은 key
//                sb.append("&redirect_uri=http://localhost:8080/web/kakaoLoginReturn");     // 본인이 설정해 놓은 경로
//                sb.append("&code=" + authorize_code);
//                bw.write(sb.toString());
//                bw.flush();
//
//                //    결과 코드가 200이라면 성공
//                int responseCode = conn.getResponseCode();
//                System.out.println("responseCode : " + responseCode);
//
//                //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
//                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//                String line = "";
//                String result = "";
//
//                while ((line = br.readLine()) != null) {
//                    result += line;
//                }
//                System.out.println("response body : " + result);
//
//                //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
//                JsonParser parser = new JsonParser();
//                JsonElement element = parser.parse(result);
//
//                access_Token = element.getAsJsonObject().get("access_token").getAsString();
//                refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
//
//                System.out.println("access_token : " + access_Token);
//                System.out.println("refresh_token : " + refresh_Token);
//
//                br.close();
//                bw.close();
//            } catch (IOException e) {
//                // TODO Auto-generated catch block
//                e.printStackTrace();
//            }
//
//            return access_Token;
//        }
//        public HashMap<String, Object> getUserInfo (String access_Token) {
//
//            //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
//            HashMap<String, Object> userInfo = new HashMap<>();
//            String reqURL = "https://kapi.kakao.com/v2/user/me";
//            try {
//                URL url = new URL(reqURL);
//                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//                conn.setRequestMethod("GET");
//
//                //    요청에 필요한 Header에 포함될 내용
//                conn.setRequestProperty("Authorization", "Bearer " + access_Token);
//
//                int responseCode = conn.getResponseCode();
//                System.out.println("responseCode : " + responseCode);
//
//                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//
//                String line = "";
//                String result = "";
//
//                while ((line = br.readLine()) != null) {
//                    result += line;
//                }
//                System.out.println("response body : " + result);
//
//                JsonParser parser = new JsonParser();
//                JsonElement element = parser.parse(result);
//
//                JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
//                JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
//
//                String nickname = properties.getAsJsonObject().get("nickname").getAsString();
//                String profile_image = properties.getAsJsonObject().get("thumbnail_image").getAsString();
//                String email = kakao_account.getAsJsonObject().get("email").getAsString();
//                userInfo.put("nickname", nickname);
//                userInfo.put("email", email);
//                userInfo.put("profile_image", profile_image);
//
//            } catch (IOException e) {
//                // TODO Auto-generated catch block
//                e.printStackTrace();
//            }
//
//            return userInfo;
//        }
	public JsonNode getKakaoAccessToken(String code) {
		 
        final String RequestUrl = "https://kauth.kakao.com/oauth/token"; // Host
        final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
 
        postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
        postParams.add(new BasicNameValuePair("client_id", "key")); // REST API KEY
        postParams.add(new BasicNameValuePair("redirect_uri", "http://localhost:8080/web/kakaoLoginReturn")); // 리다이렉트 URI
        postParams.add(new BasicNameValuePair("code", code)); // 로그인 과정중 얻은 code 값
 
        final HttpClient client = HttpClientBuilder.create().build();
        final HttpPost post = new HttpPost(RequestUrl);
 
        JsonNode returnNode = null;
 
        try {
            post.setEntity(new UrlEncodedFormEntity(postParams));
 
            final HttpResponse response = client.execute(post);
            final int responseCode = response.getStatusLine().getStatusCode();
 
            System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
            System.out.println("Post parameters : " + postParams);
            System.out.println("Response Code : " + responseCode);
 
            // JSON 형태 반환값 처리
            ObjectMapper mapper = new ObjectMapper();
 
            returnNode = mapper.readTree(response.getEntity().getContent());
 
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
        }
 
        return returnNode;
    }
	public static JsonNode getKakaoUserInfo(JsonNode accessToken) {
		 
        final String RequestUrl = "https://kapi.kakao.com/v2/user/me";
        final HttpClient client = HttpClientBuilder.create().build();
        final HttpPost post = new HttpPost(RequestUrl);
 
        // add header
        post.addHeader("Authorization", "Bearer " + accessToken);
 
        JsonNode returnNode = null;
 
        try {
            final HttpResponse response = client.execute(post);
            final int responseCode = response.getStatusLine().getStatusCode();
 
            System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
            System.out.println("Response Code : " + responseCode);
 
            // JSON 형태 반환값 처리
            ObjectMapper mapper = new ObjectMapper();
            returnNode = mapper.readTree(response.getEntity().getContent());
            System.out.println(returnNode);
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // clear resources
        }
 
        return returnNode;
    }

}


