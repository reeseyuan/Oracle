1. set serveroutput on   ������ʾ�������.
2. ��򵥵ĳ���  hello world��
set serveroutput on 
declare 
name varchar(10);
begin
name:='&name1';
dbms_output.put_line('hello:'||name);
end;


3. ��ѯ�������ݵ�ѧ������

declare 
ruxueyear varchar(4);
renshu number(5,0);
begin
ruxueyear:='&���';
select count(sno) into renshu from TB_student where to_char(sdate,'YYYY')=ruxueyear;
dbms_output.put_line(ruxueyear||'����ѧ��������:'|| renshu);
end;

4.��ѯ����������ѧ������,
declare 
age TB_student.sage%TYPE;
renshu number(5,0);
begin
age:='&AGE';
select count(sno) into renshu from TB_student where sage=age;
dbms_output.put_line(age||'���������:'|| renshu);
end;


--  select  XX into  �Ǵ����ݿ��еĲ�ѯ�����ֵ��ĳ����

5.��ѯ����������ѧ������,�������ֵ<18 ��25����� �������ݴ��󣬷������ͳ������

declare 
age TB_student.sage%TYPE;
renshu number(5,0);
begin
age:='&AGE';

IF age<18 or age>25 THEN
dbms_output.put_line('�����������'); 
ELSE
select count(sno) into renshu from TB_student where sage=age;
dbms_output.put_line(age||'���������:'|| renshu);
END IF;
end;
6. �쳣����,��ѧ����������ѧ��,�������˵���ѧ���

set serveroutput on;
declare 
inno TB_student.sno%TYPE;
syear varchar(4);
begin
inno:='&SNO';
select to_char(sdate,'yyyy') into syear from TB_student where TB_student.sno=inno;
dbms_output.put_line(inno||'��ѧ�������:'|| syear);

Exception
When NO_DATA_FOUND  then
dbms_output.put_line('û���ҵ����ѧ��');
end;


7.��ѧ����������ѧ��,���������Ǽ��꼶��ѧ��(2013��Ӧһ�꼶,2012��Ӧ���꼶,2011��Ӧһ�꼶),û�����ѧ�����û�ҵ�

set serveroutput on;
declare 
inno TB_student.sno%TYPE;
syear varchar(4);
scount number(4);

begin
inno:='&SNO';

select count(sno) into scount  from TB_student where TB_student.sno=inno;
if scount=0 then
dbms_output.put_line('û�����ѧ��'||inno);
else 
select to_char(sdate,'yyyy') into syear from TB_student where TB_student.sno=inno;

CASE syear
   WHEN  '2011' THEN   dbms_output.put_line('����'||inno);
   WHEN  '2012' THEN   dbms_output.put_line('���'||inno);
   WHEN  '2013' THEN   dbms_output.put_line('��һ'||inno);
   else
    dbms_output.put_line('�����꼶'||inno);
END CASE ;
 
end if;
 
end;
 

���� 

set serveroutput on;
declare 
inno TB_student.sno%TYPE;
syear varchar(4);
scount number(4);

begin
inno:='&SNO';

select count(sno) into scount  from TB_student where TB_student.sno=inno;
if scount=0 then
dbms_output.put_line('û�����ѧ��'||inno);
else 
select to_char(sdate,'yyyy') into syear from TB_student where TB_student.sno=inno;

        if syear= '2011' THEN 
          dbms_output.put_line('����'||inno);
        elsif  syear= '2012' THEN  
          dbms_output.put_line('���'||inno);
        elsif syear='2013' THEN 
          dbms_output.put_line('��һ'||inno);
        else
          dbms_output.put_line('�����꼶'||inno);
        end if;

end;

8. ѭ����� ÿ������(18-22) ��ѧ��������

set serveroutput on;
declare 
age   number(4);
scount number(4);

begin
 
 FOR age IN 18..22
 LOOP 
  select count(sno) into scount  from TB_student where sage=age;
  dbms_output.put_line('������'||age||'ѧ����'||scount||'��');
  END LOOP ;

end;

9.  �������ݣ������ι����ʾ�����˶�����

set serveroutput on;
 begin
update tb_student set sclass= 3 where sclass is null;
    dbms_output.put_line('һ������'||to_char(sql%rowcount) ||'������');
end;


create table tb_student_bak as select * from TB_STUDENT where 1=2; --���Ʊ�ṹ

set serveroutput on;
 begin
insert into tb_student_bak   select * from TB_STUDENT where sage=22;
    dbms_output.put_line('һ������'||to_char(sql%rowcount) ||'������');
end;



 set serveroutput on;
 begin


update TB_STUDENT set sage=sage-1 where sage=27;
 if sql%NOTFOUND then
   dbms_output.put_line('û�и�������');
   end if;
   
  if sql%FOUND then
   dbms_output.put_line('��������'|| sql%ROWCOUNT||'��');
   end if; 
end;


10.

���裺������Ŀ���󣬽�������ѧ�ɼ����10%�����ܷ������ܳ���100�֣���ͳ��һ����������ѧ�����˷֣��ӷ�ͬѧ�г��ӷ�ǰ��ĳɼ���

alter table tb_score modify  score number(6,2);  -- �޸ķ����о���
 DECLARE
cursor c1 is select sno,score from tb_score where cno=1         
             for update;                         --�����α�
             
stu_rec  c1%rowtype ;      --���ù�궨���¼�ͱ���
stu_count  number :=0 ;

BEGIN
for  stu_rec   in c1
 loop
     dbms_output.put_line('����ǰ'||stu_rec.sno||':' ||stu_rec.score );
      update tb_score set  score=score*1.1   where sno=stu_rec.sno and  stu_rec.score*1.1<100 ;
      if sql%FOUND then
             dbms_output.put_line('���º�'||stu_rec.sno||':' || to_char(stu_rec.score*1.1 ));
             stu_count:=stu_count+1;
            else
             dbms_output.put_line('δ����');
      end if; 
 end loop ;
  dbms_output.put_line('��������'|| stu_count||'��');
commit ;
 END;

