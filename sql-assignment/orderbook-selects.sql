-- Morphy Yeboah c388

/*
Basic Selects

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     Also include the total records returned.
*/

USE orderbook_activity_db;

-- #1: List all users, including username and dateJoined.
-- David


-- #2: List the username and datejoined from users with the newest users at the top.
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
-- Morphy

-- #3: List all usernames and dateJoined for users who joined in March 2023.
-- Tantiana


-- #4: List the different role names a user can have.
-- Sanjana


-- #5: List all the orders.
-- David


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
Tatiana


-- #8: List all pending and partial fill orders with oldest orders first.
Sanjana


-- #9: List the 10 most expensive financial products where the productType is stock.
-- Sort the results with the most expensive product at the top
David


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
