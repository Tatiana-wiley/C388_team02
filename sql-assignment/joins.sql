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
SELECT 
    U.uname AS username,
    O.orderid,
    O.symbol,
    F.fillid,
    F.share AS filled_shares,
    O.shares AS total_shares,
    (O.shares - SUM(F.share)) AS outstanding_shares_left
FROM 
    `Order` O
INNER JOIN 
    `Fill` F ON O.orderid = F.orderid
INNER JOIN 
    `User` U ON O.userid = U.userid
GROUP BY 
    O.orderid, F.fillid
HAVING
    SUM(F.share) < O.shares;
-- Sanjana 
# username, orderid, symbol, fillid, filled_shares, total_shares, outstanding_shares_left
-- 'admin', '1', 'WLY', '1', '-10', '100', '110'
-- 'admin', '6', 'GS', '5', '-10', '100', '110'
-- 'alice', '4', 'A', '3', '-10', '10', '20'
-- 'alice', '11', 'SPY', '11', '-75', '100', '175'
-- 'james', '15', 'TLT', '13', '-10', '10', '20'
-- 'robert', '8', 'AAPL', '7', '-10', '25', '35'
-- 'robert', '8', 'AAPL', '9', '-15', '25', '40'


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

SELECT 
    O.symbol,
    U.uname AS username,
    R.name AS role,
    COALESCE(F.total_filled_shares, 0) AS filled_shares
FROM 
    `Order` O
JOIN 
    `User` U ON O.userid = U.userid
JOIN 
    `UserRoles` UR ON U.userid = UR.userid
JOIN 
    `Role` R ON UR.roleid = R.roleid
LEFT JOIN (
    SELECT 
        orderid,
        SUM(share) AS total_filled_shares
    FROM 
        `Fill`
    GROUP BY 
        orderid
) F ON O.orderid = F.orderid
WHERE 
    O.symbol = 'WLY'
ORDER BY 
    O.symbol, U.uname;

# symbol, username, role, filled_shares
 -- 'WLY', 'admin', 'admin', '-10'
-- 'WLY', 'james', 'user', '0'
-- 'WLY', 'robert', 'user', '10'

-- Sanjana 