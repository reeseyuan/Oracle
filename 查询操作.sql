1.单表查询，查询所有数据
select * from tb_student;
select * from tb_course;
select * from tb_score;

2.选择几个字段显示
select sno,sname,shigh from tb_student;
select sno as 学号,sname as 姓名,shigh as 身高 from tb_student; -- 别名
select  '姓名:'||sname,'身高:'||shigh from tb_student; -- 格式

select sno,sname,shigh/100 from tb_student;                 --函数
select sno,sname,shigh,to_char(sdate,'YYYY') from tb_student;
select sno,substr(sname, 1, 1),shigh,sage from tb_student  ; 
--oracle 函数有很多  数字函数、字符串函数、日期函数等，用的时候可以按需要查询手册或者搜索
3.去掉重复列
select distinct  sage from tb_student;

4. 单表条件查询 
select sno,sname,shigh,sage from tb_student　where sage>=20;
select sno,sname,shigh,sage from tb_student　where sage>=19 and sage<=20;
select sno,sname,shigh,sage from tb_student　where sage between 19 and 20;
select sno,sname,shigh,sage from tb_student　where sname like '张%';-- 通配符
select sno,sname,shigh,sage from tb_student　where sname like '张_';-- 通配符

--http://www.cnblogs.com/tyler2000/archive/2011/04/28/oracleSql.html 通配符高级查询


select * from tb_student where sdate > to_date('2012-01-01','YYYY-MM-DD')
select * from tb_student where sdate between to_date('2012-01-01','YYYY-MM-DD') and  to_date('2012-12-31','YYYY-MM-DD')
select sno,sname,shigh,sdate from tb_student where to_char(sdate,'YYYY') in('2011','2012')
select sno,sname,shigh,sage from tb_student　where not sage>=19 and sage<=20;
select sno,sname,shigh,sdate from tb_student where to_char(sdate,'YYYY')not in('2011','2012')

select sno,sname,shigh,sage from tb_student order by shigh asc;
select sno,sname,shigh,sage from tb_student order by shigh desc;

select sno 学号, 
sname 姓名, 
sdate 入学日期, 
decode(to_char(sdate,'YYYY'), 
'2011', '大四', 
'2012', '大三',
'2013', '大二'
) 年级
from tb_student;

--decode() 函数类似于 if....elsif...else 语句 select decode(1, 1, '内容是 1', 2, '内容是 2', 3, '内容是 3') from xxx；

5.多表联合查询
select * from tb_score;
select * from tb_score,tb_student;-- 未加连接条件
--常用的 内连接、自然连接，外连接

select st.sno,st.sname,sage ,cl.cname from tb_student st  inner join tb_class cl on st.sclass=cl.cno;-- 内连接
select sc.sno,st.sname,sc.cno,sc.score from tb_score sc inner join tb_student st　on sc.sno=st.sno and st.sname ='刘铁'; --内连接 

--内连接是将左表的所有数据分别于右表的每条数据进行连接组合，返回的结果为同时满足左右表联接条件的数据。
select tb_score.sno,tb_student.sname,tb_score.cno,tb_score.score from tb_score,tb_student　where tb_score.sno=tb_student.sno;  --等价语句 
select sc.sno,st.sname,sc.cno,sc.score from tb_score sc,tb_student st　where sc.sno=st.sno　-- 别名
select sc.sno,st.sname,sc.cno,sc.score from tb_score sc,tb_student st　where sc.sno=st.sno and st.sname ='刘铁';
select sc.sno,st.sname,sc.cno,sc.score from tb_score sc,tb_student st　where sc.sno=st.sno and st.sname ='刘贤宇';
select sc.sno,st.sname,sc.cno,cs.cname,sc.score from tb_score sc,tb_student st,tb_course cs　where sc.sno=st.sno and sc.cno=cs.cno and st.sname ='刘铁'  --多表连接

select sc.* from tb_score sc natural join tb_student st --自然连接
--两个表中有两个相同属性，sno,不用加限定条件即按照这两个字段连接，也可以看做内连接一种

select st.sno,st.sname,sage ,cl.cname from tb_student st  inner join tb_class cl on st.sclass=cl.cno;-- 内连接


select st.sno,st.sname,sage ,cl.cname from tb_student st  left join tb_class cl on st.sclass=cl.cno;  -- 左外连接（Left outer join/ left join）
select st.sno,st.sname,sage ,cl.cname from tb_student st   ,tb_class cl where st.sclass=cl.cno(+); 

   --  left join是以左表的记录为基础的,示例中tb_student可以看成左表,tb_class 可以看成右表,它的结果集是tb_student表中的数据，在加上表,tb_class 表与tb_student  表匹配的数据。换句话说,左表--tb_student的记录将会全部表示出来,而右表(tb_class )只会显示符合搜索条件的记录。tb_class 表记录不足的地方均为NULL.

select st.sno,st.sname,sage ,cl.cname from tb_class cl right join  tb_student st   on st.sclass=cl.cno;  -- 右外连接（right outer join/ right  join）
select st.sno,st.sname,sage ,cl.cname from tb_student st   ,tb_class cl where st.sclass=cl.cno(+); 


select st.sno,st.sname,sage ,cl.cname from tb_class cl full join  tb_student st   on st.sclass=cl.cno;-- 全外连接（full outer join/ full  join）

6.分组查询

select max(sage) from    tb_student st;   --类似函数还有  min,count,sum,avg
select * from tb_student where sage=(select max(sage) from  tb_student  )

select sdate,min(sage) from    tb_student st group by sdate;
select sdate,count(sno) from    tb_student st group by sdate;
select sage,count(sno) from    tb_student st group by sage 
select sdate,sage,count(sno) from  tb_student st group by sdate,sage order by sdate,sage

select * from tb_student where shigh in (
select max(shigh) from  tb_student group by sdate )   -- 每个年级入学最高身高

select * from 
(select max(shigh) m from tb_student group by sdate) temp,
tb_student e
where e.shigh = temp.m;                  -- 每个年级入学最高身高

7.查询集合计算

--union 操作符返回两个查询选定的所有不重复的行
select * from tb_student where sage=18 union select * from tb_student where to_char(sdate,'YYYY')='2012'

--union all 操作符合并两个查询选定的所有行，包括重复的行

select * from tb_student where sage=18 union all select * from tb_student where to_char(sdate,'YYYY')='2012'

--intersect 操作符只返回两个查询都有的行
select * from tb_student where sage=18 intersect  select * from tb_student where to_char(sdate,'YYYY')='2012'

-- minus 操作符只返回由第一个查询选定但是没有被第二个查询选定的行, 也就是在第一个查询结果中排除在第二个查询结果中出现的行
 select * from tb_student where to_char(sdate,'YYYY')='2012' minus   select * from tb_student where sage=18



8.创建视图

create view v_student_2012 as  
(select * from tb_student where sdate between to_date('2012-01-01','YYYY-MM-DD') and  to_date('2012-12-31','YYYY-MM-DD'))

select * from v_student_2012 

如果有权限不足的报错  用sys登录  sqlplus sys/xxxx@数据库名 as sysdba 
grant create view to xxx(用户名)
















 

