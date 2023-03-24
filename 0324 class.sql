SELECT *
FROM emp E1 RIGHT JOIN dept D
      ON E1.DEPTNO = D.DEPTNO 
   LEFT JOIN salgrade S
      ON E1.SAL BETWEEN s.LOSAL AND s.HISAL 
   LEFT JOIN emp E2 
      ON E1.MGR = E2.EMPNO 
;


SELECT DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO
;

SELECT *
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MIN(SAL))
FROM EMP
GROUP BY DEPTNO
;


DROP TABLE EMP_NEW
;

CREATE TABLE EMP_NEW
(
	EMPNO		NUMBER(4)
	,ENAME      VARCHAR2(10)
	,JOB 		VARCHAR2(9)
	,MGR  		NUMBER(4)
	,HIREDATE	DATE
	,SAL		NUMBER(7,2)
	,COMM 		NUMBER(7,2)
	,DEPTNO		NUMBER(2)
);

ALTER TABLE EMP_NEW
	ADD TEL VARCHAR(20)
;

COMMIT;

ALTER TABLE EMP_NEW
MODIFY EMPNO NUMBER(5)
;

COMMIT;


ALTER TABLE EMP_NEW
DROP COLUMN TEL;

SELECT * FROM EMP_NEW;


CREATE SEQUENCE SEQ_DEPTSEQ
	INCREMENT BY 1
	START WITH 1
	MAXVALUE 99
	MINVALUE 1
	NOCYCLE NOCACHE;
	
CREATE TABLE DEPTSEQ AS SELECT * FROM DEPT;

INSERT INTO DEPTSEQ
VALUES (SEQ_DEPTSEQ.NEXTVAL, 'DATATBASE', 'SEOUL')
;

                                                                                                          