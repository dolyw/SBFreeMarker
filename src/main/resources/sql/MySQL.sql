
create database sbfreemarker;

use sbfreemarker;

/*�û���*/
create table user (
id int primary key auto_increment COMMENT "ID",
account varchar(20)  COMMENT "�ʺ�",
password varchar(20) COMMENT "����",
username varchar(20) COMMENT "�ǳ�",
regtime datetime not null COMMENT "ע��ʱ��"
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT "�û���";

insert into user values(null,"admin","admin","admin",now());

