-- 테이블 목록 보기
SELECT * FROM tab;
-- 05-26
SELECT * FROM EMPLOYEES e ;

SELECT 
	e.EMPLOYEE_ID "사번", CONCAT( CONCAT( e.FIRST_NAME , ' '), e.LAST_NAME )"이름", NVL(e.MANAGER_ID, 0) "매니저 ID", e2.FIRST_NAME || ' ' || e2.LAST_NAME "매니저 이름"
FROM 
	EMPLOYEES e, EMPLOYEES e2
WHERE 
	e.MANAGER_ID = e2.MANAGER_ID(+);

SELECT 
	EMPLOYEE_ID 사번, FIRST_NAME || ' ' || LAST_NAME 이름, MANAGER_ID "매니저 ID"
FROM 
	EMPLOYEES e ;

SELECT
	emp.EMPLOYEE_ID 사번,
	emp.FIRST_NAME || ' ' || emp.LAST_NAME 이름,
	emp.MANAGER_ID "매니저 ID",
	mgr.FIRST_NAME || ' ' || mgr.LAST_NAME "매니저 이름"
FROM 
	EMPLOYEES emp, EMPLOYEES mgr 
WHERE
	emp.MANAGER_ID = mgr.MANAGER_ID;


SELECT DISTINCT JOB_ID FROM EMPLOYEES e ;
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES e ;
