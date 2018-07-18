//学生信息(student_Form)表
create table student_Form
(
student_NO number  Primary Key,
student_Name varchar2(50),
student_Sex char,
student_Class number,
student_Dept varchar2(50),
student_Major varchar2(50),
constraint CK_student_sex check(student_Sex in ('M','F'))，
constraint FK_student_class Foreign Key (student_Class) References class_Form(class_No) ON DELETE CASCADE
)

drop table student_Form;

//班级信息(class_Form)表
create table class_Form
(
class_No number Primary Key,
class_StuNum number
)

//院系信息(dept_Form)表
create table dept_Form
(
dept_Name varchar2(50) Primary Key,
dept_Major varchar2(50)
)

//专业信息(major_Form)表
create table major_Form
(
major_Name varchar2(50),
major_Class number
)

//课程信息(course_Form)表
create table course_Form
(
course_Name varchar2(50) Primary Key,
course_Score number
)
insert into course_Form values ('gaoshu',5);
select * from course_Form;
//学生成绩信息(score_Form)表
create table score_Form
(
score_StuNO number  Primary Key,
score_StuName varchar2(50),
score_CoName varchar2(50),
score_CoGrade number,
constraint course_n Foreign Key (score_CoName) References course_Form(course_Name)
)
insert into score_Form values ('1000','li','gaoshu',98);
insert into score_Form values ('1001','wang','gaoshu',90);

select * from score_Form;

//奖惩信息(prize_Form)表
create table prize_Form
(
prize_name varchar2(50) Primary Key
)

//奖惩学生信息(prize_Stud)表
create table prize_Stud
(
prize_StuNO number  Primary Key,
prize_StuName varchar2(50),
prize_Date date,
prize_Name varchar2(50),
constraint prize_n Foreign Key (prize_Name) References prize_Form(prize_name)
)
 //视图
create view student_search AS
(
select * from student_Form
)
select * from student_search;
//存储过程
create or replace procedure stugrade(studentNo in number)
as
cName varchar2(50);
cGrade number;
begin
select score_CoName into cName from score_Form where score_StuNO=studentNo;
select score_CoGrade into cGrade from score_Form where score_StuNO=studentNo;
Dbms_output.Put_line('该学生成绩单信息为：'||cName||' '||cGrade);
end;

//调用存储过程
call stugrade(1000);

//触发器
create or replace trigger addsnum
after insert
on student_Form
for each row
begin
update class_Form set class_Form.class_StuNum=class_Form.class_StuNum+1 where class_Form.class_no=:new.student_class;
end;

create or replace trigger delsnum
after delete
on student_Form
for each row
begin
update class_Form set class_Form.class_StuNum=class_Form.class_StuNum-1 where class_Form.class_no=:new.student_class;
end;

create or replace trigger chs_class
after update 
on student_Form
for each row
begin
update class_Form set class_Form.class_StuNum=class_Form.class_StuNum-1 where class_Form.class_No= :old.student_Class;
update class_Form set class_Form.class_StuNum=class_Form.class_StuNum+1 where class_Form.class_No= :new.student_Class;
end;

declare
classnum number;
studentnum number;
begin
classnum:='&班级号';
select class_StuNum into studentnum from class_Form where class_No = classnum;
dbms_output.put_line(classnum||'班级人数为'||studentnum);
end;

desc student_Form;
insert into student_Form  values (1000,'li','F',01,'jisuanji','jike');
insert into student_Form  values (1001,'wang','M',01,'jisuanji','jike');
insert into student_Form  values (1002,'xi','F',01,'jisuanji','jike');
insert into student_Form  values (1003,'zhang','M',01,'jisuanji','jike');
insert into student_Form  values (1004,'yang','F',01,'jisuanji','jike');
insert into dept_Form values ('jisuanji','jike' );
insert into major_Form values ('jike',01);
insert into major_Form values ('jike',02);
insert into major_Form values ('jike',03);
insert into major_Form values ('jike',04);
insert into class_Form values ('01',30);
insert into prize_Form values ('liuxiaochakan');
insert into prize_Form values ('jiangxuejin');
insert into prize_Stud values(1000,'li',TO_DATE('2018-05-06','YYYY-MM-DD'),'jiangxuejin');


select * from student_Form;
select * from class_Form;
select * from major_Form;
select * from prize_Stud;
select * from 