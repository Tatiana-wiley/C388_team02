-- Your name and cohort here
-- C388 Team 02 (Sanjana, Tatiana, David, Morphy)

/*
Aggregate Queries

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     THEN records returned. 
*/

USE orderbook_activity_db;

-- #1: How many users do we have?
-- Sanjana
SELECT COUNT(userid) AS num_users
FROM User;
-- Returned Rows: 7


-- #2: List the username, userid, and number of orders each user has placed.
-- David
SELECT `User`.userid UserID, `User`.uname Username, COUNT(`Order`.orderid) OrderCount FROM `User`
LEFT OUTER JOIN `Order` ON `Order`.userid = `User`.userid
GROUP BY Username, UserID;
/*
1	admin	3
5	alice	8
3	james	3
4	kendra	5
6	robert	5
ROWS=7
*/


-- #3: List the username, symbol, and number of orders placed for each user and for each symbol. 
-- Sort results in alphabetical order by symbol.
-- Morphy
select u.uname, ord.symbol, count(u.uname) as orders_placed_user -- count(ord.symbol) as orders_placed_for_each_symbol
from `User` as u
join `Order` as ord on u.userid = ord.userid
Group by u.uname, ord.symbol
Order by ord.symbol asc;

/* question 3 result
	alice	A	5
	james	A	1
	robert	AAA	1
	admin	AAPL	1
	robert	AAPL	1
	kendra	AAPL	1
*/



-- #4: Perform the same query as the one above, but only include admin users.
-- Tatiana
USE orderbook_activity_db;
SELECT u.uname, o.symbol, COUNT(o.orderid) AS numberOfOrders
FROM `Order` o
JOIN User  u ON u.userid = o.userid
JOIN UserRoles ur ON ur.userid = u.userid
WHERE ur.roleid = 1
GROUP BY u.uname , o.symbol
ORDER BY o.symbol ASC;
/* 7 rows
'alice','A','5'
'admin','AAPL','1'
'alice','GOOG','1'
'admin','GS','1'
'alice','SPY','1'
'alice','TLT','1'
'admin','WLY','1'
*/


-- #5: List the username and the average absolute net order amount for each user with an order.
-- Round the result to the nearest hundredth and use an alias (averageTradePrice).
-- Sort the results by averageTradePrice with the largest value at the top.
-- Sanjana
SELECT u.uname AS username,
       ROUND(AVG(ABS(o.shares * o.price)), 2) AS averageTradePrice
FROM `Order` o
JOIN `User` u ON o.userid = u.userid
GROUP BY u.userid, u.uname
ORDER BY averageTradePrice DESC;
-- # username, averageTradePrice
-- 'admin', '12182.47'
-- 'alice', '6280.26'
-- 'james', '2053.73'
-- 'kendra', '17109.53'
-- 'robert', '10417.84'
-- Results: 7


-- #6: How many shares for each symbol does each user have?
-- Display the username and symbol with number of shares.
-- David
SELECT `User`.uname Username, Product.symbol Symbol, COUNT(`Order`.shares) ShareCount from `User`
LEFT OUTER JOIN `Order` ON `Order`.userid = `User`.userid
JOIN Product ON Product.symbol = `Order`.symbol
GROUP BY Username, Symbol;
/*
admin	WLY		1
admin	GS		1
admin	AAPL	1
alice	A		5
alice	SPY		1
ROWS=19
*/


-- #7: What symbols have at least 3 orders?
-- Morphy
select count(ord.symbol) as orders_placed_for_each_symbol, ord.symbol
from `Order` as ord
join `User` as u on ord.userid = u.userid
Group by ord.symbol
having orders_placed_for_each_symbol >= 3;

/* question 7 result
3	WLY
3	AAPL
6	A
*/


-- #8: List all the symbols and absolute net fills that have fills exceeding $100.
-- Do not include the WLY symbol in the results.
-- Sort the results by highest net with the largest value at the top.
-- Tatiana
SELECT f.symbol, SUM(ABS(f.share) * f.price) AS NETFILL
FROM  Fill f
WHERE f.symbol != 'WLY'
GROUP BY f.symbol
HAVING SUM(ABS(f.share) * f.price) > 100
ORDER BY NETFILL DESC;
/* 5 ROWS
'SPY','54859.50'
'AAPL','7038.00'
'GS','6112.60'
'A','2597.80'
'TLT','1978.60'
*/


-- #9: List the top five users with the greatest amount of outstanding orders.
-- Display the absolute amount filled, absolute amount ordered, and net outstanding.
-- Sort the results by the net outstanding amount with the largest value at the top.
-- Sanjana
SELECT 
    u.uname AS username,
    SUM(ABS(f.share * f.price)) AS absolute_filled_amount,
    SUM(ABS(o.shares * o.price)) AS absolute_ordered_amount,
    SUM(ABS(o.shares * o.price)) - SUM(ABS(f.share * f.price)) AS net_outstanding
FROM 
    `Fill` f
JOIN 
    `Order` o ON f.orderid = o.orderid
JOIN 
    `User` u ON o.userid = u.userid
GROUP BY 
    u.userid, u.uname
ORDER BY 
    net_outstanding DESC
LIMIT 5;
-- Results: 8


# username, absolute_filled_amount, absolute_ordered_amount, net_outstanding
-- 'admin', '5555.00', '36547.40', '30992.40'
-- 'alice', '29717.95', '38861.20', '9143.25'
-- 'robert', '3906.30', '7425.30', '3519.00'
-- 'james', '2288.20', '2288.20', '0.00'
-- 'kendra', '31893.65', '31893.65', '0.00'
-- Results: 8
