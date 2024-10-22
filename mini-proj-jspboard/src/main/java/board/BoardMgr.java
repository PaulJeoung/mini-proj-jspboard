package board;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

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
			System.out.println(getClass() + " :: insertBoard() :: 쿼리 실행 완료 [INSERT]");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: insertBoard() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: insertBoard() :: INSERT 쿼리 종료");
		}
	}
	
	// Download.jsp
		public void download(HttpServletRequest req, HttpServletResponse resp, JspWriter out, PageContext pageContext) {
			System.out.println(getClass() + " :: download() :: 함수 시작");
			try {
				String filename = req.getParameter("filename");
				File file = new File(UtilMgr.conn(SAVEFOLDER + File.separator + filename));
				byte b[] = new byte[(int) file.length()]; // 응답 객체 헤더필드에 바이트 단위로 설정
				
				resp.setHeader("Accept-Ranges", "bytes"); // 요청 객체에서 클라이언트의 정보를 리턴
				
				String strClient = req.getHeader("User-Agent"); // 브라우저 정보를 구분해 contentType, 헤더 필드 설정
				if (strClient.indexOf("MSIE6.0")!=-1) {
					resp.setContentType("application/smnet;charset=utf-8");
					resp.setHeader("Content-Disposition", "filename=" + filename + ";");
				} else {
					resp.setContentType("application/smnet;charset=utf-8");
					resp.setHeader("Content-Disposition", "attachment;filename=" + filename + ";");
				}
				System.out.println(getClass() + " :: download() :: 다운로드 정보 객체에 담기");
				out.clear();
				out = pageContext.pushBody(); // 파일 존재여부에 따라 스트링 방식으로 브라우저 파일 전송
				
				System.out.println(getClass() + " :: download() :: IOStream 을 통한 파일 다운로드 시작");
				if(file.isFile()) {
					BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
					BufferedOutputStream outs = new BufferedOutputStream(resp.getOutputStream());
					int read = 0;
					while ((read=fin.read(b))!=-1) {
						outs.write(b, 0, read);
					}
					outs.close();
					fin.close();
				}
				System.out.println(getClass() + " :: download() :: 다운로드 실행 완료 [DOWNLOAD]");
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println(getClass() + " :: download() :: 쿼리 실행 중 Exception 발생");
			} finally {
				pool.freeConnection(conn, psmt);
				System.out.println(getClass() + " :: download() :: 다운로드 쿼리 조회 종료 ==> ");
			}
		}
	
	// Delete.jsp
	public void deleteBoard(int num) {
		System.out.println(getClass() + " :: deleteBoard() :: 함수 시작");
		try {
			conn = pool.getConnection();
			
			sql = "SELECT filename FROM sqlplus.board1 WHERE num = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num);
			rs = psmt.executeQuery();
			System.out.println(getClass() + " :: deleteBoard() :: hasFile check query");
			
			if(rs.next( )&& rs.getString(1)!=null) {
				System.out.println("            :: filename query result ==> " +  rs.getString(1));
				if(!rs.getString(1).equals("")){
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if(file.exists()) {
						UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
					}
				}
				System.out.println(getClass() + " :: deleteBoard() :: class UtilMgr delete() logic complete");
			}
			
			sql = "DELETE FROM sqlplus.board1 WHERE num = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num);
			psmt.executeUpdate();
			System.out.println(getClass() + " :: deleteBoard() :: DELETE query complete");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: deleteBoard() :: occurs Exception during DELETE query");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: deleteBoard() :: DELETE query process finish, return value ==> " + num);
		}
	}
	
	// Update.jsp
	public void updateBoard(BoardBean bean) {
		System.out.println(getClass() + " :: updateBoard() :: 함수 시작");
		try {
			conn = pool.getConnection();
			sql = "UPDATE sqlplus.board1 SET name = ?, subject = ?, content = ? WHERE num = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, bean.getName());
			psmt.setString(2, bean.getSubject());
			psmt.setString(3, bean.getContent());
			psmt.setInt(4, bean.getNum());
			
			psmt.executeUpdate();
			System.out.println(getClass() + " :: updateBoard() :: 쿼리 실행 완료 [UPDATE]");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: updateBoard() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt);
			System.out.println(getClass() + " :: updateBoard() :: 업데이트 쿼리 조회 종료 ==> ");
		}
	}
	
	// Reply.jsp
	public void replyBoard(BoardBean bean) {
		System.out.println(getClass() + " :: replyBoard() :: 함수 시작");
		try {
			conn = pool.getConnection();
			sql = "INSERT sqlplus.board1 (name, content, subject, ref, pos, depth, regdate, pass, count, ip)";
			sql += " VALUES (?, ?, ?, ?, ?, ?, now(), ?, 0, ?)";
			int depth = bean.getDepth()+1;
			int pos = bean.getPos()+1;
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, bean.getName());
			psmt.setString(2, bean.getContent());
			psmt.setString(3, bean.getSubject());
			psmt.setInt(4, bean.getRef());
			psmt.setInt(5, pos);
			psmt.setInt(6, depth);
			psmt.setString(7, bean.getPass());
			psmt.setString(8, bean.getIp());
			
			psmt.executeUpdate();
			System.out.println(getClass() + " :: replyBoard() :: 쿼리 실행 완료 [UPDATE]");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: replyBoard() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt);
			System.out.println(getClass() + " :: replyBoard() :: 업데이트 쿼리 조회 종료 ==> ");
		}
	}
	
	// Reply.jsp
	public void replyUpBoard(int ref, int pos) {
		System.out.println(getClass() + " :: replyUpBoard() :: 함수 시작");
		try {
			conn = pool.getConnection();
			sql = "UPDATE sqlplus.board1 SET pos = pos+1 WHERE ref = ? and pos > ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1, ref);
			psmt.setInt(2, pos);
			
			psmt.executeUpdate();
			System.out.println(getClass() + " :: replyUpBoard() :: 쿼리 실행 완료 [UPDATE]");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: replyUpBoard() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt);
			System.out.println(getClass() + " :: replyUpBoard() :: 업데이트 쿼리 조회 종료 ==> ");
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





























