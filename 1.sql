CREATE TABLE  School_Dept
   (	
  SchNO NUMBER(4), 
	SchNAME VARCHAR2(10 BYTE), 
	Intro VARCHAR2(9 BYTE), 
	Location VARCHAR2(9 BYTE)
);
insert into School_Dept( SCHNO, SCHNAME  , INTRO ,LOCATION) values(1000 ,'COMPUTER','COMPUTER','BEIJING');
alter table School_Dept add CONSTRAINT pk_SchNO  PRIMARY KEY (SchNO);
CREATE TABLE  Stu
   (	
  Stu_ID NUMBER(4) CONSTRAINT Stupk PRIMARY KEY, 
	StuNAME VARCHAR2(10 BYTE), 
	Stuage NUMBER(2), 
	Stusex char,
	HIREDATE DATE, 
	Height NUMBER(5,2), 
	SchNO NUMBER(4),
  CONSTRAINT ref_SchNo  FOREIGN KEY (SchNO)  REFERENCES SCHOOL_DEPT(SchNO) ON DELETE CASCADE,
  CHECK((Stusex='F' AND Stuage BETWEEN 15 AND 30)  OR
                (Stusex='M' AND Stuage BETWEEN 15 AND 30 ))
); 
CREATE TABLE  COURSE
   (	
  COURSENO NUMBER(4) CONSTRAINT COUpk PRIMARY KEY, 
  COURSENAME VARCHAR2(10 BYTE), 
	COURSEGRADE NUMBER(1), 
	TEACHER VARCHAR2(10 BYTE)
);
CREATE TABLE  GRADE
   (	
  Stu_ID NUMBER(4),
  COURSENO NUMBER(4),
	GRADE NUMBER(2),
  CONSTRAINT pk  PRIMARY KEY (Stu_ID,COURSENO),
  CONSTRAINT ref_STUNo  FOREIGN KEY (Stu_ID)  REFERENCES Stu(Stu_ID) ON DELETE CASCADE,
  CONSTRAINT ref_COURSENo  FOREIGN KEY (COURSENO)  REFERENCES COURSE(COURSENO) ON DELETE CASCADE
);

create sequence wokerid
increment by 1
start with 1
maxvalue 9999
minvalue 1;

insert into COURSE( COURSENO, COURSENAME  , COURSEGRADE ,TEACHER) values(wokerid.nextval ,'COMPUTER',5,'MR.Liu');
insert into Stu( STU_ID, STUNAME  , STUAGE ,STUSEX,hiredate,height,schno) values(1000 ,'ZLJ',21,'M',TO_DATE('08-9�� -15', 'DD-MON-RR'),181.25,1000);
insert into GRADE(STU_ID,COURSENO,GRADE) VALUES(1000,2,90);
DELETE FROM STU WHERE STU_ID=1000;
DELETE FROM COURSE WHERE COURSENO=2; 
DROP TABLE STU ;
DROP TABLE SCHOOL_DEPT ;
DROP TABLE GRADE ;
DROP TABLE COURSE ;