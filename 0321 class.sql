-- 1번
SELECT EMPNO, ENAME
   , RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS "EMPNO 마스킹 처리"
   , RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS "ENAME 마스킹 처리"
FROM EMP e WHERE LENGTH(ENAME) >= 6;


--
SELECT EMPNO
	, ENAME
	, CONCAT(EMPNO, ENAME)
	, CONCAT(EMPNO, '')
FROM EMP
WHERE ENAME = UPPER('smith')
;

SELECT '010-1234-5678' AS mobile_phone
	, REPLACE ('010-1234-5678', '-', '') AS REPLACE replace_mp
FROM dual;


SELECT *
FROM EMP
WHERE HIREDATE > TO_DATE('1981/07/01', 'YYYY/MM/DD');

SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR_49
	, TO_DATE('49/12/10', 'RR/MM/DD') AS RR_YEAR_49
FROM DUAL; 

SELECT DEPTNO
	, JOB
	, COUNT(*)
	, MAX(SAL)
	, SUM(SAL)
	, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB 
ORDER BY DEPTNO, JOB
;


SELECT DEPTNO, JOB
   , COUNT(SAL)
   , AVG(SAL + NVL(COMM, 0)) AS avg_pay
   , MAX(SAL + NVL(COMM, 0)) AS max_pay
   , MIN(SAL + NVL(COMM, 0)) AS min_pay
   , SUM(SAL + NVL(COMM, 0)) AS sum_pay
FROM EMP 
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB
;

SELECT *
FROM emp, DEPT d
ORDER BY empno
;

SELECT *
FROM emp E, dept D
WHERE E. ename = 'SMITH'
ORDER BY E.EMPNO
;

SELECT *
	FROM emp, dept
	WHERE emp.DEPTNO = DEPTNO 
;	

	
SELECT *
FROM emp, DEPT d WHERE emp.DEPTNO = dept.DEPTNO 
ORDER BY EMPNO 
;

SELECT *
FROM emp, DEPT 
WHERE emp.DEPTNO = dept.DEPTNO 
ORDER BY EMPNO 
;

SELECT E.EMPNO 
      , e.HIREDATE 
      , d.DNAME 
      , e.JOB 
      , e.sal
FROM emp E JOIN dept D
   ON E.DEPTNO = D.DEPTNO 
;

-- using은 컬럼명이 같은 때만 조인할 수 있습니다 --
SELECT *
FROM emp e JOIN dept D
	USING (deptno)
ORDER BY e.empno;
;

SELECT e.empno
	, e.ename
	, d.deptno
	, d.dname
	, d.loc
FROM emp e, dept d
WHERE e.DEPTNO = d.DEPTNO 
ORDER BY d.deptno, e.EMPNO
;


SELECT e.EMPNO 
	, to_char(e.HIREDATE), 'YYYY MM-DD') AS HIREDATE 
	, e. ENAME
	, d.DEPTNO 
	, d.LOC 
	, e.SAL 
FROM emp e
	, dept d
WHERE e.DEPTNO = d.DEPTNO AND e.SAL < 2000
ORDER BY e.SAL DESC
;


SELECT d.DNAME AS dname
	, round(avg(e.SAL), 0) AS avg_sal
	, sum(e.SAL) AS sum_sal
	, max(e.SAL) AS max_sal
	, min(e.SAL) AS min_sal
	, count(e.SAL) AS cnt_sal
FROM emp e
	, dept d
WHERE e.DEPTNO = d.DEPTNO AND e.SAL < 2000
GROUP BY d.DNAME 
;


SELECT d.DNAME AS dname
	, e.JOB AS job
	, round(avg(e.SAL), 0) AS avg_sal
	, sum(e.SAL) AS sum_sal
	, max(e.SAL) AS max_sal
	, min(e.SAL) AS min_sal
	, count(e.SAL) AS cnt_sal
FROM emp e
	, dept d
WHERE e.DEPTNO = d.DEPTNO AND e.SAL < 2000
GROUP BY d.DNAME, e.JOB 
;



SELECT e.ENAME 
	, e.DEPTNO 
	, e.JOB 
	, s.GRADE 
	, e.SAL 
	, s.LOSAL AS low_rng
	, s.HISAL AS high_rng
FROM EMP e, SALGRADE s 
WHERE e.sal BETWEEN s.LOSAL AND s.HISAL 
;



SELECT s.GRADE 
	, count(e.ENAME) AS emp_cnt
FROM EMP e, SALGRADE s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL 
GROUP BY s.GRADE         -- grade 기준으로 그
ORDER BY emp_cnt DESC    -- 임직원수가 많은 수부터 
;



SELECT 
FROM EMP e, DEPT d    -- 내가 필요한 테이블과 별칭 지정
WHERE e.DEPTNO = d.DEPTNO -- INNER JOIN 
;



SELECT e1.EMPNO AS emp_no
	, e1.ENAME AS emp_name
	, e1.MGR AS mgr_no
	, e2.ENAME AS mgr_name
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO  
;


SELECT e1.EMPNO 
	, e1.ENAME 
	, e1.MGR
	, e2.EMPNO AS mgr_no
	, e2.ENAME AS mgr_name
FROM emp e1, emp e2
WHERE e1.MGR  = e2.EMPNO 
;



-- 오라클 sql : 매니저와 직원 정보 출력
SELECT e1.EMPNO 
	, e1.ENAME 
	, e1.MGR
	, e2.EMPNO AS mgr_no
	, e2.ENAME AS mgr_name
FROM emp e1, emp e2
WHERE e1.MGR = e2.EMPNO(+)
;


SELECT e1.EMPNO 
	, e1.ENAME 
	, e1.MGR
	, e2.EMPNO AS mgr_no
	, e2.ENAME AS mgr_name
FROM emp e1 LEFT OUTER JOIN emp e2
	ON e1.MGR = e2.EMPNO 
;



-- right join : 오라클 SQL 활용
SELECT e1.EMPNO 
	, e1.ENAME 
	, e1.MGR
	, e2.EMPNO AS mgr_no
	, e2.ENAME AS mgr_name
FROM emp e1, emp e2
WHERE e1.MGR(+) = e2.EMPNO 
ORDER BY e1.EMPNO
;


SELECT e1.EMPNO 
	, e1.ENAME 
	, e1.MGR
	, e2.EMPNO AS mgr_no
	, e2.ENAME AS mgr_name
FROM emp e1 RIGHT OUTER JOIN emp e2
	ON e1.MGR  = e2.EMPNO 
ORDER BY e1.EMPNO
;



/*
 * 양측 조인 full-outer-join
 * 
 * 오라클은 양측 조인 불가 = (+) 기호는 한쪽에만 추가 가능
*/
SELECT e1.EMPNO 
	, e1.ENAME 
	, e1.MGR
	, e2.EMPNO AS mgr_no
	, e2.ENAME AS mgr_name
FROM EMP e1 FULL OUTER JOIN EMP e2
	ON e1.MGR = e2.EMPNO 
;


/* 
 * SELF JOIN 4개 테이블을 이용하여 값 출력 
 */
SELECT d.DEPTNO 
	, d.DNAME 
	, e1.EMPNO 
	, e1.ENAME 
	, e1.MGR 
	, e1.SAL 
	, s.LOSAL 
	, s.HISAL 
	, s.GRADE 
	, e2.EMPNO AS mgr_no
	, e2.ENAME AS mgr_name
FROM emp e1
	, dept d
	, SALGRADE s 
	, emp e2
	WHERE e1.DEPTNO(+) = d.DEPTNO 
		AND e1.sal BETWEEN s.LOSAL(+) AND s.HISAL(+)   -- FULL OUTER JOIN 아니고 s.losal이랑 s.hisal 합친거에 + 붙은거
		AND e1.mgr = e2. EMPNO(+)
;



SELECT d.DEPTNO 
	, d.DNAME 
	, e1.EMPNO 
	, e1.ENAME 
	, e1.MGR 
	, e1.SAL 
FROM EMP e1, DEPT d 
WHERE e1.DEPTNO(+) = d.DEPTNO 
;


SELECT
	e1.EMPNO 
	, e1.ENAME 
	, e1.MGR 
	, e1.SAL 
	, s.LOSAL 
	, s.HISAL 
	, s.GRADE 
FROM EMP e1, SALGRADE s 
WHERE e1.sal BETWEEN s.LOSAL(+) AND s.HISAL(+)
;


SELECT d.DEPTNO 
	, d.DNAME 
	, e1.EMPNO 
	, e1.ENAME 
	, e1.MGR 
	, e1.SAL 
	, e2.EMPNO AS mgr_no
	, e2.ENAME AS mgr_name
FROM emp e1
	, emp e2
WHERE e1.mgr = e2.empno(+)
;


SELECT d.DEPTNO 
	, d.DNAME 
	, e1.EMPNO 
	, e1.ENAME 
	, e1.MGR 
	, e1.SAL 
	, s.LOSAL 
	, s.HISAL 
	, s.GRADE 
	, e2.EMPNO AS mgr_no
	, e2.ENAME AS mgr_name
FROM EMP e1 RIGHT JOIN DEPT d
		ON e1.DEPTNO = d.DEPTNO 
	LEFT OUTER JOIN SALGRADE s 
		ON (e1.SAL >= s.LOSAL) AND e1.SAL <= s.HISAL 
	LEFT OUTER JOIN EMP e2
		ON (e1.MGR = e2.EMPNO)
;


SELECT sal 
	FROM EMP e
	WHERE e.ENAME = 'SMITH' 
;



SELECT *
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO 
	AND e.DEPTNO = 20
	AND e.SAL > (SELECT AVG(sal) FROM EMP)
;


/*
 * 단일 행 서브 쿼리 - 쿼리 안에 쿼리 문장을 사용
 * 
 * select쿼리의 결과는 -> 2차원 테이블에 불과 
 */

  

SELECT DEPTNO, ENAME, SAL 
FROM EMP
WHERE Sal IN (SELECT avg(sal)
	FROM EMP
	GROUP BY deptno)
;


SELECT DEPTNO, MAX(sal)   -- sub_query에 해당 
FROM EMP
GROUP BY DEPTNO    -- 그룹별 최고 샐러리 출력
ORDER BY DEPTNO 
;


SELECT *
FROM EMP e
WHERE sal = ANY (sub_query)
;

SELECT MIN(SAL), MAX(SAL)
FROM EMP
WHERE DEPTNO = 30
; 


SELECT *
FROM EMP
WHERE SAL < ANY (SELECT SAL FROM EMP
WHERE DEPTNO = 30)
;


SELECT DEPTNO, SAL, EMPNO, ENAME 
FROM EMP 
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
							FROM EMP 
							GROUP BY DEPTNO)
;

SELECT e.ENAME
	, e.SAL
	, d.DNAME
	, d.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 30) e
		, (SELECT * FROM DEPT) D
WHERE e.DEPTNO = d.DEPTNO
;


WITH E AS (SELECT * FROM EMP WHERE DEPTNO = 20)
	, D AS (SELECT * FROM DEPT)
	, S AS (SELECT * FROM SALGRADE)
SELECT E.ENAME
	, E.SAL
	, D.DNAME
	, D.LOC
	, S.GRADE
FROM E, D, S
WHERE E.DEPTNO = D.DEPTNO
	AND E.SAL BETWEEN S.LOSAL AND S.HISAL
;



/*
 * create table
 * 
 */
CREATE TABLE DEPT_TEMP
	AS (SELECT * FROM DEPT);
	
-- COMMIT;  -- TO confirn IF ANY CHANGE ON db IS 