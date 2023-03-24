/*
 * 222p (1)
 */
CREATE TABLE DEPT_TEST
	AS SELECT * FROM DEPT
;

SELECT *
FROM DEPT_TEST
;

INSERT INTO DEPT_TEST (DEPTNO, DNAME, LOC)
	VALUES (50, 'ORACLE', 'BUSAN')
;

INSERT INTO DEPT_TEST (DEPTNO, DNAME, LOC)
	VALUES (60, 'SQL', 'ILSAN')
;

INSERT INTO DEPT_TEST (DEPTNO, DNAME, LOC)
	VALUES (70, 'SELECT', 'INCHEON')
;

INSERT INTO DEPT_TEST (DEPTNO, DNAME, LOC)
	VALUES (80, 'DML', 'BUNDANG')
;

SELECT *
FROM DEPT_TEST
;



/*
 * 222p (2)
 */
CREATE TABLE EMP_TEST
	AS SELECT * FROM EMP
;

SELECT *
FROM EMP_TEST
;

INSERT INTO EMP_TEST (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (7201, 'TEST_USER1', 'MANAGER', 7788, TO_DATE('2016/01/02', 'YYYY/MM/DD'), 4500, NULL, 70)
;

INSERT INTO EMP_TEST (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (7202, 'TEST_USER2', 'CLERK', 7201, TO_DATE('2016/02/21', 'YYYY/MM/DD'), 1800, NULL, 50)
;

INSERT INTO EMP_TEST (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (7203, 'TEST_USER3', 'ANALYST', 7201, TO_DATE('2016/04/11', 'YYYY/MM/DD'), 3400, NULL, 70)
;

INSERT INTO EMP_TEST (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (7204, 'TEST_USER4', 'SALESMAN', 7201, TO_DATE('2016/05/31', 'YYYY/MM/DD'), 2700, NULL, 60)
;

INSERT INTO EMP_TEST (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (7205, 'TEST_USER5', 'CLERK', 7201, TO_DATE('2016/07/20', 'YYYY/MM/DD'), 2600, NULL, 70)
;

INSERT INTO EMP_TEST (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (7206, 'TEST_USER6', 'CLERK', 7201, TO_DATE('2016/09/08', 'YYYY/MM/DD'), 2600, NULL, 70)
;

INSERT INTO EMP_TEST (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (7207, 'TEST_USER7', 'LECTURER', 7201, TO_DATE('2016/10/28', 'YYYY/MM/DD'), 2300, NULL, 80)
;

INSERT INTO EMP_TEST (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (7208, 'TEST_USER8', 'STUDENT', 7201, TO_DATE('2018/03/09', 'YYYY/MM/DD'), 1200, NULL, 80)
;



/*
 * 223p (3)
 */
UPDATE EMP_TEST
SET DEPTNO = 70
WHERE SAL > (SELECT AVG(SAL) FROM EMP_TEST WHERE DEPTNO = 50)
;

SELECT DEPTNO
	, SAL
	, EMPNO
	, ENAME
	, JOB
FROM EMP_TEST
ORDER BY ENAME ASC
;



/*
 * 223p (4)
 */
UPDATE EMP_TEST
SET DEPTNO = 80, SAL = SAL * 1.2
WHERE (DEPTNO, SAL) IN
	(SELECT DEPTNO, SAL
		FROM (SELECT ROWNUM AS ROW_NUM, DEPTNO, SAL
				FROM (SELECT DEPTNO, SAL
                		FROM EMP_TEST
                		WHERE DEPTNO = 30
               			ORDER BY HIREDATE))
                WHERE ROW_NUM > 1)
;

SELECT DEPTNO
	, SAL
	, EMPNO
	, ENAME
	, JOB
FROM EMP_TEST
ORDER BY EMPNO
;

/*
 * 228p (1)
 */
CREATE TABLE EMP_USER (
    EMPNO NUMBER(5),
    ENAME VARCHAR2(20),
    JOB VARCHAR2(10),
    MGR NUMBER(5),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    DEPTNO NUMBER(2)
)
;



/*
 * 228p (2)
 */
ALTER TABLE EMP_USER ADD NOW_DATE DATE
;
ALTER TABLE EMP_USER ADD RESIGN_DATE DATE
;



/*
 * 228p (3)
 */
ALTER TABLE EMP_USER ADD SUR_NAME CHAR(5)
;



/*
 * 228p (4)
 */
ALTER TABLE EMP_USER MODIFY SUR_NAME CHAR(10)
;



/*
 * 228p (5)
 */
ALTER TABLE EMP_USER RENAME COLUMN ENAME TO FULL_NAME
;



/*
 * 마지막 페이지
 *
(1) 제약조건 
(2) unique
(3) not null
(4) primary key
(5) foreign key
*
*/



/* 
이론과제 3일차

3-1
(1) 원자성
(2) 완전 함수적 종속
(3) 이행적 종속 제거

3-2
(1) 제3정규화
(2) 제2정규화

3-3
(1) inner join
(2) left join
(3) right join
(4) outer join

3-4
(1) 반정규화

3-5
(1) 인덱스
(2) 인덱스
(3) 인덱스
(4) 인덱스

3-6
(1) 트랜잭션
(2) Atomicity(원자성)
(3) Consistency(일관성)
 */