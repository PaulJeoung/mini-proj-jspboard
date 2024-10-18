package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import common.DBConnectionMgr;

public class MemberMgr {

	private DBConnectionMgr pool;
	private Connection conn = null;
	private PreparedStatement psmt = null;
	private ResultSet rs = null;
	private String sql = "";
	private boolean flag = false;
	private boolean idFlag = false;
	private boolean pwFlag = false;
	
	public MemberMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
			System.out.println("class member.MemberMgr :: DB Connection 인스턴스 생성");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("class member.MemberMgr :: DB Connection 인스턴스 생성 도중 Exception 발생");
		}
	}
	
	public boolean checkId(String id) {
		System.out.println(getClass() + " :: checkId() :: ID 중복검사 시작 ("+id+")");
		try {
			conn = pool.getConnection();
			sql = "SELECT id FROM sqlplus.member WHERE id =?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if (rs.next()) {
				flag = true;
				String resultId = rs.getString("id");
				System.out.println(getClass() + " :: checkId() :: Query Result (True, False) : " + flag);
			} else {
				flag = false;
				System.out.println(getClass() + " :: checkId() :: Query Result (True, False) : " + flag);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: checkId() :: ID 중복검사 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
		}
		return flag;
	}
	
	public Vector<ZipcodeBean> zipcodeRead(String area3) {
		System.out.println(getClass() + " :: zipcodeRead() :: 우편번호 조회 시작 ==> " + area3);
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		try {
			conn = pool.getConnection();
			sql = "SELECT * FROM sqlplus.zipcode WHERE area3 LIKE ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, "%"+area3+"%");
			rs = psmt.executeQuery();
			if (rs.next()) {
				System.out.println(getClass() + " :: zipcodeRead() :: 우편번호 조회 성공");
				while(rs.next()) {
					ZipcodeBean bean = new ZipcodeBean();
					bean.setZipcode(rs.getString(1));
					bean.setArea1(rs.getString(2));
					bean.setArea2(rs.getString(3));
					bean.setArea3(rs.getString(4));
					vlist.addElement(bean);
				}
			} else {
				System.out.println(getClass() + " :: zipcodeRead() :: DB 조회 결과 null");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, psmt, rs);
		}
		return vlist;
	}
	
	public boolean insertMember(MemberBean bean) {
		System.out.println(getClass() + " :: insertMember() :: 가입정보 추가 시작");
		try {
			conn = pool.getConnection();
			sql = "INSERT sqlplus.member (id,pwd,name,gender,birthday,email,zipcode,address,hobby,job)"
				 +" VALUES(?,?,?,?,?,?,?,?,?,?)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, bean.getId());
			psmt.setString(2, bean.getPwd());
			psmt.setString(3, bean.getName());
			psmt.setString(4, bean.getGender());
			psmt.setString(5, bean.getBirthday());
			psmt.setString(6, bean.getEmail());
			psmt.setString(7, bean.getZipcode());
			psmt.setString(8, bean.getAddress());
			String hobby[] = bean.getHobby();
			char hobbies[] = { '0', '0', '0', '0', '0' };
			String lists[] = { "인터넷", "여행", "게임", "영화", "운동" };
			for (int i=0; i<hobby.length; i++) {
				for (int j=0; j<lists.length; j++) {
					if (hobby[i].equals(lists[j]))
						hobbies[j]= '1'; 
				}
			}
			psmt.setString(9, new String(hobbies));
			psmt.setString(10, bean.getJob());
			if (psmt.executeUpdate() == 1)
				flag = true;
			System.out.println(getClass() + " :: insertMember() :: 가입정보 추가 성공 ==> resultFlag : " + flag);
		} catch (Exception e) {
			System.out.println(getClass() + " :: insertMember() :: 가입정보 추가 도중 Exception 발생");
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, psmt);
		}
		return flag;
	}
	
	public LoginResult loginMember(String id, String pwd) {
		boolean success = false;
	    boolean idValid = false;
	    boolean pwdValid = false;

		System.out.println(getClass() + " :: loginMember() :: 로그인정보 조회 시작");

		try {
			conn = pool.getConnection();
			sql = "SELECT id, pwd FROM sqlplus.member WHERE id = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				String resultId = rs.getString("id");
	            String resultPw = rs.getString("pwd");
	            System.out.println(id + ", " + resultId + " || " + pwd + ", " + resultPw);
	            idValid = true; // ID가 존재함
	            if (resultPw.equals(pwd)) {
	                success = true; // 로그인 성공
	                pwdValid = true; // 비밀번호도 일치
	            }
	        }
			
			System.out.println(getClass() + " :: loginMember() :: 로그인정보 조회 완료");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: loginMember() :: 로그인정보 조회 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt);
		}
		return new LoginResult(success, idValid, pwdValid);
	}
	
	public MemberBean getMember(String id) {
		System.out.println(getClass() + " :: getMember() :: 회원정보 검색 시작");
		MemberBean bean = null;
		try {
			conn = pool.getConnection();
			sql = "SELECT * FROM sqlplus.member WHERE id = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if (rs.next()) {
				bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setEmail(rs.getString("email"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				String hobbies[] = new String[5];
				String hobby = rs.getString("hobby");
				for (int i=0; i<hobbies.length; i++) {
					hobbies[i] = hobby.substring(i, i+1);
				}
				bean.setHobby(hobbies);
				bean.setJob(rs.getString("job"));
			}
			System.out.println(getClass() + " :: getMember() :: 회원정보 검색 완료 ==> resultFlag : " + flag);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: getMember() :: 회원정보 검색 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt);
		}
		return bean;
	}
	
	public boolean updateMember(MemberBean bean) {
		System.out.println(getClass() + " :: updateMember() :: 회원정보 검색시작");
		try {
			conn = pool.getConnection();
			String sql = "UPDATE sqlplus.member SET pwd=?, name=?, gender=?, birthday=?,"
					+ "email=?, zipcode=?, address=?, hobby=?, job=? where id = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, bean.getPwd());
			psmt.setString(2, bean.getName());
			psmt.setString(3, bean.getGender());
			psmt.setString(4, bean.getBirthday());
			psmt.setString(5, bean.getEmail());
			psmt.setString(6, bean.getZipcode());
			psmt.setString(7, bean.getAddress());
			char hobby[] = { '0', '0', '0', '0', '0' };
			if (bean.getHobby() != null) {
				String hobbys[] = bean.getHobby();
				String list[] = { "인터넷", "여행", "게임", "영화", "운동" };
				for (int i = 0; i < hobbys.length; i++) {
					for (int j = 0; j < list.length; j++)
						if (hobbys[i].equals(list[j]))
							hobby[j] = '1';
				}
			}
			psmt.setString(8, new String(hobby));
			psmt.setString(9, bean.getJob());
			psmt.setString(10, bean.getId());
			int count = psmt.executeUpdate();
			if (count > 0)
				flag = true;
			System.out.println(getClass() + " :: updateMember() :: 회원정보 업데이트 완료 ==> resultFlag : " + flag);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: updateMember() :: 회원정보 업데이트 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt);
		}
		return flag;
	}
}
