CREATE TABLE SALESMAN(
SALESMAN_ID INTEGER PRIMARY KEY,
NAME VARCHAR(20),
CITY VARCHAR(20),
COMMISSION VARCHAR(20));

DESC SALESMAN;




CREATE TABLE CUSTOMER(
CUSTOMER_ID INTEGER PRIMARY KEY,
CUST_NAME VARCHAR(20),
CITY VARCHAR(20),
GRADE INTEGER,
SALESMAN_ID INTEGER,
FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID) ON DELETE SET NULL);

DESC CUSTOMER;




CREATE TABLE ORDERS(
ORDER_NO INTEGER PRIMARY KEY,
PURCHASE_AMOUNT DECIMAL(10,2),
ORDER_DATE DATE,
CUSTOMER_ID INTEGER,
SALESMAN_ID INTEGER,
FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)ON DELETE CASCADE,
FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID) ON DELETE CASCADE);

DESC ORDERS;


INSERT INTO SALESMAN VALUES(1000,'RAHUL','BANGALORE','20%');
INSERT INTO SALESMAN VALUES(2000,'ANKITA','BANGALORE','25%');
INSERT INTO SALESMAN VALUES(3000,'SHARMA','MYSORE','30%');
INSERT INTO SALESMAN VALUES(4000,'ANJALI','DELHI','15%');
INSERT INTO SALESMAN VALUES(5000,'RAJ','HYDERABAD','15%');

SELECT * FROM SALESMAN;



INSERT INTO CUSTOMER VALUES(1,'ADYA','BANGALORE',100,1000);
INSERT INTO CUSTOMER VALUES(2,'BANU','MANGALORE',300,1000);
INSERT INTO CUSTOMER VALUES(3,'CHETHAN','CHENNAI',400,2000);
INSERT INTO CUSTOMER VALUES(4,'DANISH','BANGALORE',200,2000);
INSERT INTO CUSTOMER VALUES(5,'ESHA','BANGALORE',400,3000);

SELECT * FROM CUSTOMER;



INSERT INTO ORDERS VALUES(201,5000,'2020-06-02',1,1000);
INSERT INTO ORDERS VALUES(202,450,'2020-04-09',1,2000);
INSERT INTO ORDERS VALUES(203,1000,'2020-03-15',3,2000);
INSERT INTO ORDERS VALUES(204,3500,'2020-07-09',4,3000);
INSERT INTO ORDERS VALUES(205,550,'2020-05-05',2,2000);

SELECT * FROM ORDERS;

SELECT GRADE,COUNT(DISTINCT CUSTOMER_ID)
FROM CUSTOMER
GROUP BY GRADE
HAVING GRADE>(SELECT AVG(GRADE)
FROM CUSTOMER
WHERE CITY='BANGALORE');




SELECT SALESMAN_ID, NAME
FROM SALESMAN S
WHERE (SELECT COUNT(*)
FROM CUSTOMER C
WHERE C.SALESMAN_ID=S.SALESMAN_ID) > 1;




SELECT S.SALESMAN_ID, S.NAME, C.CUST_NAME, S.COMMISSION
FROM SALESMAN S, CUSTOMER C
WHERE S.CITY=C.CITY
UNION
SELECT S.SALESMAN_ID,S.NAME,'NO MATCH',S.COMMISSION
FROM SALESMAN S
WHERE CITY NOT IN 
(SELECT CITY
FROM CUSTOMER)
ORDER BY 1 ASC;




CREATE VIEW V_SALESMAN AS
SELECT O.ORDER_DATE, S.SALESMAN_ID, S.NAME
FROM SALESMAN S,ORDERS O
WHERE S.SALESMAN_ID = O.SALESMAN_ID
AND O.PURCHASE_AMOUNT= (SELECT MAX(PURCHASE_AMOUNT)
FROM ORDERS C
WHERE C.ORDER_DATE=O.ORDER_DATE);

SELECT * FROM V_SALESMAN;




DELETE FROM SALESMAN
WHERE SALESMAN_ID=1000;

SELECT * FROM SALESMAN;

SELECT * FROM ORDERS;
