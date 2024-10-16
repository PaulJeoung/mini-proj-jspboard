package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import common.DBConnectionMgr;

public class BoardMgr {
	
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER = "D:/lidia_J/eclipse-workspace/mini-proj-jspboard/src/main/webapp/FileStorage/";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;
	
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
			flag = rs.next();
			System.out.println(getClass() + " :: getBoardList() :: 쿼리 실행 완료 resultSet ==> " + rs);
			while (rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("content"));
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
	
	public int getTotalCount(String keyField, String keyWord) {
		System.out.println(getClass() + " :: getTotalCount() :: 함수 시작");
		int totalCount = 0;
		try {
			conn = pool.getConnection();
			if(keyWord.equals("null")||keyWord.equals("")) {
				sql = "SELECT count(*) FROM sqlplus.board1";
				psmt = conn.prepareStatement(sql);
			} else {
				sql = "SELECT count(*) FROM sqlplus.board1 WHERE " + keyField + " LIKE ? ";
				sql	+= "ORDER BY ref DESC, pos LIMIT ?, ? ";
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, "%"+keyWord+"%");
			}
			System.out.println(sql);
			rs = psmt.executeQuery();
			flag = rs.next();
			System.out.println(getClass() + " :: getTotalCount() :: 쿼리 실행 완료 resultSet ==> " + rs);
			while (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: getTotalCount() :: 쿼리 실행 중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: getTotalCount() :: totalCount 리턴 후 쿼리 조회 종료 ==> " + totalCount);
		}
		return totalCount;
		
	}
	
}
