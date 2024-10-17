### JSPStudy의 JSP & Servlet 웹 프로그래밍 입문 + 활용
---
- Chapter13. 파일 업로드 [완료]
- Chapter14. 회원가입 및 로그인 [완료]
- Chapter15. 계층형 게시판 [진행중]
- Chapter16. 투표 프로그램
- Chapter17. 홈페이지 구축
- Chapter18. 모바일웹 회원가입 및 로그인
- Chapter19. 모바일웹 PhtoBlog

---
__workingday : 10d__


#### 동적웹사이트 적용방법 24.10.17 기준 ####

1. 이클립스에서 자바 Dynamic web project를 생성
2. mysql 에서 sqlplus 라는 db 생성 후 member, zipcode, board1 테이블을 생성
3. mini-proj-jspboard/src/main/webapp/Data 안에 있는 쿼리문들을 참고 하여 데이터 생성
4. view 화면인 jsp 들은 mini-proj-jspboard/src/main/webapp 과 같이 작성 or 복붙 or 알아서...
5. servlet, controller 들은 mini-proj-jspboard/src/main/java 과 같이 작성 or 복붙 or 알아서...
6. [index.jsp 를 실행 하면 동작됨](mini-proj-jspboard/src/main/webapp/Index.jsp)

**DB는 localhost에서 동작 되게 만들었습니다. db 관련 세팅은 mini-proj-jspboard/src/main/java/common/DBConnectionMgr.java 에서 진행 하면 됩니다**
**참고로 JSP study 뭐시기 이건 올드스쿨이라 책으로 보시면 오탈자도 많고 구조에 대한 설명도 X같아서 그대로 따라하기 쉽지 않습니다. 매번 욕하면서 리팩토링 하시면 됩니다. 왜 KDT 수업에 이딴책을 선정했는지 알수는 없지만, 2000년대 이렇게 공부한 분들 대단합니다**
