--定义过程  过程的输入参数 是部门编号(例如10，20，30)和一个数值
--对部门中所有薪水小于这个数值的员工 加薪 10%，记录对多少人进行了加薪，一共加了多少钱。
 --1. 人数在过程内输出 2. 加的钱数为out参数

CREATE OR REPLACE PROCEDURE emp_addsal(dept in number,addmoney in number,summoney out number)
as 
add_count  number :=0 ;
begin
summoney:=0;
select sum(sal*0.1) into summoney from emp  where deptno=dept and sal< addmoney;
update emp set sal=sal*1.1 where deptno=dept and sal< addmoney;
add_count:=SQL%ROWCOUNT;
dbms_output.put_line('加薪人数:'|| add_count);
end;



CREATE OR REPLACE PROCEDURE emp_addsal(dept in number,addmoney in number,summoney out number)
as 
add_count  number :=0 ;
begin
summoney:=0;
select sum(sal*0.1) into summoney from emp  where deptno=dept and sal< addmoney;
select  count(empno) into add_count   from emp  where deptno=dept and sal< addmoney;
update emp set sal=sal*1.1 where deptno=dept and sal< addmoney;
dbms_output.put_line('加薪人数:'|| add_count);
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
      dbms_output.put_line('加薪人数:'|| add_count);
end;
 


declare 
summoney number(5);
begin
emp_addsal(30,1600,summoney);
dbms_output.put_line('共加薪钱数:'||summoney);
end;

