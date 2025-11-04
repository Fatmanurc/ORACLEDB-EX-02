CREATE USER test_user IDENTIFIED BY testpass;
GRANT CONNECT, RESOURCE TO test_user;
CONNECT test_user/testpass@//localhost:1521/XE;
CREATE TABLE demo (id NUMBER PRIMARY KEY, name VARCHAR2(100));
INSERT INTO demo VALUES (1, 'hello');
COMMIT;
SELECT * FROM demo;
