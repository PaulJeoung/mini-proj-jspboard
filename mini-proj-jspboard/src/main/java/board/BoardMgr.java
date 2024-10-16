package board;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import com.mysql.cj.util.Util;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.DBConnectionMgr;
import common.UtilMgr;

public class BoardMgr {
	
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER = "D:/lidia_J/eclipse-workspace/mini-proj-jspboard/src/main/webapp/FileStorage/";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 10 * 1024 * 1024; // 10MB LIMIT
	
	private Connection conn = null;
	private PreparedStatement psmt = null;
	private ResultSet rs = null;
	private String sql = "";
	private boolean flag = false;
	
	public BoardMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
			System.out.println("class board.BoardMgr :: DB Connection 인스턴스 생성");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("class board.BoardMgr :: DB Connection 인스턴스 생성 도중 Exception 발생");
		}
	}
	
	// List.jsp
	public Vector<BoardBean> getBoardList(String keyField, String keyWord, int start, int end) {
		System.out.println(getClass() + " :: getBoardList() :: 함수 시작");
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			conn = pool.getConnection();
			if(keyWord.equals("null")||keyWord.equals("")) {
				sql = "SELECT * FROM sqlplus.board1 ORDER BY ref DESC, pos LIMIT ?, ?";
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, start);
				psmt.setInt(2, end);
			} else {
				sql = "SELECT * FROM sqlplus.board1 WHERE " + keyField + " LIKE ? ";
				sql	+= "ORDER BY ref DESC, pos LIMIT ?, ? ";
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, "%"+keyWord+"%");
				psmt.setInt(2, start);
				psmt.setInt(3, end);
			}
			rs = psmt.executeQuery();
			System.out.println(getClass() + " :: getBoardList() :: 쿼리 실행 완료 resultSet");
			while (rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: getBoardList() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: getBoardList() :: vlist 리턴 후 쿼리 조회 종료");
		}
		return vlist;
	}
	
	// List.jsp
	public int getTotalCount(String keyField, String keyWord) {
		System.out.println(getClass() + " :: getTotalCount() :: 함수 시작");
		int totalCount = 0;
		try {
			conn = pool.getConnection();
			if(keyWord.equals("null")||keyWord.equals("")) {
				sql = "SELECT count(*) FROM sqlplus.board1";
			} else {
				sql = "SELECT count(*) FROM sqlplus.board1 WHERE " + keyField + " LIKE ? ";
				sql	+= "ORDER BY ref DESC, pos LIMIT ?, ? ";
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, "%"+keyWord+"%");
			}
			System.out.println(getClass() + " :: getTotalCount() :: " + sql);
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println(getClass() + " :: getTotalCount() :: 쿼리 실행 완료");
			while (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: getTotalCount() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: getTotalCount() :: totalCount 쿼리 조회 종료 후 리턴 ["+totalCount+"]");
		}
		return totalCount;
	}
	
	// Read.jsp
	public BoardBean getBoard(int num) {
		BoardBean bean = new BoardBean();
		System.out.println(getClass() + " :: getBoard() :: 함수 시작");
		try {
			conn = pool.getConnection();
			sql = "SELECT * FROM sqlplus.board1 WHERE num = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num);
			rs = psmt.executeQuery();
			if (rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setPass(rs.getString("pass"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				bean.setIp(rs.getString("ip"));
			}
			System.out.println(getClass() + " :: getBoard() :: 쿼리 실행 완료 [UPDATE]");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: getBoard() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: getBoard() :: num 리턴 후 쿼리 조회 종료 ==> " + num);
		}
		return bean;
	}
	
	
	// Read.jsp
	public void upCount(int num) {
		System.out.println(getClass() + " :: upCount() :: 함수 시작");
		try {
			conn = pool.getConnection();
			sql = "UPDATE sqlplus.board1 SET count=count+1 WHERE num = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num);
			psmt.executeUpdate();
			System.out.println(getClass() + " :: upCount() :: 쿼리 실행 완료 [UPDATE]");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: upCount() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: upCount() :: num 리턴 후 쿼리 조회 종료 ==> " + num);
		}
	}
	
	// Post.jsp -> insertServlet
	public void insertBoard(HttpServletRequest req) {
		System.out.println(getClass() + " :: insertBoard() :: 함수 시작");
		MultipartRequest mr = null;
		String filename = null;
		int filesize = 0;
		try {
			conn = pool.getConnection();
			sql = "SELECT max(num) FROM sqlplus.board1";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			int ref = 1;
			if(rs.next()) {
				ref = rs.getInt(1) + 1;
			}
			File file = new File(SAVEFOLDER);
			if (!file.exists()) {
				file.mkdirs();
			}
			mr = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
			if (mr.getFilesystemName("filename")!=null) {
				filename = mr.getFilesystemName("filename");
				filesize = (int) mr.getFile("filename").length();
			}
			String content = mr.getParameter("content");
			if (mr.getParameter("contentType").equalsIgnoreCase("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			sql = "INSERT sqlplus.board1 (name, content, subject, ref, pos, depth, regdate, pass, count, ip, filename, filesize)";
			sql += " VALUES(?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, mr.getParameter("name"));
			psmt.setString(2, content);
			psmt.setString(3, mr.getParameter("subject"));
			psmt.setInt(4, ref);
			psmt.setString(5, mr.getParameter("pass"));
			psmt.setString(6, mr.getParameter("ip"));
			psmt.setString(7, filename);
			psmt.setInt(8, filesize);
			psmt.executeUpdate();
			System.out.println(getClass() + " :: deleteBoard() :: 쿼리 실행 완료 [INSERT]");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: insertBoard() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: insertBoard() :: INSERT 쿼리 종료");
		}
	}
	
	// Delete.jsp
	public void deleteBoard(int num) {
		System.out.println(getClass() + " :: deleteBoard() :: 함수 시작");
		try {
//				conn = pool.getConnection();
//				sql = "UPDATE sqlplus.board1 SET count=count+1 WHERE num = ?";
//				psmt = conn.prepareStatement(sql);
//				psmt.setInt(1, num);
//				psmt.executeUpdate();
//				System.out.println(getClass() + " :: deleteBoard() :: 쿼리 실행 완료 [UPDATE]");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: deleteBoard() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: deleteBoard() :: num 리턴 후 쿼리 조회 종료 ==> " + num);
		}
	}
	
	// 나중에 지울 것
	public void strPrinter(String str) {
		System.out.println(getClass() + " :: method() :: 함수 시작");
		System.out.println(getClass() + " :: method() :: 쿼리 실행 완료 [UPDATE]");
		System.out.println(getClass() + " :: method() :: 쿼리 실행 중 Exception 발생");
		System.out.println(getClass() + " :: method() :: num 리턴 후 쿼리 조회 종료 ==> ");
	}
	
}





























