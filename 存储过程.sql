过程定义语法
   create or replace procedure 存储过程名（param1 in type，param2 in type，.....paramn out type） 

as 

变量1 类型（值范围）;

变量2 类型（值范围）;

Begin

    程序

Exception   

    When others then

       Rollback;

End;
1.  最简单的程序  hello world！
CREATE OR REPLACE PROCEDURE helloworld
as 
BEGIN
dbms_output.put_line('hello');
END;

调用过程
call helloworld();
2.  带传入参数 
CREATE OR REPLACE PROCEDURE helloworld( sname in varchar)  --参数不能指定宽度
as 
BEGIN
dbms_output.put_line('hello:'|| sname);
END;

调用过程
call helloworld('zhang');


3. 查询输入的年份的学生人数  带传入参数

CREATE OR REPLACE PROCEDURE stucount(ruxueyear in varchar)
as 
renshu number(5,0);
begin

select count(sno) into renshu from TB_student where to_char(sdate,'YYYY')=ruxueyear;
dbms_output.put_line(ruxueyear||'年入学的人数是:'|| renshu);
end;

调用
call stucount('2012');


CREATE OR REPLACE PROCEDURE stucount(age TB_student.sage%TYPE)
as 
renshu number(5,0);
begin

IF age<18 or age>25 THEN
dbms_output.put_line('输入年龄错误'); 
ELSE
select count(sno) into renshu from TB_student where sage=age;
dbms_output.put_line(age||'岁的人数是:'|| renshu);
END IF;
end;
 
调用
 call stucount(21);


4. 查询输入的年份的学生人数  带传入参数、传出参数
CREATE OR REPLACE PROCEDURE stucount(ruxueyear in varchar,renshu out number)
as 
begin
select count(sno) into renshu from TB_student where to_char(sdate,'YYYY')=ruxueyear;
end;


--调用
declare v_total number(5,0);
begin
stucount('2012',v_total);
dbms_output.put_line('入学的人数是:'|| v_total);
end;



练习.定义过程，参数是的年龄，得到学生人数,并在调用过程后输出
 


5. 异常处理,在学生表中输入学号,输出这个人的入学年份

CREATE OR REPLACE PROCEDURE findstu(inno in TB_student.sno%TYPE)
as 
 syear varchar(4);
begin
 
select to_char(sdate,'yyyy') into syear from TB_student where TB_student.sno=inno;
dbms_output.put_line(inno||'入学的年份是:'|| syear);

Exception
When NO_DATA_FOUND  then
dbms_output.put_line('没有找到这个学生');
end;

调用
call findstu(1091);

或者

CREATE OR REPLACE PROCEDURE findstu(inno in TB_student.sno%TYPE,syear out varchar)
as 
 
begin
 
select to_char(sdate,'yyyy') into syear from TB_student where TB_student.sno=inno;
dbms_output.put_line(inno||'入学的年份是:'|| syear);

Exception
When NO_DATA_FOUND  then

syear:='0000';
end;

declare sy varchar(5);
begin
findstu(1001,sy);
if sy='0000' then
dbms_output.put_line('没有找到');
else
dbms_output.put_line('入学的年份是:'|| sy);
end if;
end;
