function voteInfo() {
    const question = document.forms["voteFrm"]["question"].value;
    const items = [];
    const itemInputs = document.querySelectorAll('input[name="item"]');
    
    itemInputs.forEach(input => {
        items.push(input.value);
    });

    const sdateY = document.forms["voteFrm"]["sdateY"].value;
    const sdateM = document.forms["voteFrm"]["sdateM"].value;
    const sdateD = document.forms["voteFrm"]["sdateD"].value;
    
    const edateY = document.forms["voteFrm"]["edateY"].value;
    const edateM = document.forms["voteFrm"]["edateM"].value;
    const edateD = document.forms["voteFrm"]["edateD"].value;
    
    const type = document.forms["voteFrm"]["type"].value;

    const alertMessage = `
        질문: ${question}
        보기: ${items.join(', ')}
        시작일: ${sdateY}-${sdateM}-${sdateD}
        종료일: ${edateY}-${edateM}-${edateD}
        복수 투표: ${type === "1" ? "허용" : "비허용"}
    `;
    
    alert(alertMessage);
    
    // 입력 체크 후 제출
    if (inputCheck()) {
        document.forms["voteFrm"].submit();
    }
}

function inputCheck() {
    const question = document.forms["voteFrm"]["question"].value;
    // const itemInputs = document.querySelectorAll('input[name="item"]');
    // const items = Array.from(itemInputs).map(input => input.value);
    
    if (question === "") {
        alert("질문을 입력해 주세요.");
        document.forms["voteFrm"]["question"].focus();
        return false;
    }
	/*
    if (items.some(item => item === "")) {
        alert("모든 보기를 입력해 주세요.");
        itemInputs[items.findIndex(item => item === "")].focus();
        return false;
    }
	*/

    const sdateY = document.forms["voteFrm"]["sdateY"].value;
    const sdateM = document.forms["voteFrm"]["sdateM"].value;
    const sdateD = document.forms["voteFrm"]["sdateD"].value;

    const edateY = document.forms["voteFrm"]["edateY"].value;
    const edateM = document.forms["voteFrm"]["edateM"].value;
    const edateD = document.forms["voteFrm"]["edateD"].value;

    if (sdateY === "" || sdateM === "" || sdateD === "") {
        alert("시작년월일을 입력해 주세요.");
        document.forms["voteFrm"]["sdateY"].focus();
        return false;
    }

    if (edateY === "" || edateM === "" || edateD === "") {
        alert("종료년월일을 입력해 주세요.");
        document.forms["voteFrm"]["edateY"].focus();
        return false;
    }

    return true; // 모든 체크가 통과되면 true 반환
}

function win_close() {
    self.close();
}
