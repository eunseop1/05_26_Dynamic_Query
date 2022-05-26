-- 05-26
-- scott 계정을 만들고 비번 tiger를 지정하고 권한을 등록해보자
CREATE USER scott identified BY "tiger";
GRANT CONNECT, resource TO scott;
