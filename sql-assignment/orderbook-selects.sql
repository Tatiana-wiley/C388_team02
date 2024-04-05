-- Your name and cohort here
-- C388 Team 02 (Sanjana, Tatiana, David, Morphy)
/*
Basic Selects

REQUIREMENT - Use a multi-line comment to paste the first 5 or fewer results under your query
		     Also include the total records returned.
*/

USE orderbook_activity_db;

-- #1: List all users, including username and dateJoined.
-- David


-- #2: List the username and datejoined from users with the newest users at the top.
-- Morphy


-- #3: List all usernames and dateJoined for users who joined in March 2023.
-- Tatiana
USE orderbook_activity_db;
SELECT uname, dateJoined
FROM User
Where dateJoined BETWEEN '2023-03-01' AND '2023-03-31';
/*  5 rows
'james','2023-03-15 19:15:48'
'kendra','2023-03-15 19:16:06'
'alice','2023-03-15 19:16:21'
'robert','2023-03-15 19:16:43'
'sam','2023-03-15 19:16:59'
*/
-- #4: List the different role names a user can have.
-- Sanjana


-- #5: List all the orders.
-- David


-- #6: List all orders in March where the absolute net order amount is greater than 1000.
-- Morphy


-- #7: List all the unique status types from orders.
-- Tatiana
USE orderbook_activity_db;
SELECT DISTINCT status 
FROM `Order`;
/* 5 rows
'partial_fill'
'filled'
'pending'
'canceled_partial_fill'
'canceled'
*/

-- #8: List all pending and partial fill orders with oldest orders first.
-- Sanjana


-- #9: List the 10 most expensive financial products where the productType is stock.
-- Sort the results with the most expensive product at the top
-- David


-- #10: Display orderid, fillid, userid, symbol, and absolute net fill amount
-- from fills where the absolute net fill is greater than $1000.
-- Sort the results with the largest absolute net fill at the top.
-- Moprhy
