���̶����﷨
   create or replace procedure �洢��������param1 in type��param2 in type��.....paramn out type�� 

as 

����1 ���ͣ�ֵ��Χ��;

����2 ���ͣ�ֵ��Χ��;

Begin

    ����

Exception   

    When others then

       Rollback;

End;
1.  ��򵥵ĳ���  hello world��
CREATE OR REPLACE PROCEDURE helloworld
as 
BEGIN
dbms_output.put_line('hello');
END;

���ù���
call helloworld();
2.  ��������� 
CREATE OR REPLACE PROCEDURE helloworld( sname in varchar)  --��������ָ�����
as 
BEGIN
dbms_output.put_line('hello:'|| sname);
END;

���ù���
call helloworld('zhang');


3. ��ѯ�������ݵ�ѧ������  ���������

CREATE OR REPLACE PROCEDURE stucount(ruxueyear in varchar)
as 
renshu number(5,0);
begin

select count(sno) into renshu from TB_student where to_char(sdate,'YYYY')=ruxueyear;
dbms_output.put_line(ruxueyear||'����ѧ��������:'|| renshu);
end;

����
call stucount('2012');


CREATE OR REPLACE PROCEDURE stucount(age TB_student.sage%TYPE)
as 
renshu number(5,0);
begin

IF age<18 or age>25 THEN
dbms_output.put_line('�����������'); 
ELSE
select count(sno) into renshu from TB_student where sage=age;
dbms_output.put_line(age||'���������:'|| renshu);
END IF;
end;
 
����
 call stucount(21);


4. ��ѯ�������ݵ�ѧ������  �������������������
CREATE OR REPLACE PROCEDURE stucount(ruxueyear in varchar,renshu out number)
as 
begin
select count(sno) into renshu from TB_student where to_char(sdate,'YYYY')=ruxueyear;
end;


--����
declare v_total number(5,0);
begin
stucount('2012',v_total);
dbms_output.put_line('��ѧ��������:'|| v_total);
end;



��ϰ.������̣������ǵ����䣬�õ�ѧ������,���ڵ��ù��̺����
 


5. �쳣����,��ѧ����������ѧ��,�������˵���ѧ���

CREATE OR REPLACE PROCEDURE findstu(inno in TB_student.sno%TYPE)
as 
 syear varchar(4);
begin
 
select to_char(sdate,'yyyy') into syear from TB_student where TB_student.sno=inno;
dbms_output.put_line(inno||'��ѧ�������:'|| syear);

Exception
When NO_DATA_FOUND  then
dbms_output.put_line('û���ҵ����ѧ��');
end;

����
call findstu(1091);

����

CREATE OR REPLACE PROCEDURE findstu(inno in TB_student.sno%TYPE,syear out varchar)
as 
 
begin
 
select to_char(sdate,'yyyy') into syear from TB_student where TB_student.sno=inno;
dbms_output.put_line(inno||'��ѧ�������:'|| syear);

Exception
When NO_DATA_FOUND  then

syear:='0000';
end;

declare sy varchar(5);
begin
findstu(1001,sy);
if sy='0000' then
dbms_output.put_line('û���ҵ�');
else
dbms_output.put_line('��ѧ�������:'|| sy);
end if;
end;
