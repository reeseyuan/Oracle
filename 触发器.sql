�������Ķ������˵ĳ������������ʱ�򣬴�������������������ͻᱻ�Զ���ִ�С���˴���������Ҫ��Ϊ��ȥ���ã�Ҳ���ܵ��á��������Ĵ����������ڶ����ʱ����Ѿ��趨�ġ�

create [or replace] trigger �������� ����ʱ�� �����¼�
on ����
[for each row]
begin
 pl/sql���
end

������������������������ơ����ڴ����������ݿ��Զ�ִ�еģ���˸�����ֻ��һ�����ƣ�û��ʵ�ʵ���;��
����ʱ�䣺ָ����������ʱִ�У���ֵ��ȡ��
before����ʾ�����ݿ⶯��֮ǰ������ִ��;
after����ʾ�����ݿ⶯��֮�󴥷���ִ�С�
�����¼���ָ����Щ���ݿ⶯���ᴥ���˴�������
insert�����ݿ����ᴥ���˴�����;
update�����ݿ��޸Ļᴥ���˴�����;
delete�����ݿ�ɾ���ᴥ���˴�������
�� �������ݿⴥ�������ڵı�
for each row���Ա��ÿһ�д�����ִ��һ�Ρ����û����һѡ���ֻ��������ִ��һ�Ρ�

��������ʵ�����¹��ܣ�

���ܣ�

1�� ����/���ƶԱ���޸�
2�� �Զ����������У����������ֶ�
3�� ǿ������һ����
4�� �ṩ��ƺ���־��¼
5�� ��ֹ��Ч��������
6�� ���ø��ӵ�ҵ���߼�
CREATE TABLE  COURSE
(
  Cno          NUMBER(3) NOT NULL,  
  Cname        VARCHAR2(50),     
  Cgrade       NUMBER(3),  
  Cteacher     VARCHAR2(50),
  CONSTRAINT PK_COURCE PRIMARY KEY (Cno)    --����Լ��
);
 
insert into  COURSE(cno,cname,cgrade,cteacher) values(1,'��ѧ',4,'�ܺ鲨');
insert into  COURSE(cno,cname,cgrade,cteacher) values(2,'����',3,'����');
insert into  COURSE(cno,cname,cgrade,cteacher) values(3,'Ӣ��',3,'��ά��');
delete from course where Cname like '����'
����:
1.  �������ڸ��±�COURSE֮ǰ������Ŀ���ǲ�����ɾ���γ̣�
create or replace trigger course_secure
before��DELETE    --ɾ��֮ǰ
on COURSE

begin
   RAISE_APPLICATION_ERROR(-20600,'����ɾ���γ�');
 END;

2.  �������ڸ��±�COURSE֮ǰ������Ŀ���ǲ�����ɾ�����Ŀγ̣�
create or replace trigger course_secure
before��DELETE    --ɾ��֮ǰ
on COURSE
FOR EACH ROW    --FOR EACH ROWѡ��˵��������Ϊ�д�����
begin
   if :old.cname='����' then
   RAISE_APPLICATION_ERROR(-20600,'����ɾ���γ�');
end if;
 END;

delete from COURSE     where cno=2;

3.  �������ڸ��±�COURSE֮ǰ������Ŀ������ĩ������γ̱�

create or replace trigger course_secure
before insert or update or DELETE
on COURSE
begin
  IF(to_char(sysdate,'DY')='������') THEN
    RAISE_APPLICATION_ERROR(-20600,'��������ĩ�޸ı�');
  END IF;
END;

4. ����γ̣��²���Ŀγ�id ��ԭ�����ֵ��1
  CREATE OR REPLACE TRIGGER course_secure
 BEFORE INSERT ON COURSE
 FOR EACH ROW--�Ա��ÿһ�д�����ִ��һ��
DECLARE
 NEXT_ID NUMBER;
BEGIN
 SELECT max(cno)+1 INTO NEXT_ID FROM COURSE;
 :NEW.cno := NEXT_ID; --:NEW��ʾ�²����������¼
END;

insert into  COURSE(cname,cgrade,cteacher) values('����',3,'��ά��');

5. ���û���COURSE��ִ��DML���ʱ���������Ϣ��¼����־��
CREATE TABLE course_log(   -- ������־��
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
  --INSERT����
  V_TYPE := 'INSERT';
  DBMS_OUTPUT.PUT_LINE('��¼�Ѿ��ɹ����룬���Ѽ�¼����־');
 ELSIF UPDATING THEN
  --UPDATE����
  V_TYPE := 'UPDATE';
  DBMS_OUTPUT.PUT_LINE('��¼�Ѿ��ɹ����£����Ѽ�¼����־');
 ELSIF DELETING THEN
  --DELETE����
  V_TYPE := 'DELETE';
  DBMS_OUTPUT.PUT_LINE('��¼�Ѿ��ɹ�ɾ�������Ѽ�¼����־');
 END IF;
 INSERT INTO COURSE_LOG
 VALUES
  (USER, V_TYPE, TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss')); --USER��ʾ��ǰ�û���
END;


update COURSE  set cgrade=4 where cno=2;
delete from COURSE where cno=2;
insert into  COURSE(cno,cname,cgrade,cteacher) values(2,'����',3,'����');

6. ������������������¼���ɾ������

CREATE TABLE  OLD_COURSE as select * from course where 1=2;  -- ���Ʊ� 

CREATE OR REPLACE TRIGGER TIG_OLD_COURSE
 AFTER DELETE ON COURSE
 FOR EACH ROW --��伶��������ÿһ�д���һ��
BEGIN
 INSERT INTO OLD_COURSE VALUES (:OLD.CNO, :OLD.CNAME, :OLD.cgrade, :OLD.cteacher); --:old�����ֵ
END;


select * from old_course;
delete from course where cno=2;

7.  �������������Ƚ�COURSE  ���и��µ�ѧ��

CREATE OR REPLACE TRIGGER course_secure
 after UPDATE ON course
 FOR EACH ROW
BEGIN
 IF :OLD.cgrade > :NEW.cgrade THEN
  DBMS_OUTPUT.PUT_LINE('����');
 ELSIF :OLD.cgrade < :NEW.cgrade THEN
  DBMS_OUTPUT.PUT_LINE('ѧ������');
 ELSE
  DBMS_OUTPUT.PUT_LINE('ѧ��δ���κα䶯');
 END IF;
 DBMS_OUTPUT.PUT_LINE('����ǰѧ�� ��' || :OLD.cgrade);
 DBMS_OUTPUT.PUT_LINE('���º�ѧ�� ��' || :NEW.cgrade);
END;

update COURSE  set cgrade=4 where cno=2;

��ϰ���ϴ���ϰ��ְ����Ϣ��������������
1. ������� ����Ϊ 30 ���˽�����
2. ������ɾ������Ϊ30 ���ˡ�
3. ������  ��¼ÿ�����ŵ�����
    �� personcount��  �ֶ�  dno  p_count
   ÿ��insert  delete ���ݺ�,���¸���������


8. ����ϵͳ�¼�������

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




