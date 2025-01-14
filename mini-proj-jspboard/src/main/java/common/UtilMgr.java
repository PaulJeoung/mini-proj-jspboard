package common;

import java.io.File;

public class UtilMgr {
	public static String replace(String str, String pattern, String replace) {
		int s = 0;
		int e = 0;
		StringBuffer result = new StringBuffer();
		
		while ((e=str.indexOf(pattern, s))>=0) {
			result.append(str.substring(s, e));
			result.append(replace);
			s = e + pattern.length();
		}
		result.append(str.substring(s));
		return result.toString();
	}
	
	public static void delete(String s) {
		File file = new File(s);
		if(file.isFile()) {
			file.delete();
		}
		System.out.println("class common.UtilMgr() :: delete() :: 파일 삭제 객체 생성 후 삭제");
	}
	
	public static String conn(String s) {
		String str = null;
		try {
			str = new String(s.getBytes("8859_1"), "ksc5601");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
}
