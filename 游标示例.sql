

ʹ�� scott/tiger ��¼

--:�������м�н����ִ��(��CASEʵ�֣�����һ��emp1���޸�emp1�������),��������ǰ��������������
--  deptno  raise(%)
--  10      5%
--  20      10%
--  30      15%
--  40      20%
--  ��н���������е�salΪ��׼
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

--:��ÿλԱ����нˮ�����жϣ������Ա��нˮ���������ڲ��ŵ�ƽ��нˮ������нˮ��50Ԫ���������ǰ���нˮ��Ա�����������ڲ��ű�š�
--AVG([distinct|all] expr) over (analytic_clause)
---���ã�
--����analytic_clause�еĹ��������ƽ��ֵ��
  --���������﷨:
  --FUNCTION_NAME(<argument>,<argument>...)
  --OVER
  --(<Partition-Clause><Order-by-Clause><Windowing Clause>)
     --PARTITION�Ӿ�
     --���ձ��ʽ����(���Ƿ���),���ʡ���˷����Ӿ�,��ȫ���Ľ������������һ����һ����
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



�ο���ַ
http://www.cnblogs.com/sc-xx/archive/2011/12/03/2275084.html
