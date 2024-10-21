<%@page import="javax.naming.directory.SearchControls"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.ZipcodeBean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<%
    request.setCharacterEncoding("UTF-8");
    String check = request.getParameter("search");
    String area3 = null;
    Vector<ZipcodeBean> vlist = null;
    if (check != null && check.equals("y")) {
        area3 = request.getParameter("area3");
        vlist = mMgr.zipcodeRead(area3);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>우편번호 검색</title>
    <script type="text/javascript">
        function loadSearch() {
            const frm = document.zipFrm;
            if (frm.area3.value == "") {
                alert("도로명을 입력하세요");
                frm.area3.focus();
                return;
            }
            frm.action = "ZipSearch.jsp";
            frm.submit();
        }
        function sendAddress(zipcode, address) {
            opener.document.regFrm.zipcode.value = zipcode;
            opener.document.regFrm.address.value = address;
            self.close();
        }
    </script>
    <style>
        body {
            background-color: #f9f9f9;
            color: #333;
            font-family: 'Arial', sans-serif;
            padding: 20px;
        }
        table {
            width: 60%;
            margin: auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f1f1f1;
            color: #333;
        }
        input[type="button"] {
            background-color: #0056b3;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }
        input[type="button"]:hover {
            background-color: #004494;
        }
        a {
            color: #0056b3;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div align="center">
        <form name="zipFrm" method="post">
            <table>
                <tr>
                    <td><br/>도로명 입력: <input name="area3" placeholder="도로명을 입력하세요"></td>
                    <td><input type="button" value="검색" onclick="loadSearch();"></td>
                </tr>
                <%
                    if (check != null && check.equals("y")) {
                        if (vlist.isEmpty()) {
                %>
                <tr>
                    <td align="center"><br/>검색된 결과가 없습니다.</td>
                </tr>
                <%
                        } else {
                %>
                <tr>
                    <td align="center"><br/>검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</td>
                </tr>
                <%
                        for (int i = 0; i < vlist.size(); i++) {
                            ZipcodeBean bean = vlist.get(i);
                            String rZipcode = bean.getZipcode();
                            String rArea1 = bean.getArea1();
                            String rArea2 = bean.getArea2();
                            String rArea3 = bean.getArea3();
                            String address = rArea1 + " " + rArea2 + " " + rArea3 + " ";
                %>
                <tr>
                    <td>
                        <a href="#" onclick="sendAddress('<%=rZipcode %>', '<%=address %>')"><%=rZipcode %> <%=address %></a>
                    </td>
                </tr>
                <%
                        } // for
                        } // if
                    } // if
                %>
                <tr>
                    <td align="center"><br/>
                        <a href="#" onClick="self.close()">닫기</a>
                    </td>
                </tr>
                <input type="hidden" name="search" value="y">
            </table>
        </form>
    </div>
</body>
</html>
