/*
 * create table
 */

CREATE TABLE dept_temp
	AS (SELECT * FROM DEPT)
;


/*
 * create ... as (select ... from ...) 구문 
 */
SELECT *
FROM dept_temp dt
;


/*
 * insert = 데이터를 입력하는 방식
 * 
 * 기본 구문
 * insert into 테이블명 (칼럼명1, 칼럼명 2, ...)
 * 		value (데이터1, 데이터2, ...)
 * 
 * 단순한 형태
 */
INSERT INTO dept_temp (deptno, dname, loc)
	VALUES (50, 'DATABASE', 'SEOUL')
;

INSERT INTO dept_temp (deptno, dname, loc)
	VALUES (70, 'WEB', NULL)
;

INSERT INTO dept_temp (deptno, dname, loc)
	VALUES (70, 'WEB', NULL)
;

INSERT INTO dept_temp (deptno, dname, loc)
	VALUES (80, 'MOBILE', '')
;

INSERT INTO dept_temp (deptno, loc)
	VALUES (90, 'INCHEON')
;

COMMIT;

SELECT *
FROM DEPT_TEMP DT
;






CREATE TABLE emp_temp AS
	SELECT * FROM EMP
		WHERE 1 <> 1
;

COMMIT;

SELECT * FROM emp_temp;


INSERT INTO emp_temp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (9999, '홍길동', 'PRESIDENT', NULL, '2001/01/01', 6000, 500, 10)
;

INSERT INTO emp_temp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (2111, '이순신', 'MANAGER', 9999, '1994/07/01', 4000, NULL, 20)
;

INSERT INTO emp_temp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (3111, '망고', 'MANAGER', 9999, SYSDATE, 4000, 500, 10)
;


SELECT *
FROM emp_temp
;

INSERT INTO emp_temp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT e.EMPNO
		, e.ENAME
		, e.JOB
		, e.MGR
		, e.HIREDATE
		, e.SAL
		, e.COMM
		, e.DEPTNO
FROM emp e, SALGRADE s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL
	AND s.GRADE = 1
;

SELECT *
	FROM emp_temp
;



/*
 * update문: 필터된 데이터에 대해서 레코드 값을 수정
 */
DROP TABLE DEPT_TEMP2
;

CREATE TABLE dept_temp2
	AS (SELECT * FROM DEPT)
;

SELECT *
FROM dept_temp2
;



/*
 * update
 * set
 */
UPDATE DEPT_TEMP2
SET loc = "SEOUL"
WHERE 
;

ROLLBACK;

SELECT *
FROM EMP
WHERE ROWNUM < 3;

CREATE dept_temp2
SET dname = 'database'
	, loc = 'seoul'
WHERE deptno = 40
;


CREATE TABLE emp_temp2
	AS (SELECT * FROM EMP)
;

COMMIT;

DELETE FROM emp_temp2
WHERE job = 'MANAGER'
;

ROLLBACK;
COMMIT;

DELETE FROM emp_temp2
WHERE empno IN (SELECT empno
					FROM emp_test2 e, SALGRADE s
					WHERE e.sal BETWEEN s.LOSAL AND s.HISAL
					AND s.grade = 3
					AND deptno = 30)
;


SELECT e.empno
	FROM emp_temp2 e, SALGRADE s
	WHERE e.sal BETWEEN s.LOSAL AND s.HISAL
		AND s.GRADE = 3
		AND e.deptno = 30
;


/*
 * CREATE 문을저의 : 기존에 없는 테이블 구조를 생성
 * 
 * 데이터는 없고, 테이블의 칼럼과 데이터타입, 제약조건 등 구조를 생성  
 */


CREATE TABLE emp_new
(	
	empno		NUMBER (4)
	, ename		varchar (10)
	, job		varchar (9)
	, mgr		NUMBER (4)
	, hiredate	DATE
	, SALGRADE	NUMBER (7,2)
	, comm 		number(7,2)
	, deptno	number(2)
)
;



SELECT *
	FROM EMP_NEW
;


ALTER TABLE emp_new
ADD (hp varchar(20))
;


ALTER TABLE EMP_NEW
RENAME COLUMN hp TO TEL_NO
;


ALTER TABLE EMP_NEW
	MODIFY EMPNO number(5)
;

ALTER TABLE EMP_NEW
	DROP COLUMN tel_no
;


CREATE SEQUENCE seq_deptno
	INCREMENT BY 1
	START WITH 1
	MAXVALUE 999
	MINVALUE 1
	nocycle nocache
;

INSERT INTO dept_temp2 (deptno, dname, loc)
	VALUES (seq_deptno.nextval, 'database', 'seoul');
	
INSERT INTO dept_temp2 (deptno, dname, loc)
	VALUES (seq_deptno.nextval, 'web', 'busan');
	
INSERT INTO dept_temp2 (deptno, dname, loc)
	VALUES (seq_deptno.nextval, 'mobile', 'ilsan');
	


/*
 * 졔약 조건
 * 
 * 테이블을 생성할 때, 테이블 칼럼별 제약 조건을 설정
 * 
 * 자주 사용되는 중요한 제약조건 유형
 * Not Null
 * Unizque
 * PK
 * FK
 */

CREATE TABLE login 
(
	log_id 		varchar2(20)	NOT NULL
	, log_pwd	varchar2(20)	NOT NULL
	, tel		varchar2(20)
);

INSERT INTO login (log_id, log_pwd, tel)
	VALUES ('test01', '1234')
;

INSERT INTO login (log_id, log_pwd, tel)
	VALUES ('test02', '1234', '01039404503')
;

SELECT *
FROM login
;


/*
 * tel에 not null 조건 추가
 */
ALTER TABLE login 
MODIFY tel NOT NULL
;


/*
 * tel 없는 고객이 발견되어, 어렵게 전화번호를 구함
 */
UPDATE login
SET tel = '01012345678'
WHERE log_id = 'test02'
;

--ALTER TABLE login
--	MODIFY (tel CONSTRAINT tel_nn NOT null)
;

ALTER TABLE login 
DROP CONSTRAINT SYS_COO7040
;




CREATE TABLE log_unique
(
	log_id 			varchar2(20)   UNIQUE
	, log_pwd		varchar2(20)	NOT NULL 
	, tel 			varchar2(20)
)
;


SELECT * 
FROM USER_CONSTRAINTS
WHERE table_name = 'LOG_UNIQUE'
;

INSERT INTO log_unique (log_id, log_pwd, tel)
VALUES ('test01', 'pwd0202', '01056781239')
;

INSERT INTO log_unique (log_id, log_pwd, tel)
VALUES ('test03', 'pwd0202', '01056781235')
;

INSERT INTO log_unique (log_id, log_pwd, tel)
VALUES ('test04', 'pwd0202', '01056781237')
;


SELECT *
FROM log_unique
;

UPDATE log_unique
SET log_id = 'test_id_new'
WHERE log_id IS NULL
;

ALTER TABLE log_unique
modify(tel unique)
;


/*
 * pk(주키, Primary key) : 테이블을 설명하는 가장 중요한 키
 * 
 * not null + unique + index
 */
CREATE TABLE log_pk
(
	log_id		varchar2(20) PRIMARY KEY
	, log_pwd 	varchar2(20) NOT NULL
	, tel		varchar2(20)
)
;

INSERT INTO log_pk (log_id, log_pwd, tel)
VALUES ('pk01', 'pwd01', '01012345567')
;

-- 기존 고객의 Id와 동일한 Id 입력하는 경우
-- log_id (pk 제약조건 위반)
INSERT INTO log_pk (log_id, log_pwd, tel)
VALUES ('pk01', 'pwd02', '01012345569')
;

INSERT INTO log_pk (log_id, log_pwd, tel)
VALUES ('pwd02', '01012345560')
;



SELECT *
FROM EMP_TEMP
;


/* 
 * 존재하지 않는 부서번호를 EMP_TEMP 테이블에 입력을 시도
 */
INSERT INTO EMP_TEMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)
	values(3333, '밤빵', 'cat', 0820, sysdate, 1200, NULL, 99)
;

/* 
 * 존재하지 않는 부서번호를 EMP 테이블에 입력을 시도
 */
INSERT INTO EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)
	values(3333, '밤빵', 'cat', 0820, sysdate, 1200, NULL, 99)
;




/*
 * index 빠른 검색을 위한 색인
 * 
 * 장점: 원하는 값을 빠르게 찾아준다
 * 단점: 입력과 출력이 잦은 경우, 인덱스가 설정된 테이블의 속도가 저하된다
 */

-- 특정 직업군에 해당하는 직원을 빠르게 찾기 위한 색인 지
CREATE INDEX idx_emp_job
	ON emp(job)
;

SELECT *
FROM DBA_INDEXES
WHERE TABLE_NAME IN ('EMP', 'DEPT')
;


CREATE VIEW vw_emp
AS (SELECT empno, ename, job, deptno
	FROM EMP WHERE DEPTNO = 10)
;

SELECT *
FROM USER_VIEWS
WHERE view_name = 'vw_emp'
;



/*
 * rownum 사용 : 상위 n개를 출력하기 위해 사용하며
 * 칼럼에 rownum 순번을 입력하여 사용할 수 있음
 */
SELECT rownum
	, E.*
FROM EMP e
ORDER BY SAL DESC
;

SELECT rownum, a.*
FROM (SELECT *
	FROM EMP
	ORDER BY SAL DESC) a
;


SELECT rownum
	, a.*
FROM (SELECT *
	FROM EMP
	ORDER BY SAL DESC) a
WHERE rownum <= 5
;


/*
* 오라클 dbms에서 관리하는 관리 테이블 리스트 출력
*/
SELECT *
FROM DICT
WHERE TABLE_NAME like 'USER_CON%'
;

SELECT *
FROM dba_tables
WHERE TABLE_NAME like 'EMP%'
;

SELECT *
FROM DBA_USERS
WHERE USERNAME like 'SCOTT%'
;