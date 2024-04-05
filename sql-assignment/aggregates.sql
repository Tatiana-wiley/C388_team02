
-- Morphy Yeboah c388

/*
Aggregate Queries

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     THEN records returned. 
*/

USE orderbook_activity_db;

-- #1: How many users do we have?
Sanjana


-- #2: List the username, userid, and number of orders each user has placed.
David


-- #3: List the username, symbol, and number of orders placed for each user and for each symbol. 
-- Sort results in alphabetical order by symbol.
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
Tatiana


-- #5: List the username and the average absolute net order amount for each user with an order.
-- Round the result to the nearest hundredth and use an alias (averageTradePrice).
-- Sort the results by averageTradePrice with the largest value at the top.
Sanjana


-- #6: How many shares for each symbol does each user have?
-- Display the username and symbol with number of shares.
David


-- #7: What symbols have at least 3 orders?
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
Tatiana


-- #9: List the top five users with the greatest amount of outstanding orders.
-- Display the absolute amount filled, absolute amount ordered, and net outstanding.
-- Sort the results by the net outstanding amount with the largest value at the top.
Sanjana
