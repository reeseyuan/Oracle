解锁用户 cmd

sqlplus  sys/密码 as sysdba
	alter user scott account unlock;
	exit;
登录
	sqlplus scott/tiger
修改用户配额：
sqlplus  sys/密码 as sysdba
alter user xxx quota unlimited on users;

创建表
CREATE TABLE  employee
   (	EMPNO NUMBER(4,0), 
	ENAME VARCHAR2(10 BYTE), 
	JOB VARCHAR2(9 BYTE), 
	MGR NUMBER(4,0), 
	HIREDATE DATE, 
	SAL NUMBER(7,2), 
	COMM NUMBER(7,2), 
	DEPTNO NUMBER(2,0)); 
查看表结构

desc employee;

INSERT INTO employee(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO) VALUES ('7935', 'test', 'clert
', '7902', TO_DATE('08-3月 -18', 'DD-MON-RR'), '1300', '10')

提交成功


复制表结构
CREATE TABLE employee
AS SELECT * FROM emp
WHERE empno IS NULL;
修改表结构
ALTER TABLE mployee ADD(age NUMBER(2));
ALTER TABLE employee DROP COLUMN age;
ALTER TABLE employee DROP (sex,email);

ALTER TABLE employee MODIFY job NUMBER(20);
修改表名
ALTER TABLE employee RENAME TO  empinfo;
删除表
DROP TABLE employee ;
恢复删除的表
FLASHBACK TABLE employee TO BEFORE DROP;

1.实体完整性约束 (primary key) 
无完整性约束的表
CREATE TABLE  worker
( wno number(2),
  name varchar(100),
  grade number(3),
  deptno number(2)
)
插入数据 
insert into worker( wno, name  , grade ,deptno) values(1,'sss',1,1);
insert into worker(  name  , grade ,deptno) values('sss',1,1);
发现数据可以重复插入，可以为空。
 
 在建表时创建完整性约束
CREATE TABLE  worker1
( wno number(2),
  name varchar(100),
  grade number(3),
  deptno number(2)，
CONSTRAINT pk_worker1  PRIMARY KEY (wno)

)
试着插入数据，
insert into worker1( wno, name  , grade ,deptno) values(1,'sss',1,1);
insert into worker1(  name  , grade ,deptno) values('sss',1,1);
报错
查看约束
SELECT constraint_name,constraint_type 
		FROM user_constraints
 		WHERE table_name= 'WORKER1'

创建自增序列

create sequence wokerid
increment by 1
start with 1
maxvalue 9999
minvalue 1;

清空worker1
delete from worker1;

用序列插入表
insert into worker1( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,1);
查看表数据
select * from worker1;

修改自增序列
 ALTER SEQUENCE wokerid
increment by 3
maxvalue 9
minvalue 1;
用序列插入表
insert into worker1( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,1);


已经建立的表增加完整性约束
alter table worker add CONSTRAINT pk_worker  PRIMARY KEY (wno)

2. 引用完整性约束 (foreign key)
	外码的值必须与另一关系中的主码的值匹配（或为空）
 在建表时创建完整性约束
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

插入数据 
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);

insert into worker3( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);
insert into worker3( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);
删除父表数据 

delete from dept where deptno=10;
关闭约束：
ALTER TABLE EMP		disable constraint FK_DEPTNO;
打开约束：
ALTER TABLE EMP		enable constraint FK_DEPTNO;
 

3.其他约束
CREATE TABLE  worker4
( wno number(2),
  name varchar(100),
  grade number(3),
  age number(4)，
  deptno number(2)，
CONSTRAINT pk_worker4  PRIMARY KEY (wno),
CONSTRAINT  ck_age CHECK(age BETWEEN 18 AND 65)
)
insert into worker4( wno, name  , grade ,age,deptno) values(wokerid.nextval ,'sss',1,20,10);
insert into worker4( wno, name  , grade ,age,deptno) values(wokerid.nextval ,'sss',1,10,10);


修改数据 
UPDATE : 修改一行或多行数据
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,10);
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,20);
insert into worker2( wno, name  , grade ,deptno) values(wokerid.nextval ,'sss',1,20);
select * from worker2;

update worker2 set name='ttt' where deptno=20

select * from worker2;
    

