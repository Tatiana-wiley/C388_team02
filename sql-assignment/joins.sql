-- Your name and cohort here

/*
Join Queries

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     Also include the total records returned.
*/

USE orderbook_activity_db;

-- #1: Display the dateJoined and username for admin users.
David


-- #2: Display each absolute order net (share*price), status, symbol, trade date, and username.
-- Sort the results with largest the absolute order net (share*price) at the top.
-- Include only orders that were not canceled or partially canceled.
Morphy



-- #3: Display the orderid, symbol, status, order shares, filled shares, and price for orders with fills.
-- Note that filledShares are the opposite sign (+-) because they subtract from ordershares!
Tatiana


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


-- #5: Display the orderid, symbol, status, order shares, filled shares, and price for orders with fills.
-- Also include the username, role, absolute net amount of shares filled, and absolute net order.
-- Sort by the absolute net order with the largest value at the top.
David


-- #6: Display the username and user role for users who have not placed an order.
Morphy


-- #7: Display orderid, username, role, symbol, price, and number of shares for orders with no fills.
Tatiana


-- #8: Display the symbol, username, role, and number of filled shares where the order symbol is WLY.
-- Include all orders, even if the order has no fills.
--Sanjana

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


