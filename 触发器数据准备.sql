���ݿ����´�����һ���û��� ����connect��resourceȨ�ޣ��޸����û����
��ѡ��������Ȥ��ͬѧ������ѧϰһ�´�����ռ䣬Ϊ���û�����ñ�ռ䣩
�ø��û���¼������������

ѧ����ѧ�š����������䡢�Ա���ѧ���ڡ����,�༶��
Ҫ��ѧ��Ϊ���� ���� 15-30 ֮�䣬�Ա�'F'��'M',��ѧ����Ϊ date����

�γ̱��γ̱�ţ��γ�����ѧ�֣��ον�ʦ����
�γ̱��Ϊ���� 

�ɼ���ѧ�š��γ̱�š��ɼ���
����ѧ�š��γ̱��Ϊ��������    ѧ��Ϊ���������ѧ�����γ̺�Ϊ����������γ̱�

�� insert ������ѧ����Ϣ��ѧ��������


�������͵Ĳ��뷽��
INSERT INTO student(xxx,xxx,xxdate) VALUES(xxx,xx, to_date('2000-01-01','YYYY-MM-DD'));

�� insert ������γ���Ϣ���γ̺�������

��insert ��䣬Ϊÿ��ѧ����ÿ�ſγ̵ĳɼ�����ɼ���
-- ѧ����
CREATE TABLE TB_CLASS
(
  cno        NUMBER(8) NOT NULL,   --ѧ������,ѧ��
  cname     VARCHAR2(50),
  CONSTRAINT PK_TB_CLASS PRIMARY KEY (cno)    --����Լ��
 );



CREATE TABLE TB_STUDENT
(
  Sno        NUMBER(8) NOT NULL,   --ѧ������,ѧ��
  Sname      VARCHAR2(50),      --ѧ������
  Sage       NUMBER(3),
  Ssex       CHAR,
  Sdate      DATE,
  Shigh      NUMBER(3), 
  Sclass     NUMBER(8), 
  CONSTRAINT PK_TB_STUDENT PRIMARY KEY (Sno),    --����Լ��
  CONSTRAINT ck_student_age CHECK(Sage BETWEEN 15 AND 30),
  constraint ck_student_sex check(Ssex in ('M','F')),
  CONSTRAINT FK_TB_STUDENT_class FOREIGN KEY (Sclass) REFERENCES  TB_CLASS (CNO) ON DELETE CASCADE 
);





CREATE TABLE TB_COURSE
(
  Cno          NUMBER(3) NOT NULL,  
  Cname        VARCHAR2(50),     
  Cgrade       NUMBER(3),  
  Cteacher     VARCHAR2(50),
  CONSTRAINT PK_TB_COURCE PRIMARY KEY (Cno)    --����Լ��
);


CREATE TABLE TB_SCORE
(
  Sno          NUMBER(8) NOT NULL,  
  Cno          NUMBER(8) NOT NULL,
  Score         NUMBER(3),
  CONSTRAINT PK_TB_SCORE_M PRIMARY KEY (Sno,Cno),    --����Լ��
  CONSTRAINT FK_TB_SCORE_Sno FOREIGN KEY (Sno) REFERENCES TB_STUDENT (SNO) ON DELETE CASCADE,
  CONSTRAINT FK_TB_SCORE_Cno FOREIGN KEY (Cno) REFERENCES TB_COURSE (CNO) ON DELETE CASCADE
);
 
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1001,'����',17,'F',to_date('2011-08-26','YYYY-MM-DD'),156,1);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1002,'������',17,'M',to_date('2011-08-26','YYYY-MM-DD'),166,1);

INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1003,'������',17,'F',to_date('2011-08-26','YYYY-MM-DD'),176,1);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1004,'��־��',17,'M',to_date('2011-08-26','YYYY-MM-DD'),187,1);

INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1005,'����',18,'F',to_date('2012-08-26','YYYY-MM-DD'),192,2);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1006,'���',18,'F',to_date('2012-08-26','YYYY-MM-DD'),165,2);

INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1007,'�����',18,'F',to_date('2012-08-26','YYYY-MM-DD'),174,2);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1008,'���ΰ',19,'M',to_date('2012-08-26','YYYY-MM-DD'),155,2);

INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1009,'������',19,'F',to_date('2012-08-26','YYYY-MM-DD'),186,2);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1010,'����',18,'M',to_date('2012-08-26','YYYY-MM-DD'),174,2);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh,Sclass) VALUES(1011,'����',20,'F',to_date('2013-08-26','YYYY-MM-DD'),167,3);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh) VALUES(1012,'���� ',21,'M',to_date('2013-08-26','YYYY-MM-DD'),199);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh) VALUES(1013,'���ҳ�',20,'F',to_date('2013-08-26','YYYY-MM-DD'),158);
INSERT INTO TB_STUDENT(Sno,Sname,Sage,Ssex,Sdate,Shigh) VALUES(1014,'ʯ����',21,'M',to_date('2013-08-26','YYYY-MM-DD'),167);

insert into TB_COURSE(cno,cname,cgrade,cteacher) values(1,'��ѧ',4,'�ܺ鲨');
insert into TB_COURSE(cno,cname,cgrade,cteacher) values(2,'����',3,'����');
insert into TB_COURSE(cno,cname,cgrade,cteacher) values(3,'Ӣ��',3,'��ά��');

insert into TB_SCORE(sno,cno,score) values(1001,1,88);
insert into TB_SCORE(sno,cno,score) values(1001,2,45);
insert into TB_SCORE(sno,cno,score) values(1001,3,76);

insert into TB_SCORE(sno,cno,score) values(1002,1,73);
insert into TB_SCORE(sno,cno,score) values(1002,2,65);
insert into TB_SCORE(sno,cno,score) values(1002,3,86);

insert into TB_SCORE(sno,cno,score) values(1003,1,88);
insert into TB_SCORE(sno,cno,score) values(1003,2,65);
insert into TB_SCORE(sno,cno,score) values(1003,3,96);

insert into TB_SCORE(sno,cno,score) values(1004,1,68);
insert into TB_SCORE(sno,cno,score) values(1004,2,55);
insert into TB_SCORE(sno,cno,score) values(1004,3,96);

insert into TB_SCORE(sno,cno,score) values(1005,1,68);
insert into TB_SCORE(sno,cno,score) values(1005,2,75);
insert into TB_SCORE(sno,cno,score) values(1005,3,86);

insert into TB_SCORE(sno,cno,score) values(1006,1,84);
insert into TB_SCORE(sno,cno,score) values(1006,2,42);
insert into TB_SCORE(sno,cno,score) values(1006,3,56);

insert into TB_SCORE(sno,cno,score) values(1007,1,78);
insert into TB_SCORE(sno,cno,score) values(1007,3,76);

insert into TB_SCORE(sno,cno,score) values(1008,2,85);
insert into TB_SCORE(sno,cno,score) values(1008,3,66);

insert into TB_SCORE(sno,cno,score) values(1009,1,95);
insert into TB_SCORE(sno,cno,score) values(1009,3,76);
