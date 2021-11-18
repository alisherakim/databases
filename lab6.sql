create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    charge float
);

INSERT INTO dealer (id, name, location, charge) VALUES (101, 'Ерлан', 'Алматы', 0.15);
INSERT INTO dealer (id, name, location, charge) VALUES (102, 'Жасмин', 'Караганда', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (105, 'Азамат', 'Нур-Султан', 0.11);
INSERT INTO dealer (id, name, location, charge) VALUES (106, 'Канат', 'Караганда', 0.14);
INSERT INTO dealer (id, name, location, charge) VALUES (107, 'Евгений', 'Атырау', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (103, 'Жулдыз', 'Актобе', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Айша', 'Алматы', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Даулет', 'Алматы', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Кокшетау', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Ильяс', 'Нур-Султан', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Алия', 'Караганда', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Саша', 'Шымкент', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Маша', 'Семей', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Максат', 'Нур-Султан', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2012-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2012-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2012-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2012-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2012-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2012-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2012-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2012-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2012-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2012-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2012-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2012-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;

-- 1.
-- a)
select * from dealer inner join client on client.dealer_id = dealer.id;
-- b)
select client.name, city, priority, sell.id, date, amount from dealer join client on client.dealer_id = dealer.id join sell on client.id = sell.client_id;
-- c)
select location, dealer.name, client.name from dealer join client on client.city = dealer.location where client.dealer_id = dealer.id;
-- d)
select sell.id, amount, client.name, city from client join sell on sell.client_id = client.id where 100 < amount and amount < 500;
-- e)
select distinct dealer.id, dealer.name from dealer left outer join client on client.dealer_id = dealer.id order by dealer.id;
-- f)
select distinct dealer.name, client.name, city, charge from client join dealer on dealer.id = client.dealer_id;
-- g)
select client.name, city, dealer.name, charge from dealer join client on dealer.id = client.dealer_id where charge > 0.12;
-- h)
select client.name, city, sell.id, date, amount, dealer.name, charge from client join dealer on client.dealer_id = dealer.id join sell on sell.client_id = client.id;
-- i)
select client.name, city, priority, dealer.name, sell.id, amount from client right outer join dealer on client.dealer_id = dealer.id left outer join sell on client.id = sell.client_id where amount > 2000 and client.priority is not null;

-- 2.
-- a)
create view kru1
as select date, count(distinct sell.client_id), avg(amount), sum(amount) from sell group by date;
-- b)
create view kru2
as select date, amount from sell order by amount desc limit 5;
-- c)
create view kru3
as select dealer.name, count(amount), avg(amount), sum(amount) from sell join dealer on sell.dealer_id = dealer_id group by dealer.name;
-- d)
create view kru4
as select dealer.name, sum(amount * charge) from sell join dealer on sell.dealer_id = dealer.id group by dealer.name;
-- e)
create view kru5
as select location, count(amount), avg(amount), sum(amount) from dealer join sell on sell.dealer_id = dealer.id group by location;
-- f)
create view kru6
as select city, count(amount), avg(amount * (charge + 1)), sum(amount * (charge + 1)) from client join dealer on client.dealer_id = dealer.id join sell on sell.client_id = client.id group by city;
-- g)
create view kru7
as select city, sum(amount * (charge + 1)) as total_expences, sum(amount) as total_amount from client join sell on client.id = sell.client_id join dealer on sell.dealer_id = dealer.id and city = location group by city;
