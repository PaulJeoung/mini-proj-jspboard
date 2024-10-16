package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import common.DBConnectionMgr;

public class DBCheck {
    
    private static DBConnectionMgr pool;
    private static Connection conn = null;
    private static PreparedStatement psmt = null;
    private static ResultSet rs = null;
    private static String sql = "";

    public static void main(String[] args) {
        queryTest();
    }
    
    public static void queryTest() {
        System.out.println("쿼리 검색");
        try {
            pool = DBConnectionMgr.getInstance();
            conn = pool.getConnection();
            sql = "SELECT count(*) FROM sqlplus.board1";
            psmt = conn.prepareStatement(sql);
            rs = psmt.executeQuery();
            
            while (rs.next()) {
                // String data1 = rs.getString("name");
            	int data1 = rs.getInt(1);
                System.out.println(data1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (psmt != null) {
                try {
                    psmt.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                pool.freeConnection(conn, psmt, rs);
            }
        }
    }
}
