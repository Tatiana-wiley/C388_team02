-- Your name and cohort here
-- David Acuff - C388

/*
Join Queries

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     Also include the total records returned.
*/

USE orderbook_activity_db;

-- #1: Display the dateJoined and username for admin users.
-- David
SELECT `User`.dateJoined DateJoined, `User`.uname Username FROM User
JOIN UserRoles ON UserRoles.userid = `User`.userid
JOIN `Role` ON Role.roleid = UserRoles.roleid
WHERE `Role`.`name` = "admin";
/*
admin	2023-02-14 13:13:28
wiley	2023-04-01 13:13:28
alice	2023-03-15 19:16:21
ROWS=3
*/


-- #2: Display each absolute order net (share*price), status, symbol, trade date, and username.
-- Sort the results with largest the absolute order net (share*price) at the top.
-- Include only orders that were not canceled or partially canceled.
-- Morphy



-- #3: Display the orderid, symbol, status, order shares, filled shares, and price for orders with fills.
-- Note that filledShares are the opposite sign (+-) because they subtract from ordershares!
-- Tatiana


-- #4: Display all partial_fill orders and how many outstanding shares are left.
-- Also include the username, symbol, and orderid.
-- Sanjana


-- #5: Display the orderid, symbol, status, order shares, filled shares, and price for orders with fills.
-- Also include the username, role, absolute net amount of shares filled, and absolute net order.
-- Sort by the absolute net order with the largest value at the top.
-- David
SELECT `Order`.orderid OrderID, `Order`.symbol Symbol, `Order`.`status` OrderStatus, `Order`.shares OrderShares, Fill.`share` FilledShares, 
		Fill.price FillPrice, `User`.userid Username, Role.`name` RoleType, ABS(Fill.`share` * Fill.price) AbsoluteFilledShares, ABS(`Order`.shares * `Order`.price) AbsoluteNetOrder FROM `Order`
JOIN Fill ON Fill.orderid = `Order`.orderid
JOIN `User` ON `User`.userid = `Order`.orderid
JOIN UserRoles ON UserRoles.userid = `User`.userid
JOIN `Role` ON `Role`.roleid = UserRoles.roleid
ORDER BY AbsoluteNetOrder DESC;
/*
6	GS	canceled_partial_fill	100		-10	305.63	6	user	3056.30	30563.00
1	WLY	partial_fill			100		-10	38.73	1	admin	387.30	3873.00
7	GS	filled					-10		10	305.63	7	user	3056.30	3056.30
5	A	filled					-10		10	129.89	5	admin	1298.90	1298.90
4	A	filled					10		-10	129.89	4	user	1298.90	1298.90
ROWS=6
*/


-- #6: Display the username and user role for users who have not placed an order.
-- Morphy


-- #7: Display orderid, username, role, symbol, price, and number of shares for orders with no fills.
-- Tatiana


-- #8: Display the symbol, username, role, and number of filled shares where the order symbol is WLY.
-- Include all orders, even if the order has no fills.
-- Sanjana




