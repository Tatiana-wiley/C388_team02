
-- Sanjana C388

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
-- Returned Rows : 7

-- #2: List the username, userid, and number of orders each user has placed.
David


-- #3: List the username, symbol, and number of orders placed for each user and for each symbol. 
-- Sort results in alphabetical order by symbol.
Morphy



-- #4: Perform the same query as the one above, but only include admin users.
Tatiana


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
Returned Rows : 7
# username, averageTradePrice
-- 'robert', '10417.84'
-- 'kendra', '17109.53'
-- 'james', '2053.73'
-- 'alice', '6280.26'
-- 'admin', '12182.47'


-- #6: How many shares for each symbol does each user have?
-- Display the username and symbol with number of shares.
David


-- #7: What symbols have at least 3 orders?
Morphy


-- #8: List all the symbols and absolute net fills that have fills exceeding $100.
-- Do not include the WLY symbol in the results.
-- Sort the results by highest net with the largest value at the top.
Tatiana


-- #9: List the top five users with the greatest amount of outstanding orders.
-- Display the absolute amount filled, absolute amount ordered, and net outstanding.
-- Sort the results by the net outstanding amount with the largest value at the top.
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

-- Returned Rows : 8
-- Sanjana
-- 'admin','5555.00','36547.40','30992.40'
-- 'alice','29717.95','38861.20','9143.25'
-- 'robert','3906.30','7425.30','3519.00'
-- 'james','2288.20','2288.20','0.00'
-- 'kendra','31893.65','31893.65','0.00'

