-- Morphy Yeboah c388

/*
Join Queries

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     Also include the total records returned.
*/

USE orderbook_activity_db;

-- #1: Display the dateJoined and username for admin users.
David


-- Morphy
-- #2: Display each absolute order net (share*price), status, symbol, trade date, and username.
-- Sort the results with largest the absolute order net (share*price) at the top.
-- Include only orders that were not canceled or partially canceled.
select o.`status`, o.symbol, o.orderTime, u.uname, abs(sum(shares * price)) as net_abs
from `Order` as o
join `User` as u on o.userid = u.userid
where o.`status` not like 'canceled%'
Group by o.`status`, o.symbol, o.orderTime, u.uname
Order by net_abs desc;
/* question 2 result
	pending	QQQ	2023-03-15 19:24:32	kendra	53654.00
	partial_fill	SPY	2023-03-15 19:24:21	alice	36573.00
	filled	SPY	2023-03-15 19:24:47	kendra	27429.75
	pending	NFLX	2023-03-15 19:21:12	robert	24315.00
	partial_fill	WLY	2023-03-15 19:20:35	admin	3873.00
	pending	WLY	2023-03-15 19:51:06	james	3873.00
*/



-- #3: Display the orderid, symbol, status, order shares, filled shares, and price for orders with fills.
-- Note that filledShares are the opposite sign (+-) because they subtract from ordershares!
Tatiana


-- #4: Display all partial_fill orders and how many outstanding shares are left.
-- Also include the username, symbol, and orderid.
Sanjana


-- #5: Display the orderid, symbol, status, order shares, filled shares, and price for orders with fills.
-- Also include the username, role, absolute net amount of shares filled, and absolute net order.
-- Sort by the absolute net order with the largest value at the top.
David


-- #6: Display the username and user role for users who have not placed an order.


select u.uname,  ro.`name` -- ord.`status`
from `User` as u
left join `Order` as ord on u.userid = ord.userid
join UserRoles as uro on u.userid = uro.userid
join `Role` as ro on uro.roleid = ro.roleid
where ord.`status` is null;

/*
sam	user
wiley	admin
*/


-- #7: Display orderid, username, role, symbol, price, and number of shares for orders with no fills.
Tatiana


-- #8: Display the symbol, username, role, and number of filled shares where the order symbol is WLY.
-- Include all orders, even if the order has no fills.
Sanjana




