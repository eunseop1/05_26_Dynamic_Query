package kr.human.vo;

import java.util.Date;

import lombok.Data;

/*
 * EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
   ENAME VARCHAR2(10),
   JOB VARCHAR2(9),
   MGR NUMBER(4),
   HIREDATE DATE,
   SAL NUMBER(7,2),
   COMM NUMBER(7,2),
   DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
 */
@Data
public class EmpVO {
	private int empno;
	private String ename;
	private String job;
	private String mgr;
	private Date hiredate;
	private double sal;
	private double comm;
	private int deptno;
}
