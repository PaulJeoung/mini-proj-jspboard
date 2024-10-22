package vote;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import org.apache.catalina.valves.rewrite.InternalRewriteMap.Escape;

import common.DBConnectionMgr;

public class PollMgr {
	
	private DBConnectionMgr pool;
	private Connection conn = null;
	private PreparedStatement psmt = null;
	private ResultSet rs = null;
	private String sql = "";
	private boolean flag = false;
	
	public PollMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getMaxNum() {
		int maxNum = 0;
		System.out.println(getClass() + " :: getMaxNum() :: 조회 시작");
		
		try {
			conn = pool.getConnection();
			sql = "SELECT max(num) FROM sqlplus.poll_list";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if (rs.next()) {
				maxNum = rs.getInt(1);
				System.out.println(getClass() + " :: getMaxNum() :: 쿼리결과 ==> " + maxNum);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: getMaxNum() :: 조회 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: getMaxNum() :: 조회 완료");
		}
		return maxNum;
	}
	
	public boolean insertPoll(PollListBean plBean, PollItemBean piBean) {
	    System.out.println(getClass() + " :: insertPoll() :: 조회 시작");

	    try {
	    	String q = plBean.getQuestion();
	    	String sd = plBean.getSdate();
	    	String ed = plBean.getEdate();
	    	int tp = plBean.getType();
	    	System.out.println("                :::: data set check ==> {" + q + ", " + sd + ", " + ed + ", " + tp);
	    	String bogi[] = piBean.getItem();
	    	for (int b=0; b<bogi.length; b++) {
	    		System.out.println("                :::: 보기 data set check ==> {" + bogi[b]);
	    	}
	    	
	        conn = pool.getConnection();
	        sql = "INSERT sqlplus.poll_list (question, sdate, edate, wdate, type) VALUES (?, ?, ?, now(), ?)";
	        psmt = conn.prepareStatement(sql);
	        psmt.setString(1, plBean.getQuestion());
	        psmt.setString(2, plBean.getSdate());
	        psmt.setString(3, plBean.getEdate());
	        psmt.setInt(4, plBean.getType());
	        
	        // System.out.println(getClass() + " :: insertPoll() :: questionData ==> " + plBean.getQuestion());

	        int result = psmt.executeUpdate();

	        if (result == 1) {
	            System.out.println(getClass() + " :: insertPoll() :: poll_list insert 완료");
	            String item[] = piBean.getItem();
	            int itemnum = getMaxNum();
	            int j = 0;

	            for (int i = 0; i < item.length; i++) {
	                if (item[i] == null || item[i].equals("")) {
	                    System.out.println(getClass() + " :: insertPoll() :: 보기갯수 (" + (i - 1) + ")");
	                    break;
	                } else {
	                    // 각 아이템에 대해 새로운 PreparedStatement 생성
	                    sql = "INSERT sqlplus.poll_item (listnum, itemnum, item, count) VALUES (?, ?, ?, ?)";
	                    try (PreparedStatement itemPsmt = conn.prepareStatement(sql)) {
	                        itemPsmt.setInt(1, itemnum);
	                        itemPsmt.setInt(2, i);
	                        itemPsmt.setString(3, item[i]);
	                        itemPsmt.setInt(4, 0);
	                        j = itemPsmt.executeUpdate();
	                    } catch (SQLException e) {
							e.printStackTrace();
						}
	                }
	            }

	            System.out.println(getClass() + " :: insertPoll() :: poll_item insert 실행");
	            if (j > 0) {
	                flag = true;
	                System.out.println(getClass() + " :: insertPoll() :: poll_item insert 완료");
	            }
	        }
	        System.out.println(getClass() + " :: insertPoll() :: 쿼리결과 ==> " + flag + " (Flag result)");
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println(getClass() + " :: insertPoll() :: 조회 도중 Exception 발생");
	    } finally {
	        pool.freeConnection(conn, psmt, rs);
	        System.out.println(getClass() + " :: insertPoll() :: 조회 완료");
	    }
	    return flag;
	}

	
//	public boolean insertPoll(PollListBean plBean, PollItemBean piBean) {
//		
//		System.out.println(getClass() + " :: insertPoll() :: 조회 시작");
//		
//		try {
//			conn = pool.getConnection();
//			sql = "INSERT sqlplus.poll_list (question, sdate, edate, wdate, type) VALUES (?, ?, ?, now(), ?)";
//			psmt = conn.prepareStatement(sql);
//			psmt.setString(1, plBean.getQuestion());
//			psmt.setString(2, plBean.getSdate());
//			psmt.setString(3, plBean.getEdate());
//			psmt.setInt(4, plBean.getType());
//			
//			int result = psmt.executeUpdate();
//			
//			if(result == 1) {
//				System.out.println(getClass() + " :: insertPoll() :: poll_list insert 완료");
//				sql = "INSERT sqlplus.poll_item (listnum, itemnum, item, count) VALUES (?, ?, ?, ?)";
//				psmt = conn.prepareStatement(sql);
//				String item[] = piBean.getItem();
//				
//				int itemnum = getMaxNum();
//				int j = 0;
//				for (int i=0; i<item.length; i++) {
//					System.out.println("                   ::: data ==> " + itemnum + ", " + i + ", ");
//					if(item[i]==null || item[i].equals("")) {
//						System.out.println(getClass() + " :: insertPoll() :: 보기갯수 ("+(i-1)+")");
//						break;
//					} else {
//						psmt.setInt(1, itemnum);
//						psmt.setInt(2, i);
//						psmt.setString(3, item[i]);
//						psmt.setInt(4, 0);
//						System.out.println("                   ::: data ==> " + item[i]);
//						j = psmt.executeUpdate();
//						
//					}
//				}
//				
//				System.out.println(getClass() + " :: insertPoll() :: poll_item insert 실행");
//				if (j>0) {
//					flag = true;
//					System.out.println(getClass() + " :: insertPoll() :: poll_item insert 완료");
//				}
//			}
//			System.out.println(getClass() + " :: insertPoll() :: 쿼리결과 ==> " + flag + " (Flag result)");
//		} catch (Exception e) {
//			e.printStackTrace();
//			System.out.println(getClass() + " :: insertPoll() :: 조회 도중 Exception 발생");
//		} finally {
//			pool.freeConnection(conn, psmt, rs);
//			System.out.println(getClass() + " :: insertPoll() :: 조회 완료");
//		}
//		return flag;
//	}
	
	public Vector<PollListBean> getAllList() {
		Vector<PollListBean> vlist = new Vector<PollListBean>();
		System.out.println(getClass() + " :: getAllList() :: 조회 시작");
		
		try {
			conn = pool.getConnection();
			sql = "SELECT * FROM sqlplus.poll_list ORDER BY num DESC";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while (rs.next()) {
				PollListBean plBean = new PollListBean();
				plBean.setNum(rs.getInt("num"));
				plBean.setQuestion(rs.getString("question"));
				plBean.setSdate(rs.getString("sdate"));
				plBean.setEdate(rs.getString("edate"));
				vlist.add(plBean);
			}

			System.out.println(getClass() + " :: getAllList() :: 쿼리결과 ==> " + rs + " (true/false)");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: getAllList() :: 조회 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: getAllList() :: 조회 완료");
		}
		return vlist;
	}
	
	public PollListBean getList(int num) {
		
		PollListBean plBean = new PollListBean();
		System.out.println(getClass() + " :: getList() :: 조회 시작");
		
		try {
			conn = pool.getConnection();
			if (num==0) {
				sql = "SELECT * FROM sqlplus.poll_list ORDER BY num DESC";
			} else {
				sql = "SELECT * FROM sqlplus.poll_list WHERE num = " + num;
			}
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				plBean.setQuestion(rs.getString("question"));
				plBean.setType(rs.getInt("type"));
				plBean.setActive(rs.getInt("active"));
				// plBean.setNum(rs.getInt("num"));
				System.out.println(getClass() + " :: getList() :: NO. "+num);
			}
			
			System.out.println(getClass() + " :: getList() :: 쿼리결과 ==> " + rs + " (true/false)");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: getList() :: 조회 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: getList() :: 조회 완료");
		}
		return plBean;
	}
	
	public Vector<String> getItem(int num) {
		Vector<String> vlist = new Vector<String>();
		System.out.println(getClass() + " :: getItem() :: 조회 시작");
		
		try {
			conn = pool.getConnection();
			if (num==0) {
				num = getMaxNum();
			}
			sql = "SELECT item FROM sqlplus.poll_item WHERE listnum = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				vlist.add(rs.getString(1));
			}
			System.out.println(getClass() + " :: getItem() :: 쿼리결과 ==> " + rs + " (true/false)");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: getItem() :: 조회 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: getItem() :: 조회 완료");
		}
		return vlist;
	}
	
	public boolean updatePoll(int num, String[] itemnum) {
		
		System.out.println(getClass() + " :: updatePoll() :: 조회 시작");
		
		try {
			conn = pool.getConnection();
			sql = "UPDATE sqlplus.poll_item SET count = count+1 WHERE listnum = ? and itemnum = ?";
			psmt = conn.prepareStatement(sql);
			
			if (num==0) {
				num = getMaxNum();
			}
			for (int i=0; i<itemnum.length; i++) {
				if(itemnum[i]==null || itemnum[i].equals("")) {
					break;
				}
				psmt.setInt(1, num);
				psmt.setInt(2, Integer.parseInt(itemnum[i]));
				int j = psmt.executeUpdate();
				if(j>0) {
					flag = true;
				}
			}
			
			System.out.println(getClass() + " :: updatePoll() :: 쿼리결과 ==> " + flag + " (j`s Flag true/false)");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: updatePoll() :: 조회 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: updatePoll() :: 조회 완료");
		}
		return flag;
	}
	
	public Vector<PollItemBean> getView(int num) {
		
		Vector<PollItemBean> vlist = new Vector<PollItemBean>();
		System.out.println(getClass() + " :: getView() :: 조회 시작");
		
		try {
			conn = pool.getConnection();
			sql = "SELECT item, count FROM sqlplus.poll_item WHERE listnum = ?";
			psmt = conn.prepareStatement(sql);
			if (num == 0) {
				psmt.setInt(1, getMaxNum());
			} else {
				psmt.setInt(1, num);
			}
			rs = psmt.executeQuery();
			while(rs.next()) {
				PollItemBean piBean = new PollItemBean();
				String item[] = new String[1];
				item[0] = rs.getString(1);
				piBean.setItem(item);
				piBean.setCount(rs.getInt(2));
				vlist.add(piBean);
			}

			System.out.println(getClass() + " :: getView() :: 쿼리결과 ==> " + rs + " (true/false)");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: getView() :: 조회 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: getView() :: 조회 완료");
		}
		return vlist;
	}
	
	public int sumCount(int num) {
		int count = 0;
		System.out.println(getClass() + " :: sumCount() :: 조회 시작");
		
		try {
			conn = pool.getConnection();
			sql = "SELECT sum(count) FROM sqlplus.poll_item WHERE listnum = ?";
			psmt = conn.prepareStatement(sql);
			
			if (num==0) {
				psmt.setInt(1, getMaxNum());
			} else {
				psmt.setInt(1, num);
			}
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
			
			System.out.println(getClass() + " :: sumCount() :: 쿼리결과 ==> " + rs + " (true/false)");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(getClass() + " :: sumCount() :: 조회 도중 Exception 발생");
		} finally {
			pool.freeConnection(conn, psmt, rs);
			System.out.println(getClass() + " :: sumCount() :: 조회 완료");
		}
		return count;
	}
}
