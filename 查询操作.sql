1.�����ѯ����ѯ��������
select * from tb_student;
select * from tb_course;
select * from tb_score;

2.ѡ�񼸸��ֶ���ʾ
select sno,sname,shigh from tb_student;
select sno as ѧ��,sname as ����,shigh as ��� from tb_student; -- ����
select  '����:'||sname,'���:'||shigh from tb_student; -- ��ʽ

select sno,sname,shigh/100 from tb_student;                 --����
select sno,sname,shigh,to_char(sdate,'YYYY') from tb_student;
select sno,substr(sname, 1, 1),shigh,sage from tb_student  ; 
--oracle �����кܶ�  ���ֺ������ַ������������ں����ȣ��õ�ʱ����԰���Ҫ��ѯ�ֲ��������
3.ȥ���ظ���
select distinct  sage from tb_student;

4. ����������ѯ 
select sno,sname,shigh,sage from tb_student��where sage>=20;
select sno,sname,shigh,sage from tb_student��where sage>=19 and sage<=20;
select sno,sname,shigh,sage from tb_student��where sage between 19 and 20;
select sno,sname,shigh,sage from tb_student��where sname like '��%';-- ͨ���
select sno,sname,shigh,sage from tb_student��where sname like '��_';-- ͨ���

--http://www.cnblogs.com/tyler2000/archive/2011/04/28/oracleSql.html ͨ����߼���ѯ


select * from tb_student where sdate > to_date('2012-01-01','YYYY-MM-DD')
select * from tb_student where sdate between to_date('2012-01-01','YYYY-MM-DD') and  to_date('2012-12-31','YYYY-MM-DD')
select sno,sname,shigh,sdate from tb_student where to_char(sdate,'YYYY') in('2011','2012')
select sno,sname,shigh,sage from tb_student��where not sage>=19 and sage<=20;
select sno,sname,shigh,sdate from tb_student where to_char(sdate,'YYYY')not in('2011','2012')

select sno,sname,shigh,sage from tb_student order by shigh asc;
select sno,sname,shigh,sage from tb_student order by shigh desc;

select sno ѧ��, 
sname ����, 
sdate ��ѧ����, 
decode(to_char(sdate,'YYYY'), 
'2011', '����', 
'2012', '����',
'2013', '���'
) �꼶
from tb_student;

--decode() ���������� if....elsif...else ��� select decode(1, 1, '������ 1', 2, '������ 2', 3, '������ 3') from xxx��

5.������ϲ�ѯ
select * from tb_score;
select * from tb_score,tb_student;-- δ����������
--���õ� �����ӡ���Ȼ���ӣ�������

select st.sno,st.sname,sage ,cl.cname from tb_student st  inner join tb_class cl on st.sclass=cl.cno;-- ������
select sc.sno,st.sname,sc.cno,sc.score from tb_score sc inner join tb_student st��on sc.sno=st.sno and st.sname ='����'; --������ 

--�������ǽ������������ݷֱ����ұ��ÿ�����ݽ���������ϣ����صĽ��Ϊͬʱ�������ұ��������������ݡ�
select tb_score.sno,tb_student.sname,tb_score.cno,tb_score.score from tb_score,tb_student��where tb_score.sno=tb_student.sno;  --�ȼ���� 
select sc.sno,st.sname,sc.cno,sc.score from tb_score sc,tb_student st��where sc.sno=st.sno��-- ����
select sc.sno,st.sname,sc.cno,sc.score from tb_score sc,tb_student st��where sc.sno=st.sno and st.sname ='����';
select sc.sno,st.sname,sc.cno,sc.score from tb_score sc,tb_student st��where sc.sno=st.sno and st.sname ='������';
select sc.sno,st.sname,sc.cno,cs.cname,sc.score from tb_score sc,tb_student st,tb_course cs��where sc.sno=st.sno and sc.cno=cs.cno and st.sname ='����'  --�������

select sc.* from tb_score sc natural join tb_student st --��Ȼ����
--����������������ͬ���ԣ�sno,���ü��޶������������������ֶ����ӣ�Ҳ���Կ���������һ��

select st.sno,st.sname,sage ,cl.cname from tb_student st  inner join tb_class cl on st.sclass=cl.cno;-- ������


select st.sno,st.sname,sage ,cl.cname from tb_student st  left join tb_class cl on st.sclass=cl.cno;  -- �������ӣ�Left outer join/ left join��
select st.sno,st.sname,sage ,cl.cname from tb_student st   ,tb_class cl where st.sclass=cl.cno(+); 

   --  left join�������ļ�¼Ϊ������,ʾ����tb_student���Կ������,tb_class ���Կ����ұ�,���Ľ������tb_student���е����ݣ��ڼ��ϱ�,tb_class ����tb_student  ��ƥ������ݡ����仰˵,���--tb_student�ļ�¼����ȫ����ʾ����,���ұ�(tb_class )ֻ����ʾ�������������ļ�¼��tb_class ���¼����ĵط���ΪNULL.

select st.sno,st.sname,sage ,cl.cname from tb_class cl right join  tb_student st   on st.sclass=cl.cno;  -- �������ӣ�right outer join/ right  join��
select st.sno,st.sname,sage ,cl.cname from tb_student st   ,tb_class cl where st.sclass=cl.cno(+); 


select st.sno,st.sname,sage ,cl.cname from tb_class cl full join  tb_student st   on st.sclass=cl.cno;-- ȫ�����ӣ�full outer join/ full  join��

6.�����ѯ

select max(sage) from    tb_student st;   --���ƺ�������  min,count,sum,avg
select * from tb_student where sage=(select max(sage) from  tb_student  )

select sdate,min(sage) from    tb_student st group by sdate;
select sdate,count(sno) from    tb_student st group by sdate;
select sage,count(sno) from    tb_student st group by sage 
select sdate,sage,count(sno) from  tb_student st group by sdate,sage order by sdate,sage

select * from tb_student where shigh in (
select max(shigh) from  tb_student group by sdate )   -- ÿ���꼶��ѧ������

select * from 
(select max(shigh) m from tb_student group by sdate) temp,
tb_student e
where e.shigh = temp.m;                  -- ÿ���꼶��ѧ������

7.��ѯ���ϼ���

--union ����������������ѯѡ�������в��ظ�����
select * from tb_student where sage=18 union select * from tb_student where to_char(sdate,'YYYY')='2012'

--union all �������ϲ�������ѯѡ���������У������ظ�����

select * from tb_student where sage=18 union all select * from tb_student where to_char(sdate,'YYYY')='2012'

--intersect ������ֻ����������ѯ���е���
select * from tb_student where sage=18 intersect  select * from tb_student where to_char(sdate,'YYYY')='2012'

-- minus ������ֻ�����ɵ�һ����ѯѡ������û�б��ڶ�����ѯѡ������, Ҳ�����ڵ�һ����ѯ������ų��ڵڶ�����ѯ����г��ֵ���
 select * from tb_student where to_char(sdate,'YYYY')='2012' minus   select * from tb_student where sage=18



8.������ͼ

create view v_student_2012 as  
(select * from tb_student where sdate between to_date('2012-01-01','YYYY-MM-DD') and  to_date('2012-12-31','YYYY-MM-DD'))

select * from v_student_2012 

�����Ȩ�޲���ı���  ��sys��¼  sqlplus sys/xxxx@���ݿ��� as sysdba 
grant create view to xxx(�û���)
















 

