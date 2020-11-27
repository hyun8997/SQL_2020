--# cmd 상에서 작성함. (계졍 접근 용이성 때문) sqlplus 

-- [ DCL (Data Control Language) ] : 계정에 대한 컨트롤
-- 오라클 서버 DB 사용자
--SYS: 소유자
--SYSTEM: 관리자
--End-User: 최종 사용자 (ex, scott …)

Conn sys/oracle

conn sys/oracle as sysdba
show user

create user user1 		--user 1 계정 생성
identified by tiger;	

conn user1/tiger      --user1 계정 접속 시도
------------------------------------------------------------------------------------------------------------
--<권한>
--1. system: 시스템에 영향을 미치는 권한 : grant 권한 to 사용자명;
--                                       revoke 권한 from 사용자명;
--         : SYS or SYSTEM 이 이 권한을 가짐
--2. object: 해당 object에만 영향을 미치는 권한(저작권): grant 권한 on object명 to 사용자명;
--						revoke 권한 on object명 from 사용자명;
--        : object 생성자가 권한을 가짐

grant connect, resource to user1;		--연결(로그인)과 데이터 소스 사용 권한 부여

select * from scott.emp;	--다른 계정이므로 이렇게 접근 해야 한다. 
--                          하지만, 권한을 scott한테 안받아서 볼 수 없음
--			scott으로 가서 revoke를 통해 object 접근 권한을 줘야 함.

	conn scot/tiger
	grant select on emp to user1;	--user1에게 scott의 emp에 select 권한 부여
	conn user1/tiger
	SELECT * from scott.emp;		--가능

update scott.emp		--update에 대한 권한을 가지지 않아서 에러남, select 만 받았다.
set sal = 100		
where ename = ‘JONES’;	

  conn scot/tiger
  grant update on emp to user1;	--user1에게 scott의 emp에 update 권한 부여
  conn user1/tiger			
  UPDATE scott.emp		
  set sal = 100			
  where ename = ‘JONES’;		--가능

	conn scot/tiger
	revoke select, update on emp to user1;	--권한 뺏기

--user1 삭제
conn system/oracle
drop user user1; 
--drop user user1 cascade; --예전 버전에서만


--다시 user1 생성--
create user user1
identified by tiger;

grant connect, resources to user1;

--user1 pw 변경--
alter user user1
identified by lion

conn user1/lion  -- 새로운 pw로 접속

--password 변경 요구(user1에는 권한이 없어서 system으로 감)
conn system/oracle

create user user2
identified by tiger
password expire   --user2의 pw를 못 쓰게 만듬
account unlock;   --아예 못들어오게 함

grant connect, resource to user2;

conn user2/tiger  --> the password is expired
                  --> Changing password for user2
                  --> New password:
                  --> Retype new password:    --둘다 lion으로 함
                  --> Password changed
                  
conn user2/lion --user2 비번 바꿔서 다시 접속 가능

-- 계정이 존재는 하지만 접근은 안되게 (로그인 금지)
conn system/oracle

alter user user2
account lock;

conn user2/lion  --> the account is locked

-- 잠긴 계정 활성화
conn system/oracle

alter user user2
account unlock;

conn user2/lion  --> Connected.




