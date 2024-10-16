CREATE TABLE sqlplus.board1 (
	num INT(5) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(20),
    subject VARCHAR(50),
    content TEXT,
    pos SMALLINT(7) UNSIGNED,
    ref SMALLINT(7),
    depth SMALLINT(7) UNSIGNED,
    regdate DATE,
    pass VARCHAR(15),
    ip VARCHAR(15),
    count SMALLINT(7) UNSIGNED,
    filename VARCHAR(30),
    filesize INT(11)
);

--sample data
INSERT INTO sqlplus.board1 (name, subject, content, pass, ip, count) 
VALUES 
('김더미', '김더미가 썻어요', 'no content', '1111', '127.0.0.1', '0');