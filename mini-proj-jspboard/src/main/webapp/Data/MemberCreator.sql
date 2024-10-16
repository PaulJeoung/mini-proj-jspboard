CREATE TABLE sqlplus.member (
	id VARCHAR(20) PRIMARY KEY NOT NULL,
    pwd VARCHAR(20) NOT NULL,
    name VARCHAR(20) NOT NULL,
    gender CHAR(1) NOT NULL,
    email VARCHAR(30) NOT NULL,
    birthday VARCHAR(6) NOT NULL,
    zipcode CHAR(5) NOT NULL,
    address VARCHAR(50) NOT NULL,
    hobby VARCHAR(20) NOT NULL,
    job VARCHAR(20) NOT NULL
);

CREATE TABLE sqlplus.zipcode (
	zipcode CHAR(5) NOT NULL,
    area1 CHAR(10) DEFAULT NULL,
    area2 CHAR(20) DEFAULT NULL,
    area3 CHAR(30) DEFAULT NULL
);