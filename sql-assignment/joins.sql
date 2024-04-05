-- Your name and cohort here
-- C388 Team 02 (Sanjana, Tatiana, David, Morphy)

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
SELECT o.orderid, o.symbol, o.status, SUM(o.shares),SUM(ABS(f.share)) AS Filled, o.price
FROM `Order` o
RIGHT OUTER JOIN Fill f ON f.orderid = o.orderid
WHERE o.status != 'canceled_partial_fill'
GROUP BY o.orderid;

/* 12 rows
'1','WLY','partial_fill','100','10','38.73'
'2','WLY','filled','-10','10','38.73'
'4','A','filled','10','10','129.89'
'5','A','filled','-10','10','129.89'
'7','GS','filled','-10','10','305.63'
'8','AAPL','filled','50','25','140.76'
'9','AAPL','filled','-10','10','140.76'
'10','AAPL','filled','-15','15','140.76'
'11','SPY','partial_fill','100','75','365.73'
'14','SPY','filled','-75','75','365.73'
'15','TLT','filled','10','10','98.93'
'16','TLT','filled','-10','10','98.93'


*/


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

SELECT o.orderid, u.uname, r.name, o.symbol, o.price, o.shares
FROM `Order` o
JOIN User u ON u.userid = o.userid
JOIN UserRoles ur ON ur.userid = u.userid
JOIN Role r ON r.roleid = ur.roleid
WHERE o.status = 'pending' OR o.status ="canceled_partial_fill";

/* 14 rows

'1','admin','admin','WLY','38.73','100'
'6','admin','admin','GS','305.63','100'
'11','alice','admin','SPY','365.73','100'
'19','alice','admin','GOOG','100.82','100'
'21','alice','admin','A','129.89','-1'
'22','alice','admin','A','129.89','2'
'23','alice','admin','A','129.89','5'
'24','alice','admin','A','129.89','2'
'20','james','user','WLY','38.73','100'
'12','kendra','user','QQQ','268.27','-100'
'13','kendra','user','QQQ','268.27','-100'
'3','robert','user','NFLX','243.15','-100'
'17','robert','user','AAA','24.09','10'
'18','robert','user','MSFT','236.27','100'
*/

-- #8: Display the symbol, username, role, and number of filled shares where the order symbol is WLY.
-- Include all orders, even if the order has no fills.
-- Sanjana




