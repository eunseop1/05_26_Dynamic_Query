-- 교집합을 구해준다 : intersect
SELECT * FROM TEMP; -- 20개
SELECT * FROM TCOM; -- 8개

SELECT EMP_ID  FROM TEMP
INTERSECT
SELECT EMP_ID  FROM TCOM; -- 8개만 나온다


-- 차집합을 구해준다 : minus
SELECT EMP_ID  FROM TEMP
MINUS
SELECT EMP_ID  FROM TCOM; -- 12개가 나온다

-- 교집합과 차집합의 합집합?
(SELECT EMP_ID  FROM TEMP
INTERSECT
SELECT EMP_ID  FROM TCOM)
UNION
(SELECT EMP_ID  FROM TEMP
MINUS
SELECT EMP_ID  FROM TCOM); -- 전체가 나온다 -- 20개

-- =====================================================================================
-- join : 두개 이상의 테이블을 연결하여 데이터를 조회하는 방법

-- 1. CARTESIAN JOIN : 조건 없이 조인하는 방법 => n * m의 행 결과가 나온다
SELECT COUNT(*) FROM TEMP; -- 20개
SELECT COUNT(*) FROM TCOM; -- 8개

SELECT COUNT(*) FROM TEMP, TCOM; -- CARTESIAN JOIN
SELECT e.EMP_ID , e.EMP_NAME , c.EMP_ID  FROM TEMP e, TCOM c;

-- 사용예
-- temp 테이블에서 과장을 조회하는데 2번씩 조회하고 싶다
SELECT EMP_ID ,EMP_NAME, LEV FROM TEMP t WHERE LEV = '과장';
SELECT NO FROM MOD_TABLE mt WHERE NO <= 2;

SELECT 
	EMP_ID ,EMP_NAME, LEV 
FROM 
	TEMP t , MOD_TABLE mt 
WHERE 
	t.LEV = '과장' AND mt."NO" <= 2
ORDER BY 2; -- 두번째 컬럼을 기준으로 오름차순으로 정렬
-- =====================================================================================
-- 2. EQUI JOIN : 조건이 일치하는 데이터만 조인하는 방법
-- 사번, 이름, 부서번호, 부서명을 조회하고 싶다
SELECT * FROM TEMP t; -- 사번, 이름, 부서번호
SELECT * FROM TDEPT t; -- 부서명

SELECT 
	e.EMP_ID , e.EMP_NAME , e.DEPT_CODE , d.DEPT_NAME 
FROM 
	TEMP e , TDEPT d
WHERE 
	e.DEPT_CODE = d.DEPT_CODE ;
--
SELECT 
	EMP_ID , EMP_NAME , e.DEPT_CODE , DEPT_NAME -- 유일한 필드는 별칭을 안붙여도 된다
FROM 
	TEMP e , TDEPT d
WHERE 
	e.DEPT_CODE = d.DEPT_CODE ; -- 중복되는 필드는 반드시 별칭을 지정해서 써야 한다
-- =====================================================================================

SELECT * FROM TCOM t ;
-- TCOM의 WORK_YEAR가 2020인 자료를 temp테이블과 연결하여 커미션을 받는 직원의 이름과 
-- 실제 수령액(연봉 + 커미션)을 조회하시오
SELECT 
	e.EMP_NAME "이름" , e.SALARY + d.COMM "실제 수령액"  
FROM 
	TEMP e,TCOM d
WHERE 
	e.EMP_ID  = d.EMP_ID AND d.WORK_YEAR = '2020';

-- ======================================================================================
-- 3. non equi join : 조건에 부등호가 사용되어 조인하는 방법
-- TEMP와 EMP_LEVEL을 연결하여 과장 직급을 가질만한 나이의 사원 목록을 출력하시오
SELECT * FROM EMP_LEVEL el; -- 그냥하면 나이가 너무 많으므로
--
UPDATE TEMP SET BIRTH_DATE = ADD_MONTHS(BIRTH_DATE, 20 * 12); -- 생일을 20년 후로 변경시키자 
--
SELECT 
	EMP_ID , EMP_NAME , ROUND((SYSDATE - BIRTH_DATE)/365) "나이" 
FROM 
	TEMP t; 
--
SELECT
	l.LEV , e.EMP_ID , e.EMP_NAME , e.BIRTH_DATE , e.LEV 
FROM TEMP e, EMP_LEVEL l 
WHERE
	BIRTH_DATE BETWEEN ADD_MONTHS(SYSDATE, -1 * l.TO_AGE * 12) AND ADD_MONTHS(SYSDATE, -1 * l.FROM_AGE * 12)
	AND 
	l.LEV = '과장';
-- 과장 직급의 연봉을 받는 직원의 목록 조회
SELECT * FROM EMP_LEVEL el;

SELECT
	l.LEV || '(' || l.FROM_SAL || '~' || l.TO_SAL || ')', e.EMP_ID , e.EMP_NAME , e.LEV, e.SALARY  
FROM TEMP e, EMP_LEVEL l 
WHERE
	e.SALARY BETWEEN l.FROM_SAL AND l.TO_SAL
	AND 
	l.LEV = '과장';
-- ============================================================================================
-- 3. OUTER JOIN : 일치하는 행이 없더라도 나오게 조인하는 방법
-- ============================================================================================
/*
 1) LEFT OUTER JOIN : 조인문의 왼쪽에 있는 테이블의 모든 결과를 가져 온 후 오른쪽 테이블의 데이터를 매칭하고, 
                      매칭되는 데이터가 없는 경우 NULL로 표시한다.
   ex) SELECT 검색할 컬럼
       FROM 테이블명 LEFT OUTER JOIN 테이블명2
       ON 테이블.컬럼명 = 테이블2.컬럼명;

       <ORACLE>
       SELECT 검색할 컬럼
       FROM 테이블명, 테이블명2
       WHERE 테이블.컬럼명 = 테이블2.컬럼명(+);
       
  2) RIGHT OUTER JOIN : 조인문의 오른쪽에 있는 테이블의 모든 결과를 가져온 후 왼쪽의 테이블의 데이터를 매칭하고, 
                        매칭되는 데이터가 없는 경우 NULL을 표시한다.
   ex) SELECT 검색할 컬럼
       FROM 테이블명 RIGHT OUTER JOIN 테이블명2
       ON 테이블명 = 테이블명2;

       <ORACLE>
       SELECT 검색할 컬럼
       FROM 테이블명, 테이블명2
       WHERE 테이블.컬럼명(+) = 테이블2.컬럼명;
       
 3) FULL OUTER JOIN : LEFT OUTER JOIN 과 RIGHT OUTER JOIN을 합친 것으로, 양쪽 모두 조건이 일치하지 않는 것까지 
                      모두 결합해 출력한다
    ex) SELECT 검색할 컬럼
        FROM 테이블명 FULL OUTER JOIN 테이블명2
        ON 테이블.컬럼명 = 테이블2.컬럼명; (ORACLE의 경우)
         
※ MySQL에서는 FULL OUTER JOIN이 없으므로,
   LEFT OUTER JOIN 과 RIGHT OUTER JOIN을 UNION 하는 식으로 하여 FULL OUTER JOIN을 만들어 준다.        
*/
-- 일반적인 조인을 한다면
SELECT 
	e.EMP_NAME "이름", e.SALARY + c.COMM "실수령액"
FROM
	TEMP e, TCOM c
WHERE 
	e.EMP_ID = c.EMP_ID ;

-- left outer join 1
SELECT 
	e.EMP_ID "사번" , e.EMP_NAME "이름", e.SALARY + NVL(c.COMM, 0) "실수령액"
FROM
	TEMP e, TCOM c
WHERE 
	e.EMP_ID = c.EMP_ID(+) ;
-- left outer join 2(표준)
SELECT
	e.EMP_ID "사번" , e.EMP_NAME "이름", e.SALARY + NVL(c.COMM, 0) "실수령액"
FROM
	TEMP e LEFT OUTER JOIN TCOM c
ON
	e.EMP_ID = c.EMP_ID ;
-- =====================================================================================
-- 사용 예
-- 각 사번의 성명, 연봉, 연봉하한, 연봉상한 금액을 보고자 한다.
-- TEMP, EMP_LEVEL을 이용하여 조회하시오
-- 이때 수습 사원은 연봉 상한과 하한이 없더라도 나와야 한다.
SELECT * FROM EMP_LEVEL;
SELECT LEV FROM TEMP; -- 직급에 수습도 있다. 그런데 직급테이블에 수습은 없다

SELECT 
	EMP_ID "사번", EMP_NAME "이름", l.FROM_SAL "연봉하한" , l.TO_SAL "연봉상한" , e.SALARY "연봉"
FROM 
	TEMP e, EMP_LEVEL l
WHERE 
	e.LEV = l.LEV; -- 그런데 직원이 10명만 나온다. 현재 직원은 20명이다. 다 나오게 할순 없나?

SELECT 
	EMP_ID "사번", EMP_NAME "이름", l.FROM_SAL "연봉하한" , l.TO_SAL"연봉상한" , e.SALARY "연봉"
FROM 
	TEMP e, EMP_LEVEL l
WHERE 
	e.LEV = l.LEV(+);
-- ============================================================================================
-- 4. SELF JOIN : 동일한 테이블을 여러번 사용하여 조인하는 방법(반드시 별칭 사용해야 한다.)
-- ============================================================================================
-- 사용예
-- TDEPT테이블을 이용하여 부서코드, 부서명, 상위부서코드, 상위부서명을 조회하시오
SELECT * FROM TDEPT t ;

SELECT DEPT_CODE , DEPT_NAME  FROM TDEPT t WHERE DEPT_CODE LIKE '_A%';
SELECT DEPT_CODE , DEPT_NAME  FROM TDEPT t WHERE DEPT_CODE LIKE 'A%';
SELECT DEPT_CODE , DEPT_NAME  FROM TDEPT t WHERE DEPT_CODE LIKE 'B%';
SELECT DEPT_CODE , DEPT_NAME  FROM TDEPT t WHERE DEPT_CODE LIKE 'Bs%';
-- 자기자신을 불러오는거라 중복이 될것이기에 반드시 별칭을 써주자
SELECT 
	t1.DEPT_CODE "부서코드",
	t1.DEPT_NAME "부서이름",
	t2.DEPT_CODE "상위부서코드",
	t2.DEPT_NAME "상위부서이름"
FROM 
	TDEPT t1, TDEPT t2 
WHERE 
	t2.DEPT_CODE  = t1.PARENT_DEPT
ORDER BY
	t1.DEPT_CODE;
-- 문제 : HR계정에서 하시오
-- 사번, 이름, 매니저 이름을 조회하시오

SELECT
	t1.EMP_ID 사번, t1.EMP_NAME 이름, t1.BIRTH_DATE 생일, COUNT(t2.BIRTH_DATE) "어린사람 수" 
FROM
	TEMP t1 , TEMP t2 
WHERE 
	t1.BIRTH_DATE < t2.BIRTH_DATE (+)
GROUP BY
	t1.EMP_ID , t1.EMP_NAME , t1.BIRTH_DATE 
ORDER BY
	4;