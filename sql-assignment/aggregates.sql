-- Your name and cohort here
-- David Acuff - C388

/*
Aggregate Queries

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     THEN records returned. 
*/

USE orderbook_activity_db;

-- #1: How many users do we have?
-- Sanjana


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



-- #4: Perform the same query as the one above, but only include admin users.
-- Tatiana


-- #5: List the username and the average absolute net order amount for each user with an order.
-- Round the result to the nearest hundredth and use an alias (averageTradePrice).
-- Sort the results by averageTradePrice with the largest value at the top.
-- Sanjana


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


-- #8: List all the symbols and absolute net fills that have fills exceeding $100.
-- Do not include the WLY symbol in the results.
-- Sort the results by highest net with the largest value at the top.
-- Tatiana


-- #9: List the top five users with the greatest amount of outstanding orders.
-- Display the absolute amount filled, absolute amount ordered, and net outstanding.
-- Sort the results by the net outstanding amount with the largest value at the top.
-- Sanjana
