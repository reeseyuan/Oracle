--�������  ���̵�������� �ǲ��ű��(����10��20��30)��һ����ֵ
--�Բ���������нˮС�������ֵ��Ա�� ��н 10%����¼�Զ����˽����˼�н��һ�����˶���Ǯ��
 --1. �����ڹ�������� 2. �ӵ�Ǯ��Ϊout����

CREATE OR REPLACE PROCEDURE emp_addsal(dept in number,addmoney in number,summoney out number)
as 
add_count  number :=0 ;
begin
summoney:=0;
select sum(sal*0.1) into summoney from emp  where deptno=dept and sal< addmoney;
update emp set sal=sal*1.1 where deptno=dept and sal< addmoney;
add_count:=SQL%ROWCOUNT;
dbms_output.put_line('��н����:'|| add_count);
end;



CREATE OR REPLACE PROCEDURE emp_addsal(dept in number,addmoney in number,summoney out number)
as 
add_count  number :=0 ;
begin
summoney:=0;
select sum(sal*0.1) into summoney from emp  where deptno=dept and sal< addmoney;
select  count(empno) into add_count   from emp  where deptno=dept and sal< addmoney;
update emp set sal=sal*1.1 where deptno=dept and sal< addmoney;
dbms_output.put_line('��н����:'|| add_count);
end;


CREATE OR REPLACE PROCEDURE emp_addsal(dept in number,addmoney in number,summoney out number)
as 

  cursor
   crs_caseTest
   is
  select * from emp    where deptno=dept and sal< addmoney;
  add_count  number :=0 ;    
     begin
     summoney:=0;
      for r in crs_caseTest 
         loop
         update emp set sal=sal*1.1 where empno=r.empno;
         summoney:=summoney+r.sal*0.1;
        add_count:= add_count+1;
      end loop;
      dbms_output.put_line('��н����:'|| add_count);
end;
 


declare 
summoney number(5);
begin
emp_addsal(30,1600,summoney);
dbms_output.put_line('����нǮ��:'||summoney);
end;

