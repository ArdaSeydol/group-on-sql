--  JOIN + WHERE (1)
SELECT c.FirstName, c.LastName, d.Title
FROM Customer c
JOIN Purchase p ON c.Customer_ID = p.Customer_ID
JOIN Deal d ON d.Deal_ID = p.Deal_ID
WHERE d.Price > 30;

--  JOIN + WHERE (2)
SELECT m.BusinessName, cat.CategoryName
FROM Merchant m
JOIN Deal d ON m.Merchant_ID = d.Merchant_ID
JOIN Deal_Category dc ON d.Deal_ID = dc.Deal_ID
JOIN Category cat ON cat.Category_ID = dc.Category_ID
WHERE cat.CategoryName = 'Health';

--  GROUP BY + HAVING (1)
SELECT d.Title, COUNT(p.Purchase_ID) AS TotalPurchases
FROM Deal d
JOIN Purchase p ON d.Deal_ID = p.Deal_ID
GROUP BY d.Title
HAVING COUNT(p.Purchase_ID) >= 1;

--  GROUP BY + HAVING (2)
SELECT a.City, COUNT(DISTINCT c.Customer_ID) AS CustomerCount
FROM Address a
JOIN Merchant m ON a.Address_ID = m.Address_ID
JOIN Deal d ON d.Merchant_ID = m.Merchant_ID
JOIN Purchase p ON d.Deal_ID = p.Deal_ID
JOIN Customer c ON c.Customer_ID = p.Customer_ID
GROUP BY a.City;

--  Subquery (1)
SELECT Title, Price
FROM Deal
WHERE Price > (SELECT AVG(Price) FROM Deal);

--  Subquery (2)
SELECT FirstName, LastName
FROM Customer
WHERE Customer_ID IN (
    SELECT p.Customer_ID
    FROM Purchase p
    JOIN Deal d ON d.Deal_ID = p.Deal_ID
    JOIN Deal_Category dc ON d.Deal_ID = dc.Deal_ID
    JOIN Category cat ON cat.Category_ID = dc.Category_ID
    WHERE cat.CategoryName = 'Fitness'
);

--  Correlated Subquery
SELECT d1.Deal_ID, d1.Title, d1.Price
FROM Deal d1
WHERE d1.Price > (
    SELECT AVG(d2.Price)
    FROM Deal d2
    WHERE d2.Merchant_ID = d1.Merchant_ID
);

-- UPDATE with Correlated Subquery
UPDATE Deal d
SET d.Price = d.Price * 1.1
WHERE d.Price < (
    SELECT AVG(d2.Price)
    FROM Deal d2
    WHERE d2.Merchant_ID = d.Merchant_ID
);

--  DELETE with Subquery
DELETE FROM Payment
WHERE Purchase_ID IN (
    SELECT p.Purchase_ID
    FROM Purchase p
    LEFT JOIN Redemption r ON p.Purchase_ID = r.Purchase_ID
    GROUP BY p.Purchase_ID
    HAVING COUNT(r.Redemption_ID) = 0
);
