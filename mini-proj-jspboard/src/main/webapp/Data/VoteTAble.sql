use sqlplus;

CREATE TABLE poll_list (
	num SMALLINT(6) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	question VARCHAR(200) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
	sdate DATE DEFAULT NULL,
	edate DATE DEFAULT NULL,
	wdate DATE DEFAULT NULL,
	type SMALLINT(6) NOT NULL DEFAULT '1',
	active SMALLINT(6) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE poll_item (
    listnum SMALLINT(6) NOT NULL,
    itemnum SMALLINT(6) NOT NULL DEFAULT '0',
    item VARCHAR(50) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
    count SMALLINT(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

    
DROP TABLE poll_item;

DROP TABLE poll_list;

SELECT * FROM sqlplus.poll_item;

SELECT * FROM sqlplus.poll_list;