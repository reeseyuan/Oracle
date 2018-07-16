数据库里新创建新一个用户， 赋予connect、resource权限，修改其用户配额
（选做：有兴趣的同学，可以学习一下创建表空间，为该用户分配该表空间）
用该用户登录，创建三个表

学生表（学号、姓名、年龄、性别、入学日期、身高,班级）
要求学号为主键 年龄 15-30 之间，性别'F'或'M',入学日期为 date类型

课程表（课程编号，课程名，学分，任课教师）等
课程编号为主键 

成绩表（学号、课程编号、成绩）
其中学号、课程编号为联合主键    学号为外键，关联学生表，课程号为外键，关联课程表。

用 insert 语句插入学生信息，学号自增。


日期类型的插入方法
INSERT INTO student(xxx,xxx,xxdate) VALUES(xxx,xx, to_date('2000-01-01','YYYY-MM-DD'));

用 insert 语句插入课程信息，课程号自增。

用insert 语句，为每名学生、每门课程的成绩插入成绩表
-- 学生表
CREATE TABLE TB_CLASS
(
  cno        NUMBER(8) NOT NULL,   --学生主键,学号
  cname     VARCHAR2(50),
  CONSTRAINT PK_TB_CLASS PRIMARY KEY (cno)    --主键约束
 );



CREATE TABLE TB_STUDENT
(
  Sno        NUMBER(8) NOT NULL,   --学生主键,学号
  Sname      VARCHAR2(50),      --学生姓名
  Sage       NUMBER(3),
  Ssex       CHAR,
  Sdate      DATE,
  Shigh      NUMBER(3), 
  Sclass     NUMBER(8), 
  CONSTRAINT PK_TB_STUDENT PRIMARY KEY (Sno),    --主键约束
  CONSTRAINT ck_student_age CHECK(Sage BETWEEN 15 AND 30),
  constraint ck_student_sex check(Ssex in ('M','F')),
  CONSTRAINT FK_TB_STUDENT_class FOREIGN KEY (Sclass) REFERENCES  TB_CLASS (CNO) ON DELETE CASCADE 
);





CREATE TABLE TB_COURSE
(
  Cno          NUMBER(3) NOT NULL,  
  Cname        VARCHAR2(50),     
  Cgrade       NUMBER(3),  
  Cteacher     VARCHAR2(50),
  CONSTRAINT PK_TB_COURCE PRIMARY KEY (Cno)    --主键约束
);


CREATE TABLE TB_SCORE
(
  Sno          NUMBER(8) NOT NULL,  
  Cno          NUMBER(8) NOT NULL,
  Score         NUMBER(3),
  CONSTRAINT PK_TB_SCORE_M PRIMARY KEY (Sno,Cno),    --主键约束
  CONSTRAINT FK_TB_SCORE_Sno FOREIGN KEY (Sno) REFERENCES TB_STUDENT (SNO) ON DELETE CASCADE,
  CONSTRAINT FK_TB_SCORE_Cno FOREIGN KEY (Cno) REFERENCES TB_COURSE (CNO) ON DELETE CASCADE
);
 
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1001,'刘铁',17,'F',to_date('2011-08-26','YYYY-MM-DD'),156,1);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1002,'王彦苏',17,'M',to_date('2011-08-26','YYYY-MM-DD'),166,1);

INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1003,'刘化峰',17,'F',to_date('2011-08-26','YYYY-MM-DD'),176,1);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1004,'王志会',17,'M',to_date('2011-08-26','YYYY-MM-DD'),187,1);

INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1005,'姜波',18,'F',to_date('2012-08-26','YYYY-MM-DD'),192,2);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1006,'王昕',18,'F',to_date('2012-08-26','YYYY-MM-DD'),165,2);

INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1007,'张雁冰',18,'F',to_date('2012-08-26','YYYY-MM-DD'),174,2);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1008,'孙成伟',19,'M',to_date('2012-08-26','YYYY-MM-DD'),155,2);

INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1009,'刘贤宇',19,'F',to_date('2012-08-26','YYYY-MM-DD'),186,2);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1010,'李月',18,'M',to_date('2012-08-26','YYYY-MM-DD'),174,2);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1011,'张丽',20,'F',to_date('2013-08-26','YYYY-MM-DD'),167,3);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh) VALUES(1012,'王涵 ',21,'M',to_date('2013-08-26','YYYY-MM-DD'),199);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh) VALUES(1013,'李忠臣',20,'F',to_date('2013-08-26','YYYY-MM-DD'),158);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh) VALUES(1014,'石晓国',21,'M',to_date('2013-08-26','YYYY-MM-DD'),167);

insert into TB_COURSE(cno,cname,cgrade,cteacher) values(1,'数学',4,'周洪波');
insert into TB_COURSE(cno,cname,cgrade,cteacher) values(2,'语文',3,'白玮');
insert into TB_COURSE(cno,cname,cgrade,cteacher) values(3,'英语',3,'宋维娜');

insert into TB_SCORE(sno,cno,score) values(1001,1,88);
insert into TB_SCORE(sno,cno,score) values(1001,2,45);
insert into TB_SCORE(sno,cno,score) values(1001,3,76);

insert into TB_SCORE(sno,cno,score) values(1002,1,73);
insert into TB_SCORE(sno,cno,score) values(1002,2,65);
insert into TB_SCORE(sno,cno,score) values(1002,3,86);

insert into TB_SCORE(sno,cno,score) values(1003,1,88);
insert into TB_SCORE(sno,cno,score) values(1003,2,65);
insert into TB_SCORE(sno,cno,score) values(1003,3,96);

insert into TB_SCORE(sno,cno,score) values(1004,1,68);
insert into TB_SCORE(sno,cno,score) values(1004,2,55);
insert into TB_SCORE(sno,cno,score) values(1004,3,96);

insert into TB_SCORE(sno,cno,score) values(1005,1,68);
insert into TB_SCORE(sno,cno,score) values(1005,2,75);
insert into TB_SCORE(sno,cno,score) values(1005,3,86);

insert into TB_SCORE(sno,cno,score) values(1006,1,84);
insert into TB_SCORE(sno,cno,score) values(1006,2,42);
insert into TB_SCORE(sno,cno,score) values(1006,3,56);

insert into TB_SCORE(sno,cno,score) values(1007,1,78);
insert into TB_SCORE(sno,cno,score) values(1007,3,76);

insert into TB_SCORE(sno,cno,score) values(1008,2,85);
insert into TB_SCORE(sno,cno,score) values(1008,3,66);

insert into TB_SCORE(sno,cno,score) values(1009,1,95);
insert into TB_SCORE(sno,cno,score) values(1009,3,76);
