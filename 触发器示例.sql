�����û� cmd

sqlplus  sys/���� as sysdba
	alter user scott account unlock;
	exit;
��¼
	sqlplus scott/tiger
�޸��û���
sqlplus  sys/���� as sysdba
alter user xxx quota unlimited on users;

������
CREATE TABLE  employee
   (	EMPNO NUMBER(4,0), 
	ENAME VARCHAR2(10 BYTE), 
	JOB VARCHAR2(9 BYTE), 
	MGR NUMBER(4,0), 
	HIREDATE DATE, 
	SAL NUMBER(7,2), 
	COMM NUMBER(7,2), 
	DEPTNO NUMBER(2,0)); 
�鿴��ṹ

desc employee;

INSERT INTO employee(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO) VALUES ('7935', 'test', 'clert
', '7902', TO_DATE('08-3�� -18', 'DD-MON-RR'), '1300', '10')

�ύ�ɹ�


���Ʊ�ṹ
CREATE TABLE employee
AS SELECT * FROM emp
WHERE empno IS NULL;
�޸ı�ṹ
ALTER TABLE mployee ADD(age NUMBER(2));
ALTER TABLE employee DROP COLUMN age;
ALTER TABLE employee DROP (sex,email);

ALTER TABLE employee MODIFY job NUMBER(20);
�޸ı���
ALTER TABLE employee RENAME TO  empinfo;
ɾ����
DROP TABLE employee ;
�ָ�ɾ���ı�
FLASHBACK TABLE employee TO BEFORE DROP;

1.ʵ��������Լ�� (primary key) 
��������Լ���ı�
CREATE TABLE  worker
( wno number(2),
  name varchar(100),
  grade number(3),
  deptno number(2)
)
�������� 
insert into worker( wno, name  , grade ,deptno) values(1,'sss',1,1);
insert into worker(  name  , grade ,deptno) values('sss',1,1);
�������ݿ����ظ����룬����Ϊ�ա�
 
 �ڽ���ʱ����������Լ��
CREATE TABLE  worker1
( wno number(2),
  name varchar(100),
  grade number(3),
  deptno number(2)��
CONSTRAINT pk_worker1  PRIMARY KEY (wno)

)
���Ų������ݣ�
insert into worker1( wno, name  , grade ,deptno) values(1,'sss',1,1);
insert into worker1(  name  , grade ,deptno) values('sss',1,1);
����
�鿴Լ��
SELECT constraint_name,constraint_type 
		FROM user_constraints
 		WHERE table_name= 'WORKER1'

������������

create sequence wokerid
increment by 1
start with 1
maxvalue 9999
minvalue 1;

���worker1
delete from worker1;

�����в����
insert into worker1( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,1);
�鿴������
select * from worker1;

�޸���������
 ALTER SEQUENCE wokerid
increment by 3
maxvalue 9
minvalue 1;
�����в����
insert into worker1( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,1);


�Ѿ������ı�����������Լ��
alter table worker add CONSTRAINT pk_worker  PRIMARY KEY (wno)

2. ����������Լ�� (foreign key)
	�����ֵ��������һ��ϵ�е������ֵƥ�䣨��Ϊ�գ�
 �ڽ���ʱ����������Լ��
CREATE TABLE  worker2
( wno number(2),
  name varchar(100),
  grade number(3),
  deptno number(2),
CONSTRAINT pk_worker2  PRIMARY KEY (wno),
CONSTRAINT ref_deptno  FOREIGN KEY (deptno)  REFERENCES dept(deptno) s
)

CREATE TABLE  worker3
( wno number(2),
  name varchar(100),
  grade number(3),
  deptno number(2),
CONSTRAINT pk_worker3  PRIMARY KEY (wno),
CONSTRAINT ref_deptno3  FOREIGN KEY (deptno)REFERENCES dept(deptno) on  DELETE SET NULL
)

�������� 
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);

insert into worker3( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);
insert into worker3( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);
ɾ���������� 

delete from dept where deptno=10;
�ر�Լ����
ALTER TABLE EMP		disable constraint FK_DEPTNO;
��Լ����
ALTER TABLE EMP		enable constraint FK_DEPTNO;
 

3.����Լ��
CREATE TABLE  worker4
( wno number(2),
  name varchar(100),
  grade number(3),
  age number(4)��
  deptno number(2)��
CONSTRAINT pk_worker4  PRIMARY KEY (wno),
CONSTRAINT  ck_age CHECK(age BETWEEN 18 AND 65)
)
insert into worker4( wno, name  , grade ,age,deptno) values(wokerid.nextval ,'sss',1,20,10);
insert into worker4( wno, name  , grade ,age,deptno) values(wokerid.nextval ,'sss',1,10,10);


�޸����� 
UPDATE : �޸�һ�л��������
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,20);
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,20);
select * from worker2;

update worker2 set name='ttt' where deptno=20

select * from worker2;
    

