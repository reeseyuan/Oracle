1. set serveroutput on   可以显示输出内容.
2. 最简单的程序  hello world！
set serveroutput on 
declare 
name varchar(10);
begin
name:='&name1';
dbms_output.put_line('hello:'||name);
end;


3. 查询输入的年份的学生人数

declare 
ruxueyear varchar(4);
renshu number(5,0);
begin
ruxueyear:='&年份';
select count(sno) into renshu from TB_student where to_char(sdate,'YYYY')=ruxueyear;
dbms_output.put_line(ruxueyear||'年入学的人数是:'|| renshu);
end;

4.查询输入的年龄的学生人数,
declare 
age TB_student.sage%TYPE;
renshu number(5,0);
begin
age:='&AGE';
select count(sno) into renshu from TB_student where sage=age;
dbms_output.put_line(age||'岁的人数是:'|| renshu);
end;


--  select  XX into  是从数据库中的查询结果赋值给某变量

5.查询输入的年龄的学生人数,如果输入值<18 或〉25，输出 输入数据错误，否则输出统计数字

declare 
age TB_student.sage%TYPE;
renshu number(5,0);
begin
age:='&AGE';

IF age<18 or age>25 THEN
dbms_output.put_line('输入年龄错误'); 
ELSE
select count(sno) into renshu from TB_student where sage=age;
dbms_output.put_line(age||'岁的人数是:'|| renshu);
END IF;
end;
6. 异常处理,在学生表中输入学号,输出这个人的入学年份

set serveroutput on;
declare 
inno TB_student.sno%TYPE;
syear varchar(4);
begin
inno:='&SNO';
select to_char(sdate,'yyyy') into syear from TB_student where TB_student.sno=inno;
dbms_output.put_line(inno||'入学的年份是:'|| syear);

Exception
When NO_DATA_FOUND  then
dbms_output.put_line('没有找到这个学生');
end;


7.在学生表中输入学号,输出这个人是几年级的学生(2013对应一年级,2012对应二年级,2011对应一年级),没有这个学生输出没找到

set serveroutput on;
declare 
inno TB_student.sno%TYPE;
syear varchar(4);
scount number(4);

begin
inno:='&SNO';

select count(sno) into scount  from TB_student where TB_student.sno=inno;
if scount=0 then
dbms_output.put_line('没有这个学生'||inno);
else 
select to_char(sdate,'yyyy') into syear from TB_student where TB_student.sno=inno;

CASE syear
   WHEN  '2011' THEN   dbms_output.put_line('大三'||inno);
   WHEN  '2012' THEN   dbms_output.put_line('大二'||inno);
   WHEN  '2013' THEN   dbms_output.put_line('大一'||inno);
   else
    dbms_output.put_line('其它年级'||inno);
END CASE ;
 
end if;
 
end;
 

或者 

set serveroutput on;
declare 
inno TB_student.sno%TYPE;
syear varchar(4);
scount number(4);

begin
inno:='&SNO';

select count(sno) into scount  from TB_student where TB_student.sno=inno;
if scount=0 then
dbms_output.put_line('没有这个学生'||inno);
else 
select to_char(sdate,'yyyy') into syear from TB_student where TB_student.sno=inno;

        if syear= '2011' THEN 
          dbms_output.put_line('大三'||inno);
        elsif  syear= '2012' THEN  
          dbms_output.put_line('大二'||inno);
        elsif syear='2013' THEN 
          dbms_output.put_line('大一'||inno);
        else
          dbms_output.put_line('其它年级'||inno);
        end if;

end;

8. 循环输出 每个年龄(18-22) 的学生的人数

set serveroutput on;
declare 
age   number(4);
scount number(4);

begin
 
 FOR age IN 18..22
 LOOP 
  select count(sno) into scount  from TB_student where sage=age;
  dbms_output.put_line('年龄是'||age||'学生有'||scount||'名');
  END LOOP ;

end;

9.  更新数据，用隐形光标显示更新了多少条

set serveroutput on;
 begin
update tb_student set sclass= 3 where sclass is null;
    dbms_output.put_line('一共更新'||to_char(sql%rowcount) ||'条数据');
end;


create table tb_student_bak as select * from TB_STUDENT where 1=2; --复制表结构

set serveroutput on;
 begin
insert into tb_student_bak   select * from TB_STUDENT where sage=22;
    dbms_output.put_line('一共更新'||to_char(sql%rowcount) ||'条数据');
end;



 set serveroutput on;
 begin


update TB_STUDENT set sage=sage-1 where sage=27;
 if sql%NOTFOUND then
   dbms_output.put_line('没有更新数据');
   end if;
   
  if sql%FOUND then
   dbms_output.put_line('更新数据'|| sql%ROWCOUNT||'条');
   end if; 
end;


10.

假设：由于题目有误，将所有数学成绩提高10%，但总分数不能超过100分，并统计一共给多少名学生加了分，加分同学列出加分前后的成绩。

alter table tb_score modify  score number(6,2);  -- 修改分数列精度
 DECLARE
cursor c1 is select sno,score from tb_score where cno=1         
             for update;                         --定义游标
             
stu_rec  c1%rowtype ;      --利用光标定义记录型变量
stu_count  number :=0 ;

BEGIN
for  stu_rec   in c1
 loop
     dbms_output.put_line('更新前'||stu_rec.sno||':' ||stu_rec.score );
      update tb_score set  score=score*1.1   where sno=stu_rec.sno and  stu_rec.score*1.1<100 ;
      if sql%FOUND then
             dbms_output.put_line('更新后'||stu_rec.sno||':' || to_char(stu_rec.score*1.1 ));
             stu_count:=stu_count+1;
            else
             dbms_output.put_line('未更新');
      end if; 
 end loop ;
  dbms_output.put_line('更新数据'|| stu_count||'条');
commit ;
 END;

