/*
 * transaction test
 * 
 * 테이블 create -> insert -> update -> delete
 */

CREATE TABLE dept_tcl
	AS SELECT * 
		FROM TEST.DEPT;
	
SELECT * 
FROM dept_tcl
;

INSERT 
INTO dept_tcl 
VALUES(50, 'database', 'seoul');

SELECT * 
FROM dept_tcl;

UPDATE dept_tcl 
SET loc = 'BUSAN' 
WHERE deptno = 40
;

DELETE 
FROM dept_tcl 
WHERE dname = 'RESEARCH'
;

SELECT * 
FROM dept_tcl
;

ROLLBACK;


-- commit 실행하는 경우
INSERT INTO dept_tcl
VALUES (50, 'NETWORK', 'SEOUL')
;

UPDATE dept_tcl
SET loc = 'BUSAN'
WHERE deptno = 20
;

DELETE FROM dept_tcl WHERE deptno = 40;

SELECT *
FROM dept_tcl
;

COMMIT;

SELECT *
FROM dept_tcl
;

DELETE FROM dept_tcl
WHERE deptno = 50
;



/*
 * LOCK 테스트
 * 
 * 동일한 계정으로 dbeaver 세션과 sqlplus 세션을 열어 데이터를 수정하는 동시작업을 수행
 */
UPDATE dept_tcl
SET loc = 'DAEGU'
WHERE deptno = 30
;


-- SQL plus에서 실행중인 직원의 업데이트 시도를 막고있는 상황을 모르고 있을 수도 있음

SELECT *
FROM dept_tcl 
;  -- SQL plus에서는 daegu 업데이트 결과가 안보임  

COMMIT;  -- SQL plus에서도 UPDATE 결과가 보이게 됨

/*
 * tuning 기초 : 자동차 튜닝과 같이 db 처리 속도와 안정성 제고 목적의 경우가 대부분 
 */
SELECT *
FROM TEST.EMP WHERE substr(empno, 1, 2) = 75 -- 암묵적 형변환 2번 
AND LENGTH (empno) = 4 -- 불필요한 비교 
;

SELECT * FROM TEST.EMP
WHERE empno > 7499
	AND EMPNO < 7600
;

-- 튜닝 전후 비교
SELECT *
FROM TEST.EMP
WHERE ENAME || ' ' || job = 'WARD SALESMAN'
;

SELECT *
FROM TEST.EMP
WHERE ENAME = 'WARD'
	AND job = 'SALESMAN'
;



-- 튜닝 전후 비교 
SELECT *
FROM TEST.EMP WHERE deptno = '10'
UNION
SELECT *
FROM TEST.EMP WHERE deptno = '20'
;

SELECT *
FROM TEST.EMP
WHERE DEPTNO = 10
UNION ALL
SELECT *
FROM TEST.EMP
WHERE DEPTNO = 20
;



-- 튜닝 전후 비교 
SELECT ENAME
	, EMPNO
	, SUM(SAL)
FROM TEST.EMP
GROUP BY ENAME, EMPNO
;


SELECT EMPNO, ENAME, SUM(SAL)
FROM TEST.EMP
GROUP BY EMPNO, ENAME
;



-- 튜닝 전후 비교 
SELECT EMPNO
	, ENAME
FROM TEST.EMP
WHERE TO_CHAR(HIREDATE, 'YYYYMMDD') LIKE '1981%'  -- 동일한 데이터타입 
	AND EMPNO > 7700
;

SELECT EMPNO, ENAME
FROM TEST.EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981 -- 동일한 데이터타입 Integer
	AND EMPNO > 7700
;

SELECT *
FROM DBA_indexes
WHERE TABLE_name LIKE 'EMP';


DROP INDEX idx_emp_job
;   -- 이거 안됨~~~~~~~~~ 어ㅔ 안되는지 알려주실 분~~~~~~~~~~~~~~~~~~~~~~~~~~~~

COMMIT;



/*
 * [복습] group by, join 테이블을 중심으로 반복 학습
 * - rollup, cube, grouping set 등 집계함수 사용 
 * 
 * GROUP BY 구문 : 집계 함수를 사용하여 값을 표시
 */
SELECT DEPTNO
FROM EMP
GROUP BY DEPTNO
;

SELECT DEPTNO
	, JOB
	, FLOOR(AVG(SAL)) AS AVG_SAL
FROM EMP
GROUP BY JOB, DEPTNO
HAVING AVG(SAL) >= 2000
ORDER BY JOB, DEPTNO
;


/*
 * LISTAGG, PIVOT, ROLLUP, CUBE, GROUPING SET
 */


SELECT deptno

