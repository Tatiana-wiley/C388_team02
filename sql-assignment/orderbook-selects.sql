-- Your name and cohort here
-- C388 Team 02 (Sanjana, Tatiana, David, Morphy)

/*
Basic Selects

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     Also include the total records returned.
*/

USE orderbook_activity_db;

-- #1: List all users, including username and dateJoined.
-- David
SELECT `User`.uname, `User`.dateJoined FROM `User`;
/*
admin	2023-02-14 13:13:28
wiley	2023-04-01 13:13:28
james	2023-03-15 19:15:48
kendra	2023-03-15 19:16:06
alice	2023-03-15 19:16:21
ROWS=7
*/


-- #2: List the username and datejoined from users with the newest users at the top.
-- Morphy
Select uname, dateJoined
from `User`
order by dateJoined desc;
/*
wiley	2023-04-01 13:13:28
sam	2023-03-15 19:16:59
robert	2023-03-15 19:16:43
alice	2023-03-15 19:16:21
kendra	2023-03-15 19:16:06
james	2023-03-15 19:15:48
admin	2023-02-14 13:13:28
*/

-- #3: List all usernames and dateJoined for users who joined in March 2023.
-- Tantiana

USE orderbook_activity_db;
SELECT uname, dateJoined
FROM User
Where dateJoined BETWEEN '2023-03-01' AND '2023-03-31';
/*  5 rows
'james','2023-03-15 19:15:48'
'kendra','2023-03-15 19:16:06'
'alice','2023-03-15 19:16:21'
'robert','2023-03-15 19:16:43'
'sam','2023-03-15 19:16:59'
*/


-- #4: List the different role names a user can have.
-- Sanjana
SELECT `User`.uname, `User`.dateJoined FROM `User`;
/*
admin	2023-02-14 13:13:28
wiley	2023-04-01 13:13:28
james	2023-03-15 19:15:48
kendra	2023-03-15 19:16:06
alice	2023-03-15 19:16:21
ROWS=7
*/


-- #2: List the username and datejoined from users with the newest users at the top.
-- Morphy


-- #3: List all usernames and dateJoined for users who joined in March 2023.
-- Tatiana
USE orderbook_activity_db;
SELECT uname, dateJoined
FROM User
Where dateJoined BETWEEN '2023-03-01' AND '2023-03-31';
/*  5 rows
'james','2023-03-15 19:15:48'
'kendra','2023-03-15 19:16:06'
'alice','2023-03-15 19:16:21'
'robert','2023-03-15 19:16:43'
'sam','2023-03-15 19:16:59'
*/


-- #4: List the different role names a user can have.
--Sanjana
SELECT DISTINCT R.name AS role_name
FROM UserRoles UR
JOIN Role R ON UR.roleid = R.roleid;
-- # role_name
-- 'admin'
-- 'user'


-- #5: List all the orders.
-- David
SELECT * FROM `Order`;
/*
1	1	WLY		1	2023-03-15 19:20:35	100		38.73	partial_fill
2	6	WLY		2	2023-03-15 19:20:50	-10		38.73	filled
3	6	NFLX	2	2023-03-15 19:21:12	-100	243.15	pending
4	5	A		1	2023-03-15 19:21:31	10		129.89	filled
5	3	A		2	2023-03-15 19:21:39	-10		129.89	filled
ROWS=24
*/


-- Morphy
-- #6: List all orders in March where the absolute net order amount is greater than 1000.
select orderid, abs(price * shares) as net_amnt
from `Order`
group by orderid
having net_amnt > 1000;
/* Question 6 result
	1	3873.00
	3	24315.00
	4	1298.90
	5	1298.90
	6	30563.00
	7	3056.30
	8	3519.00
	9	1407.60
*/


-- #7: List all the unique status types from orders.
-- Tatiana

USE orderbook_activity_db;
SELECT DISTINCT status 
FROM `Order`;
/* 5 rows
'partial_fill'
'filled'
'pending'
'canceled_partial_fill'
'canceled'
*/

-- #8: List all pending and partial fill orders with oldest orders first.
-- Sanjana
SELECT 
    F.fillid,
    F.orderid,
    F.userid,
    F.share,
    F.price,
    F.symbol
FROM 
    Fill F
JOIN 
    `Order` O ON F.orderid = O.orderid
WHERE 
    O.status IN ('pending', 'partial_fill')
ORDER BY 
    O.orderTime;
-- fillid, orderid, userid, share, price, symbol
-- '11', '11', '5', '-75', '365.73', 'SPY'
-- '1', '1', '1', '-10', '38.73', 'WLY'


-- #9: List the 10 most expensive financial products where the productType is stock.
-- Sort the results with the most expensive product at the top
-- David
SELECT symbol, `name`, productType, price FROM Product
WHERE productType = "stock"
ORDER BY price DESC
LIMIT 0, 10;
/*
207940.KS	Samsung Biologics Co.,Ltd.	stock	830000.00
003240.KS	Taekwang Industrial Co., Ltd.	stock	715000.00
000670.KS	Young Poong Corporation	stock	630000.00
010130.KS	Korea Zinc Company, Ltd.	stock	616000.00
006400.KS	Samsung SDI Co., Ltd.	stock	605000.00
ROWS=10
*/


-- Morphy
-- #10: Display orderid, fillid, userid, symbol, and absolute net fill amount
-- from fills where the absolute net fill is greater than $1000.
-- Sort the results with the largest absolute net fill at the top.
select orderid, fillid, userid, symbol, abs(price * `share`) as net_amt
from Fill
group by orderid, fillid, userid, symbol
having net_amt > 1000
order by net_amt desc;

/* Question 10 result
	orderid	fillid	userid	symbol	net_amt
	11	11	5	SPY	27429.75
	14	12	4	SPY	27429.75
	6	5	1	GS	3056.30
	7	6	4	GS	3056.30
	8	9	6	AAPL	2111.40
	10	10	1	AAPL	2111.40

    */
