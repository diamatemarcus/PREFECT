package com.pcwk.ehr.book.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.PcwkLogger;

@Service
public class BookSearchServiceimpl implements BookSearchService, PcwkLogger {
	final String BASE_URL = "https://openapi.naver.com/v1/search/";
	final String SUFFIX   = ".json";
	
	final String CLIENT_ID = "xO7Db21YlNEHolsKmUCy";
	final String CLIENT_SECRET = "bxkSRpF0UQ";
	
	public BookSearchServiceimpl() {}

	@Override
	public String doBookSearch(DTO inVO) throws IOException {
		String responseBody = "";
		String book = BASE_URL+"book"+SUFFIX;

		String text = "";
		String apiURL = "";
		try {
			text = URLEncoder.encode(inVO.getSearchWord(), "UTF-8");

			String sort = "sim";// default 날짜, 정확도:sim

			String queryString = "?query="+text+"&display="+inVO.getPageSize()+"&start="+inVO.getPageNo()+"&sort="+sort;

			LOG.debug("book url: "+book);
			LOG.debug("queryString: " + queryString);

			switch (inVO.getSearchDiv()) {
			case "10":
				apiURL = book + queryString;
				break;
			}

			LOG.debug("apiURL:"+apiURL);

			Map<String, String> requestHeaders = new HashMap<String, String>();
			requestHeaders.put("X-Naver-Client-Id", CLIENT_ID);
			requestHeaders.put("X-Naver-Client-Secret", CLIENT_SECRET);

			responseBody = get(apiURL, requestHeaders);
			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ responseBody                      │\n" + responseBody);
			LOG.debug("└───────────────────────────────────┘");

		} catch (IOException e) {
			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ updateReadCnt                     │"+e.getMessage());
			LOG.debug("└───────────────────────────────────┘");
		}

		return responseBody;
	}

	private String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		String resultStr = "";
		try {
			con.setRequestMethod("GET");

			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			LOG.debug("│ responseCode                     │" + responseCode);

			if (responseCode == HttpURLConnection.HTTP_OK) {// 접속 성공
				resultStr = readBody(con.getInputStream());
			} else {// 접속 실패
				return readBody(con.getErrorStream());
			}

		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패!", e);
		} finally {
			con.disconnect();
		}
		return resultStr;
	}

	/**
	 * InputStream
	 * 
	 * @param body
	 * @return String(json)
	 */
	private String readBody(InputStream body) {
		String retStr = "";
		InputStreamReader streamReader = new InputStreamReader(body);

		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder sb = new StringBuilder(2000);

			String line = "";
			while ((line = lineReader.readLine()) != null) {
				sb.append(line);
			}

			retStr = sb.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패!", e);
		}

		return retStr;
	}

	/**
	 * naver접근 HttpURLConnection객체 생성
	 * 
	 * @param apiUrl
	 * @return HttpURLConnection
	 */
	private HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다.:" + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("연결 실패.:" + apiUrl, e);
		}
	}

}
