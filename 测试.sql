CREATE TABLE DEPT
(
DeptNo Number(4),
DeptName VARCHAR2(10 BYTE),
DeptIntro VARCHAR2(20 BYTE),
DeptLoc VARCHAR2(20 BYTE)
);
alter table DEPT add CONSTRAINT Dept_t  PRIMARY KEY (DeptNo);

CREATE TABLE STUDENT
(
Sno NUMBER(8),
Sname VARCHAR2(8 BYTE), 
Age NUMBER(2), 
Sex char,
Sdate DATE, 
Sheight NUMBER(3), 
DeptNo NUMBER(4),
CONSTRAINT Stno PRIMARY KEY(Sno),
CONSTRAINT DeNo FOREIGN KEY (DeptNo) REFERENCES DEPT(DeptNo) ON DELETE CASCADE,
CHECK((Sex='F' AND Age BETWEEN 15 AND 30)OR(Sex='M' AND Age BETWEEN 15 AND 30))
)

CREATE TABLE COURSE
(
CNo Number(4),
CName VARCHAR2(10 BYTE),
Ccent Number(4),
Ctea VARCHAR2(10 BYTE),
CONSTRAINT Ccourse PRIMARY KEY (CNo)
);

CREATE TABLE GRADE
(
Sno Number(4),
CNo Number(4),
Gra Number(4),
CONSTRAINT CGno PRIMARY KEY (Sno,CNo),
CONSTRAINT CGnooo FOREIGN KEY (Sno) REFERENCES STUDENT(Sno) ON DELETE CASCADE,
CONSTRAINT Cccccou FOREIGN KEY (CNo) REFERENCES COURSE(CNo) ON DELETE CASCADE
);

create sequence StuId
increment by 1
start with 1
maxvalue 9999
minvalue 1;

create sequence CouId
increment by 1
start with 1
maxvalue 9999
minvalue 1;


insert into DEPT(DeptNo,DeptName,DeptIntro,DeptLoc) values(1111,'jisuanji','jiaojisuanji','beijing');
insert into STUDENT( Sno, Sname, Age, Sex, Sdate, Sheight, DeptNo) values(StuId.nextval, 'yrs', 20, 'M', TO_DATE('2015-01-01','YYYY-MM-DD'),180,1111);
insert into Course(CNo,CName,Ccent,Ctea) values(CouId.nextval,'gaoshu',5,'hua');
insert into grade(Sno,CNo,Gra) values(StuId.currval,CouId.currval,100);

delete from STUDENT WHERE Sno=6;
delete from COURSE WHERE CNo=7;

select  * from student;
select * from dept;
select * from course;
select * from grade;







