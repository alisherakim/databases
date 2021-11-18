create table customers (
    id integer primary key,
    name varchar(255),
    birth_date date
);

create table accounts(
    account_id varchar(40) primary key ,
    customer_id integer references customers(id),
    currency varchar(3),
    balance float,
    "limit" float
);

create table transactions (
    id serial primary key ,
    date timestamp,
    src_account varchar(40) references accounts(account_id),
    dst_account varchar(40) references accounts(account_id),
    amount float,
    status varchar(20)
);

INSERT INTO customers VALUES (201, 'John', '2021-11-05');
INSERT INTO customers VALUES (202, 'Anny', '2021-11-02');
INSERT INTO customers VALUES (203, 'Rick', '2021-11-24');

INSERT INTO accounts VALUES ('NT10204', 201, 'KZT', 1000, null);
INSERT INTO accounts VALUES ('AB10203', 202, 'USD', 100, 0);
INSERT INTO accounts VALUES ('DK12000', 203, 'EUR', 500, 200);
INSERT INTO accounts VALUES ('NK90123', 201, 'USD', 400, 0);
INSERT INTO accounts VALUES ('RS88012', 203, 'KZT', 5000, -100);

INSERT INTO transactions VALUES (1, '2021-11-05 18:00:34.000000', 'NT10204', 'RS88012', 1000, 'commited');
INSERT INTO transactions VALUES (2, '2021-11-05 18:01:19.000000', 'NK90123', 'AB10203', 500, 'rollback');
INSERT INTO transactions VALUES (3, '2021-06-05 18:02:45.000000', 'RS88012', 'NT10204', 400, 'init');

-- 1. Large objects are stored separate from the table because they typically store a large amount of data.
-- 2. Privileges control the ability to run SQL statements. A role is a group of privileges. And users have permission to log in by default.

--a)
create role accountant;
create role administrator;
create role support;
grant all privileges on accounts to accountant;
grant all privileges on customers to administrator;
grant all privileges on transactions to support;
--b)
create user aminamatova with password 'Kukuruza26';
create user Matik with password 'kartoshka 75';
create user anyone23 with password 'user111';

grant accountant to aminamatova;
grant administrator to Matik;
grant support to anyone;
--c)
grant administrator to accountant, support;
--d)
revoke select on accounts from accountant;
revoke update on transactions from support;

--3.
--b)
alter 

--5.
--a)
create unique index index_of_customers on accounts(customer_id, currency);
--b)
create index index_of_transactions on accounts(currency, balance);

--6.
--a)
begin;
--b)
update accounts set balance = balance + 100 where account_id = 'NT10204';
update accounts set balance = balance - 100 where account_id = 'RS88012';
commit;
--c)
if balance < limit where account_id = 'RS88012' then rollback;
else commit;
--d)
update accounts set balance = balance + 100 where account_id = 'NT10204';
update accounts set balance = balance - 100 where account_id = 'RS88012';
commit;