/**
 * 
 */

function inputCheck(){
	if(document.replyFrm.name.value==""){
		alert("작성자를 입력해 주세요.");
		document.replyFrm.name.focus();
		return;
	}
	if(document.replyFrm.subject.value==""){
			alert("제목을 입력해 주세요.");
			document.replyFrm.subject.focus();
			return;
		}
	if(document.replyFrm.content.value==""){
				alert("내용을 입력해 주세요.");
				document.replyFrm.content.focus();
				return;
			}
	if(document.replyFrm.pass.value==""){
				alert("비밀번호를 입력해 주세요.");
				document.replyFrm.pass.focus();
				return;
	}
	document.replyFrm.submit();
}

function win_close(){
	self.close();
}