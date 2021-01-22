package com.sbs.example.jspCommunity.util;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Util {
	public static String getNowDateStr() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date time = new Date();
		return format.format(time);
	}

	// 폴더 삭제
	public static void deleteDir(String filePath) {
		File deleteFolder = new File(filePath);

		if (deleteFolder.exists()) {
			File[] deleteFolderList = deleteFolder.listFiles();

			for (int i = 0; i < deleteFolderList.length; i++) {
				if (deleteFolderList[i].isFile()) {
					deleteFolderList[i].delete();
				} else {
					deleteDir(deleteFolderList[i].getPath());
				}
				deleteFolderList[i].delete();
			}
			deleteFolder.delete();
		}
	}

	// 파일에 내용쓰기
	public static void writeFileContents(String filePath, int data) {
		writeFileContents(filePath, data + "");
	}

	public static void writeFile(String filePath, String data) {
		File file = new File(filePath);

		try {
			BufferedWriter writer = new BufferedWriter(new FileWriter(file));
			writer.write(data);
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 첫 문자 소문자화
	public static String lcfirst(String str) {
		String newStr = "";
		newStr += str.charAt(0);
		newStr = newStr.toLowerCase();

		return newStr + str.substring(1);
	}

	// 파일이 존재하는지
	public static boolean isFileExists(String filePath) {
		File f = new File(filePath);
		if (f.isFile()) {
			return true;
		}

		return false;
	}

	// 파일내용 읽어오기
	public static String getFileContents(String filePath) {
		String rs = null;
		try {
			// 바이트 단위로 파일읽기
			FileInputStream fileStream = null; // 파일 스트림

			fileStream = new FileInputStream(filePath);// 파일 스트림 생성
			// 버퍼 선언
			byte[] readBuffer = new byte[fileStream.available()];
			while (fileStream.read(readBuffer) != -1) {
			}

			rs = new String(readBuffer);

			fileStream.close(); // 스트림 닫기
		} catch (Exception e) {
			e.getStackTrace();
		}

		return rs;
	}

	// 파일 쓰기
	public static void writeFileContents(String filePath, String contents) {
		BufferedOutputStream bs = null;
		try {
			bs = new BufferedOutputStream(new FileOutputStream(filePath));
			bs.write(contents.getBytes()); // Byte형으로만 넣을 수 있음
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			try {
				bs.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 파일 복사하기 ( 특정 파일은 제외하고 복사 )
	public static void copy(String sourceFile, String copyFile, String... exceptFiles) {

		// 파일객체생성
		File source = new File(sourceFile);
		// 복사파일객체생성
		File copy = new File(copyFile);
		if (!copy.exists()) {
			if (!source.isDirectory()) {
				String path = copy.toString();
				String[] fileName = path.split("\\\\");
				path = path.replace(fileName[fileName.length - 1], "");
				File copyPath = new File(path);
				copyPath.mkdirs();
			} else {
				copy.mkdirs();
			}

		}

		if (source.isDirectory()) {

			File[] files = source.listFiles();
			
			List<File> filed = new ArrayList<>();
			
			for(int i = 0 ; i < files.length; i++) {
				boolean check = false;
				for(int j = 0 ; j < exceptFiles.length; j++) {
					if(files[i].getName().equals(exceptFiles[j])) {
						check = true;
					} 					
				}
				if(!check) {
					filed.add(files[i]);
				}
			}
			
			/* FilenameFilter 인터페이스 ( 리턴하기 때문에 걸러내기 어렵다. )
			files = source.listFiles(new FilenameFilter() {

				@Override
				public boolean accept(File dir, String name) {

					return name.equals("");
				}
			});
			*/
			for (File file : filed) {

				File temp = new File(copy + file.separator + file.getName());

				String test = temp.toString();
				if (file.isDirectory()) {

					copy(file.getPath(), temp.toString());

				} else {

					try {

						FileInputStream fis = new FileInputStream(file); // 읽을파일
						FileOutputStream fos = new FileOutputStream(temp); // 복사할파일

						int fileByte = 0;
						// fis.read()가 -1 이면 파일을 다 읽은것
						while ((fileByte = fis.read()) != -1) {
							fos.write(fileByte);
						}
						// 자원사용종료
						fis.close();
						fos.close();

					} catch (FileNotFoundException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}

			}

		} else {
			try {

				FileInputStream fis = new FileInputStream(source); // 읽을파일
				FileOutputStream fos = new FileOutputStream(copy); // 복사할파일

				int fileByte = 0;
				// fis.read()가 -1 이면 파일을 다 읽은것
				while ((fileByte = fis.read()) != -1) {
					fos.write(fileByte);
				}
				// 자원사용종료
				fis.close();
				fos.close();

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

	}

	public static void copy(String sourceFile, String copyFile) {

		// 파일객체생성
		File source = new File(sourceFile);
		// 복사파일객체생성
		File copy = new File(copyFile);
		if (!copy.exists()) {
			if (!source.isDirectory()) {
				String path = copy.toString();
				String[] fileName = path.split("\\\\");
				path = path.replace(fileName[fileName.length - 1], "");
				File copyPath = new File(path);
				copyPath.mkdirs();
			} else {
				copy.mkdirs();
			}

		}

		if (source.isDirectory()) {

			File[] files = source.listFiles();

			for (File file : files) {

				File temp = new File(copy + file.separator + file.getName());

				String test = temp.toString();
				if (file.isDirectory()) {

					copy(file.getPath(), temp.toString());

				} else {

					try {

						FileInputStream fis = new FileInputStream(file); // 읽을파일
						FileOutputStream fos = new FileOutputStream(temp); // 복사할파일

						int fileByte = 0;
						// fis.read()가 -1 이면 파일을 다 읽은것
						while ((fileByte = fis.read()) != -1) {
							fos.write(fileByte);
						}
						// 자원사용종료
						fis.close();
						fos.close();

					} catch (FileNotFoundException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}

			}

		} else {
			try {

				FileInputStream fis = new FileInputStream(source); // 읽을파일
				FileOutputStream fos = new FileOutputStream(copy); // 복사할파일

				int fileByte = 0;
				// fis.read()가 -1 이면 파일을 다 읽은것
				while ((fileByte = fis.read()) != -1) {
					fos.write(fileByte);
				}
				// 자원사용종료
				fis.close();
				fos.close();

			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

	}

	// 연결을 통해서 데이터 받아오기 (callApi)
	public static String callApi(String urlStr, String... args) {
		// URL 구성 시작
		StringBuilder queryString = new StringBuilder();

		for (String param : args) {
			if (queryString.length() == 0) {
				queryString.append("?");
			} else {
				queryString.append("&");
			}

			queryString.append(param);
		}

		urlStr += queryString.toString();
		// URL 구성 끝

		// 연결생성 시작
		HttpURLConnection con = null;

		try {
			URL url = new URL(urlStr);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setConnectTimeout(5000); // 최대통신시간 제한
			con.setReadTimeout(5000); // 최대데이터읽기시간 제한
		} catch (MalformedURLException e) {
			e.printStackTrace();
			return null;
		} catch (ProtocolException e) {
			e.printStackTrace();
			return null;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		// 연결생성 끝

		// 연결을 통해서 데이터 가져오기 시작
		StringBuffer content = null;
		try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
			String inputLine;
			content = new StringBuffer();
			while ((inputLine = in.readLine()) != null) {
				content.append(inputLine);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 연결을 통해서 데이터 가져오기 끝

		return content.toString();
	}

	// 연결을 통해 가져온 데이터를 Map으로 리턴
	public static Map<String, Object> callApiResponseToMap(String urlStr, String... args) {
		String jsonString = callApi(urlStr, args);

		ObjectMapper mapper = new ObjectMapper();

		try {
			return (Map<String, Object>) mapper.readValue(jsonString, Map.class);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		return null;
	}

	// 연결을 통해서 가져온 데이터를 입력한 클래스타입으로 리턴
	public static Object callApiResponseTo(Class cls, String urlStr, String... args) {
		String jsonString = callApi(urlStr, args);

		ObjectMapper mapper = new ObjectMapper();

		try {
			return mapper.readValue(jsonString, cls);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		return null;
	}

	// 객체를 json형태로 변환시켜 가져오기
	public static String getJsonText(Object obj) {
		ObjectMapper mapper = new ObjectMapper();
		String rs = "";
		try {
			rs = mapper.writeValueAsString(obj);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	// json파일에서 Map형태로 가져오기
	public static Map getJsonMapFromFile(InputStream is) {
		ObjectMapper mapper = new ObjectMapper();

		try {
			return mapper.readValue(is, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	// sendMail
	public static int sendMail(String smtpServerId, String smtpServerPw, String from, String fromName, String to, String title, String body) {
		Properties prop = System.getProperties();
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.port", "587");

		Authenticator auth = new MailAuth(smtpServerId, smtpServerPw);

		Session session = Session.getDefaultInstance(prop, auth);

		MimeMessage msg = new MimeMessage(session);

		try {
			msg.setSentDate(new Date());

			msg.setFrom(new InternetAddress(from, fromName));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
			msg.setSubject(title, "UTF-8");
			msg.setContent(body, "text/html; charset=UTF-8");

			Transport.send(msg);

		} catch (AddressException ae) {
			System.out.println("AddressException : " + ae.getMessage());
			return -1;
		} catch (MessagingException me) {
			System.out.println("MessagingException : " + me.getMessage());
			return -2;
		} catch (UnsupportedEncodingException e) {
			System.out.println("UnsupportedEncodingException : " + e.getMessage());
			return -3;
		}

		return 1;
	}

}
