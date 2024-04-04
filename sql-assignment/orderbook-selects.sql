-- Your name and cohort here

/*
Basic Selects

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     Also include the total records returned.
*/

USE orderbook_activity_db;

-- #1: List all users, including username and dateJoined.
David


-- #2: List the username and datejoined from users with the newest users at the top.
Morphy


-- #3: List all usernames and dateJoined for users who joined in March 2023.
Tantiana


-- #4: List the different role names a user can have.
--Sanjana
SELECT DISTINCT R.name AS role_name
FROM UserRoles UR
JOIN Role R ON UR.roleid = R.roleid;
-- # role_name
-- 'admin'
-- 'user'

-- #5: List all the orders.
David


-- #6: List all orders in March where the absolute net order amount is greater than 1000.
Morphy


-- #7: List all the unique status types from orders.
Tatiana


-- #8: List all pending and partial fill orders with oldest orders first.
-- Sanjana
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
David


-- #10: Display orderid, fillid, userid, symbol, and absolute net fill amount
-- from fills where the absolute net fill is greater than $1000.
-- Sort the results with the largest absolute net fill at the top.
Moprhy
