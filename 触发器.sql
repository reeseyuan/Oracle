触发器的定义就是说某个条件成立的时候，触发器里面所定义的语句就会被自动的执行。因此触发器不需要人为的去调用，也不能调用。触发器的触发条件是在定义的时候就已经设定的。

create [or replace] trigger 触发器名 触发时间 触发事件
on 表名
[for each row]
begin
 pl/sql语句
end

触发器名：触发器对象的名称。由于触发器是数据库自动执行的，因此该名称只是一个名称，没有实质的用途。
触发时间：指明触发器何时执行，该值可取：
before：表示在数据库动作之前触发器执行;
after：表示在数据库动作之后触发器执行。
触发事件：指明哪些数据库动作会触发此触发器：
insert：数据库插入会触发此触发器;
update：数据库修改会触发此触发器;
delete：数据库删除会触发此触发器。
表 名：数据库触发器所在的表。
for each row：对表的每一行触发器执行一次。如果没有这一选项，则只对整个表执行一次。

触发器能实现如下功能：

功能：

1、 允许/限制对表的修改
2、 自动生成派生列，比如自增字段
3、 强制数据一致性
4、 提供审计和日志记录
5、 防止无效的事务处理
6、 启用复杂的业务逻辑
CREATE TABLE  COURSE
(
  Cno          NUMBER(3) NOT NULL,  
  Cname        VARCHAR2(50),     
  Cgrade       NUMBER(3),  
  Cteacher     VARCHAR2(50),
  CONSTRAINT PK_COURCE PRIMARY KEY (Cno)    --主键约束
);
 
insert into  COURSE(cno,cname,cgrade,cteacher) values(1,'数学',4,'周洪波');
insert into  COURSE(cno,cname,cgrade,cteacher) values(2,'语文',3,'白玮');
insert into  COURSE(cno,cname,cgrade,cteacher) values(3,'英语',3,'宋维娜');
delete from course where Cname like '语文'
举例:
1.  触发器在更新表COURSE之前触发，目的是不允许删除课程：
create or replace trigger course_secure
before　DELETE    --删除之前
on COURSE

begin
   RAISE_APPLICATION_ERROR(-20600,'不能删除课程');
 END;

2.  触发器在更新表COURSE之前触发，目的是不允许删除语文课程：
create or replace trigger course_secure
before　DELETE    --删除之前
on COURSE
FOR EACH ROW    --FOR EACH ROW选项说明触发器为行触发器
begin
   if :old.cname='语文' then
   RAISE_APPLICATION_ERROR(-20600,'不能删除课程');
end if;
 END;

delete from COURSE     where cno=2;

3.  触发器在更新表COURSE之前触发，目的是周末不允许课程表：

create or replace trigger course_secure
before insert or update or DELETE
on COURSE
begin
  IF(to_char(sysdate,'DY')='星期六') THEN
    RAISE_APPLICATION_ERROR(-20600,'不能在周末修改表');
  END IF;
END;

4. 插入课程，新插入的课程id 是原来最大值加1
  CREATE OR REPLACE TRIGGER course_secure
 BEFORE INSERT ON COURSE
 FOR EACH ROW--对表的每一行触发器执行一次
DECLARE
 NEXT_ID NUMBER;
BEGIN
 SELECT max(cno)+1 INTO NEXT_ID FROM COURSE;
 :NEW.cno := NEXT_ID; --:NEW表示新插入的那条记录
END;

insert into  COURSE(cname,cgrade,cteacher) values('物理',3,'宋维娜');

5. 当用户对COURSE表执行DML语句时，将相关信息记录到日志表
CREATE TABLE course_log(   -- 创建日志表
  l_user  VARCHAR2(15),
  l_type  VARCHAR2(15),
  l_date  VARCHAR2(30)
);

 
CREATE OR REPLACE TRIGGER course_secure
 AFTER DELETE OR INSERT OR UPDATE ON COURSE
DECLARE
 V_TYPE COURSE_LOG.L_TYPE%TYPE;
BEGIN
 IF INSERTING THEN
  --INSERT触发
  V_TYPE := 'INSERT';
  DBMS_OUTPUT.PUT_LINE('记录已经成功插入，并已记录到日志');
 ELSIF UPDATING THEN
  --UPDATE触发
  V_TYPE := 'UPDATE';
  DBMS_OUTPUT.PUT_LINE('记录已经成功更新，并已记录到日志');
 ELSIF DELETING THEN
  --DELETE触发
  V_TYPE := 'DELETE';
  DBMS_OUTPUT.PUT_LINE('记录已经成功删除，并已记录到日志');
 END IF;
 INSERT INTO COURSE_LOG
 VALUES
  (USER, V_TYPE, TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss')); --USER表示当前用户名
END;


update COURSE  set cgrade=4 where cno=2;
delete from COURSE where cno=2;
insert into  COURSE(cno,cname,cgrade,cteacher) values(2,'语文',3,'白玮');

6. 创建触发器，用来记录表的删除数据

CREATE TABLE  OLD_COURSE as select * from course where 1=2;  -- 复制表 

CREATE OR REPLACE TRIGGER TIG_OLD_COURSE
 AFTER DELETE ON COURSE
 FOR EACH ROW --语句级触发，即每一行触发一次
BEGIN
 INSERT INTO OLD_COURSE VALUES (:OLD.CNO, :OLD.CNAME, :OLD.cgrade, :OLD.cteacher); --:old代表旧值
END;


select * from old_course;
delete from course where cno=2;

7.  创建触发器，比较COURSE  表中更新的学分

CREATE OR REPLACE TRIGGER course_secure
 after UPDATE ON course
 FOR EACH ROW
BEGIN
 IF :OLD.cgrade > :NEW.cgrade THEN
  DBMS_OUTPUT.PUT_LINE('减少');
 ELSIF :OLD.cgrade < :NEW.cgrade THEN
  DBMS_OUTPUT.PUT_LINE('学分增加');
 ELSE
  DBMS_OUTPUT.PUT_LINE('学分未作任何变动');
 END IF;
 DBMS_OUTPUT.PUT_LINE('更新前学分 ：' || :OLD.cgrade);
 DBMS_OUTPUT.PUT_LINE('更新后学分 ：' || :NEW.cgrade);
END;

update COURSE  set cgrade=4 where cno=2;

练习：上次练习的职工信息表，创建触发器：
1. 不允许给 部门为 30 的人降工资
2. 不允许删除部门为30 的人。
3. 创建表  记录每个部门的人数
    如 personcount表  字段  dno  p_count
   每次insert  delete 数据后,更新各部门人数


8. 创建系统事件触发器

CREATE TABLE log_event
 (user_name VARCHAR2(10),
  address VARCHAR2(20), 
  logon_date timestamp,
  logoff_date timestamp); 
  
CREATE OR REPLACE TRIGGER tr_logon
 AFTER LOGON ON DATABASE
BEGIN
    INSERT INTO log_event (user_name, address, logon_date)
    VALUES (ora_login_user, ora_client_ip_address, systimestamp);
END tr_logon;




