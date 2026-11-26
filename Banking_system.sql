create database Banking_System;   -- created Database
use Banking_System;  -- accessed the database




show databases;
show tables;
use banking_system;
CREATE table CUSTOMERS(
CUSTOMERID int,
FIRSTNAME varchar(50),
LASTNAME varchar(50),
EMAIL VARCHAR(50),
PHONE varchar(10));

describe TABLE CUSTOMERS;
describe CUSTOMERS;

SELECT * 
from CUSTOMERS;

ALTER TABLE CUSTOMERS
ADD COLUMN ACCOUNTCREATIONDATE DATE;  -- MODYFYING TABLE

DESCRIBE CUSTOMERS;

SELECT * 
from CUSTOMERS; 

CREATE TABLE ACCOUNT(
ACCOUNTID INT,
ACCOUNTTYPE varchar(50),
BALANCE DECIMAL(10,2));

create TABLE TRANSACTIONS(
TRANSACTIONID INT,
TRANSACTIONDATE DATE,
AMOUNT DECIMAL(10,2),
TRANSACTIONTYPE VARCHAR(20));

CREATE TABLE BRANCHES(
BRANCHID INT,
BRANCHNAME varchar(100),
BRANCHADDRESS VARCHAR(255),
BRANCHPHONE varchar(20));

SELECT * 
from transactions;

SELECT * 
from branches;

create table accountbranches(
ASSIGNDATE DATE);

CREATE TABLE LOANS(
LOADID INT,
LOANAMOUNT DECIMAL(10,2),
INTRESTRATE DECIMAL(5,2),
STARTDATE DATE,
ENDDATE DATE);

SHOW tables;

ALTER TABLE CUSTOMERS
DROP COLUMN  ACCOUNTCREATIONDATE; 
SELECT  * 
FROM CUSTOMERS;

ALTER TABLE CUSTOMERS
ADD COLUMN BIRTHDATE DATE;

ALTER TABLE CUSTOMERS
MODIFY PHONE VARCHAR(20),
ADD primary key(CUSTOMERID);

DESCRIBE CUSTOMERS;

DROP TABLE ACCOUNTBRANCHES;

use banking_system;
select *
from account;

alter table account
add customerid int;

alter table account
add constraint
foreign key(customerid)
references customers(customerid);

describe account;

alter table account
add primary key(accountid);

alter table transactions
add column accountid int,
add constraint
foreign key(accountid)
references accounts(accountid);

describe account;
describe transactions;

alter table transactions
add primary key(transactionid);

describe transactions;
alter table branches
add primary key(branchid);

alter table account
add branchid int,
add constraint
foreign key(branchid)
references branches(branchid);

alter table loans
add primary key(loadid),
add customerid int,
add constraint
foreign key(customerid)
references customers(customerid);

alter table customers
modify firstname varchar(50) not null,
modify email varchar(50) unique;

describe customers;

-- Adding Records inside the tables

INSERT INTO CUSTOMERS VALUE
(101,'Rahul','Sharma','rahul.sharma@gmail.com','9767983712','1995-04-12');

SELECT * 
FROM CUSTOMERS;

INSERT INTO CUSTOMERS VALUE
(102,'Veena','Kutty','veena.kutty@gmail.com','1234567890','1997-09-10'),
(103,'Dominic','Dom','dominic.dom@gmail.com',NULL,'1996-06-03'),
(104,'Alex',NULL,'alex@gmail.com','3232323232','2000-12-12'),
(105,'Alice','George',NULL,'9090909090','2003-08-10');

-- Example to show that Primary Key does not take null values

-- INSERT INTO CUSTOMERS VALUE
-- (NULL,'Rahul','Sharma','rahul.sharma@gmail.com','9767983712','1995-04-12');

INSERT INTO BRANCHES (BRANCHID,BRANCHNAME,BRANCHADDRESS,BRANCHPHONE)
VALUES (1,'Mumbai Main Branch','Andheri East, Mumbai','0220100201'),
(2,'Pune Central Branch','Shivaji Nagar, Pune','0220100202'),
(3,'Bangalore Branch','MG Road, Bangalore','0880100801'),
(4,'Delhi Branch','Connaught Palace,Delhi',NULL),
(5,'Hyderbad Branch',NULL,'0440100401');

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO ACCOUNTS VALUES
(1001,'Savings',25000,101,1),
(1002,'Current',85000.50,102,2),
(1003,'Savings',12500.75,103,1),
(1004,'Salary',45000,104,3),
(1005,'Savings',7800.25,105,2),
(1006,'Savings',42000,101,2),
(1007,'Current',NULL,103,3),
(1008,'Savings',27500,105,4);

INSERT INTO TRANSACTIONS VALUES
(5001,'2026-01-05',10000,'Deposit',1001),
(5002,'2026-01-10',2500,'Withdrawal',1001),
(5003,'2026-01-15',5000,'Transfer',1002),
(5004,'2026-01-20',15000,'Deposit',1003),
(5005,'2026-01-25',3000,'Withdrawal',1004),
(5006,'2026-02-02',7500,'Deposit',1005),
(5007,'2026-02-05',1200,'Payment',1006),
(5008,'2026-02-10',NULL,'Deposit',1007),
(5009,'2026-02-15',8500,'Withdrawal',1008),
(5010,NULL,100,'Payment',1003),
(5011,'2026-02-20',20000,'Transfer',1006),
(5012,'2026-03-01',5000,'Deposit',1002),
(5013,'2026-03-05',10000,'Withdrawal',1007),
(5014,'2026-03-15',1500,'Deposit',1008),
(5015,'2026-03-20',25000,'Transfer',1005);

INSERT INTO LOANS VALUES
(9001,500000,8.50,'2025-01-15','2030-01-15',101),
(9002,250000,9.25,'2025-03-10','2028-03-10',103),
(9003,NULL,9.00,'2026-03-01',NULL,105),
(9004,750000,7.90,'2024-06-20','2031-06-20',102),
(9005,1000000,7.25,'2024-11-15','2034-11-15',104),
(9006,300000,10.50,'2025-07-01','2029-07-01',101);

-- Checking the Data

SELECT * 
FROM CUSTOMERS;

SELECT * 
FROM BRANCHES;

SELECT * 
FROM ACCOUNTS;

SELECT * 
FROM TRANSACTIONS;

SELECT * 
FROM LOANS;

-- How many customers are there?
select count(*)as total_customers from Customers;

-- which customers have missing information?
select * from Customers where lastname is null or email is null or phone is null;

-- Who are the youngest/oldest customers?
select min(birthdate)as oldest, max(birthdate)as youngest from customers;

-- How many customers were born after 2000
select * from customers where year(birthdate) >= 2000;

-- How many custmers were born before 2000
select * from customers where year(birthdate) <= 2000;

-- Which customers have multiple accounts?
select customerid, count(*) as total_accounts from accounts group by customerid having count(*) >= 2;

-- WHICH ACCOUNT HAVE NULL BAKANCES?
SELECT * FROM ACCOUNTS WHERE BALANCE = NULL;

use banking_system;

-- which branch manages the most accounts
select branchid, count(accountid) as total_acc from accounts group by branchid order by total_acc DESC limit 1;

-- transaction Analysis
select * from transactions;

-- What is the total transaction amount?
select sum(amount)as total_amount from transactions;

-- how many deposits/withdrawals/transfers are there?

select transactiontype, count(*) as count_ from transactions group by transactiontype;

select transactiontype, count(*)as count_  from transactions where transactiontype in ('Deposit','Withdrawal','transfer') group by transactiontype;

-- which transaction tpye has the highest volume 
select transactiontype, sum(amount)as total_amount from transactions group by transactiontype order by total_amount desc limit 1;

-- which account has the highest transaction activity?
select accountid, count(*) as transaction_ from transactions group by accountid order by transaction_ desc limit 1;

-- what is the average transaction amount?
select avg(amount) as avg_amout from transactions ;

-- which transactions have missing dates/ amounts?
select * from transactions where transactiondate is null OR Amount is null;

-- Loan Analysis 

-- what is the total loan amount?
select sum(loanamount) as loanamount_ from loans;

-- which customer has the largest loan?
select * from loans;

select customerid, sum(loanamount)as loan_am from loans group by customerid order by loan_am desc limit 1;

-- which loan has the highest interest rate?
select loanid,max(intrestrate) as intereset_rate from loans group by loanid;

-- which loans are still active 
select * from loans;

select * from loans where enddate >= '2026-11-17';
select * from loans where enddate >=  now();
select * from loans where year(enddate) >= 2026;

-- which customers have multiple loans?
select customerid, count(*)as count_ from loans group by customerid having count_ >1;

-- what is the average loan amount?
select avg(loanamount) avg_am from loans;

-- Branch Analysis 

-- which branch has the most customers/accounts
select branchid, count(*) total_ac from accounts group by branchid order by total_ac desc limit 1;

-- branch with most customers 
select branchid, count(customerid) as Total_customers from accounts group by branchid order by Total_customers desc limit 1;


use banking_system;
-- which branch has the highest totla account balance?
select branchid, sum(balance) total_acc_balance from accounts group by Branchid order by Total_acc_balance desc limit 1 ;

--  which  branch handles the most transactions

-- Account with max transactions?

select accountid, count(*) total_transactions from transactions group by accountid order by total_transactions desc limit 1 ;

-- branch with max transactions?
select branchid from accounts where accountid = 1003;

-- -----------------------Joins 
select branchname, count(transactionid) as total_transactions from accounts as a join branches as b on 
a.branchid = b.branchid join transactions t on a.accountid = t.accountid
 group by branchname order by total_transactions desc limit 1 ;
 
 -- customer with max loan amount
 select customerid, sum(loanamount) total_loan_amount from loans group by customerid order by total_loan_amount desc limit 1;
 
 -- Branch with max loan amount 
 
 
 use banking_system;
 
 select branchid from accounts where customerid = 104;
 
 
 
 -- Functiosn
 
 -- String Function
--  CONCAT() combines multiple strings

select customerid, concat(firstname, " ", lastname) as full_name from customers;

-- Upper 
-- it converts the cases into upper cases

select customerid, upper(concat(firstname," ", lastname)) as Full_name from customers;

-- lower
select customerid, lower(concat(firstname," ",Lastname)) as full_name from customers;

-- length()
-- finds the number of length
select firstname, length(firstname) as namelength from customers having namelength <= 5 
order by namelength desc limit 1 offset 1;

-- offset is used to skip the value

-- char length
-- calculates the number of strings

select firstname, char_length(firstname) as character_length from customers ;

-- Left()
-- extract data from the left side 
select firstname, left(firstname ,3)as first_3_char from customers;

-- right()
select phone, right(phone,4) as last4digits from customers;

-- Display masked accounts
select customerid, concat("XXXXXX",right(phone,4)) as masket_phone from customers;

-- substring()
-- it extracts the portion of a string

select email, substring(email,1,5)as email_part from customers;

-- substring_index()
select email, substring_index(email,"@",1) as email_part from customers;

-- trim 
-- removes useless spaces

select trim("Veena Kutty     ") as Name;

-- Replace ()
-- replace values
select email, replace(email,"gmail","email") as Emails from customers;

-- locate()
-- finds the positons of the character/ string

select email, locate("@",email) as position from customers;

-- Math Functions

-- Round()
-- round off the decimal calues
select accountid, balance, round(balance,0) as rounede_balance from accounts;

-- ceil/ceiling()
-- it rounds up the value

select accountid, balance, ceil(balance)as roundup from accounts;

-- floot()
-- it rounds doen the value

select balance, floor(balance) as rounddown from accounts; 

-- ABD
-- returns the absolute value

select abs(-5465) as absolute_value;

-- mod()
-- returns remailiing value

select accountid, mod(accountid,2) as reminder from accounts;

-- case then end id just like if_ else statement

select accountid, mod(accountid,2) as reminder, 
case when mod(accountid,2)=0 then "Even"
else "Odd"
end as ID_TYPE
from accounts;

-- power()
-- works like indices 

select power(2,4) as result;

-- sqrt()
-- returns the square root of the value

select balance, sqrt(balance) as sqrt_balance from accounts;

-- greatest()
-- compares values

select accountid, balance, greatest(balance,25000) as minimum_balance from Accounts;

-- least()
-- compares values

select accountid, balance, least(balance,50000) as max_limit from accounts;

-- calculate annual interest

select loanid, loanamount, intrestrate, round(loanamount * intrestrate / 100,2) as annual_interest from loans;

-- loan amount + intrest
select loanid, loanamount, intrestrate, round(loanamount + (loanamount * intrestrate /100),2) as 
principal_plus_1year_intrest from loans;

-- balance category

select accountid, balance, case 
when balance is null then "Unkonwn"
when balance < 10000 then "Low"
when balance < 50000 then "medium"
else "High"
end as balance_category from accounts;

-- date and time functions

select curdate() as today;  -- today's date
select sysdate() as today; -- today's date with time

-- Year()
select customerid, birthdate, year(birthdate) as birth_year from customers;

-- months()
select customerid, birthdate, month(birthdate) as birth_month from customers;

select customerid, birthdate, monthname(birthdate) as birth_month from customers;

select transactionid, transactiondate, monthname(transactiondate) as transcation_month from transactions;

-- day()
select transactionid, transactiondate, day(transactiondate) as day_ from transactions;

-- dayname()
select transactionid, transactiondate, dayname(transactiondate) as day_name from transactions;

-- quarter()
select transactionid, transactiondate, quarter(transactiondate) as quarter_ from transactions;

-- which quarter has most transactions 
select quarter(transactiondate) as quarters, count(*) as transaction_count, sum(amount) as total_amount from transactions
where transactiondate is not null 
group by quarter(transactiondate);

-- datediff()

select loanid, startdate, enddate, datediff(enddate,startdate) as loan_days from loans;

-- calculate loan duration in years

select loanid, startdate, enddate, round(datediff(enddate,startdate)/365,2) as loan_years from loans 
where enddate is not null;

-- timestamdiff()
select customerid, firstname, birthdate, timestampdiff(year,birthdate,curdate()) as age from customers;

-- age group

select customerid, firstname, birthdate, timestampdiff(year,birthdate,curdate()) as age,
case
when timestampdiff(year,birthdate,curdate())<25 then "Young Adult"
when timestampdiff(year,birthdate,curdate()) between 25 and 40 then "Adult"
else "Senior"
end as age_grp from customers;

-- date_format()

select transactiondate, date_format(transactiondate,'%d-%m-%y') as formated_date from transactions;

select transactiondate, date_format(transactiondate,'%M-%Y') as month__year from transactions;

-- Monthly transactions 
select 
date_format(transactiondate,'%Y-%m')as month,
count(*) as transaction_counts,
sum(amount) as total_amount
from transactions 
where transactiondate is not null 
group by date_format(transactiondate,'%Y-%m')
order by month;

-- last 30 dyas transactions            --- date_sub substract the date
select * 
from transactions
where  transactiondate >= date_sub('2026-02-25',interval 10 DAY);

-- adding days to the date
select transactionid, transactiondate, date_add(transactiondate,interval 30 day) as after_30_days
from transactions;

-- loan status using days

select loanid, startdate, enddate,
case 
when enddate is null then "No End Date"
when enddate < curdate() then "Completed"
else "Active"
end as Loan_staatus
from loans;


