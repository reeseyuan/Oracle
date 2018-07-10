

使用 scott/tiger 登录

--:按照下列加薪比例执行(用CASE实现，创建一个emp1表，修改emp1表的数据),并将更新前后的数据输出出来
--  deptno  raise(%)
--  10      5%
--  20      10%
--  30      15%
--  40      20%
--  加薪比例以现有的sal为标准
--CASE expr WHEN comparison_expr THEN return_expr
--[, WHEN comparison_expr THEN return_expr]... [ELSE else_expr] END
declare
     cursor
         crs_caseTest
          is
          select * from emp1 for update of SAL;
          r_caseTest crs_caseTest%rowtype;
          salInfo emp1.sal%type;
     begin
         for r_caseTest in crs_caseTest 
     loop
         case 
           when r_caseTest.DEPNO=10
           THEN salInfo:=r_caseTest.SAL*1.05;
           when r_caseTest.DEPNO=20
           THEN salInfo:=r_caseTest.SAL*1.1;
           when r_caseTest.DEPNO=30
           THEN salInfo:=r_caseTest.SAL*1.15;
            when r_caseTest.DEPNO=40
           THEN salInfo:=r_caseTest.SAL*1.2;
         end case;
          update emp1 set SAL=salInfo where current of crs_caseTest;
        end loop;
end;

--:对每位员工的薪水进行判断，如果该员工薪水高于其所在部门的平均薪水，则将其薪水减50元，输出更新前后的薪水，员工姓名，所在部门编号。
--AVG([distinct|all] expr) over (analytic_clause)
---作用：
--按照analytic_clause中的规则求分组平均值。
  --分析函数语法:
  --FUNCTION_NAME(<argument>,<argument>...)
  --OVER
  --(<Partition-Clause><Order-by-Clause><Windowing Clause>)
     --PARTITION子句
     --按照表达式分区(就是分组),如果省略了分区子句,则全部的结果集被看作是一个单一的组
     select * from emp1
DECLARE
     CURSOR 
     crs_testAvg
     IS
     select EMPNO,ENAME,JOB,SAL,DEPNO,AVG(SAL) OVER (PARTITION BY DEPNO ) AS DEP_AVG
     FROM EMP1 for update of SAL;
     r_testAvg crs_testAvg%rowtype;
     salInfo emp1.sal%type;
     begin
     for r_testAvg in crs_testAvg loop
     if r_testAvg.SAL>r_testAvg.DEP_AVG then
     salInfo:=r_testAvg.SAL-50;
     end if;
     update emp1 set SAL=salInfo where current of crs_testAvg;
     end loop;
end;



参考网址
http://www.cnblogs.com/sc-xx/archive/2011/12/03/2275084.html
