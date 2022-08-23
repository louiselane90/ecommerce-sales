/*

Clean Raw Data with SQL Queries

*/

------------------------------------------------------------------------------------------------------------------------

 SELECT *
 FROM PoshmarkSales;

--PoshmarkSales: Change column name 'Lowest Set Price' to 'List Price'

 SELECT *
 FROM PoshmarkSales
 EXEC sp_RENAME 'PoshmarkSales.lowest set price' , 'List Price' , 'COLUMN';

 SELECT *
 FROM PoshmarkSales;

 ------------------------------------------------------------------------------------------------------------------------
-- PoshmarkSales: Remove second color and comma from 'Color' column

SELECT Color
FROM PoshmarkSales;

SELECT
PARSENAME(REPLACE(Color, ',', '.') , 1)
FROM PoshmarkSales;

ALTER TABLE PoshmarkSales
Add PrimaryColor Nvarchar(10);

Update PoshmarkSales
SET PrimaryColor = PARSENAME(REPLACE(Color, ',', '.') , 1);

SELECT Color, PrimaryColor
FROM PoshmarkSales;

------------------------------------------------------------------------------------------------------------------------
-- PoshmarkSales: Add column 'Discounted Shipping' and populate Y or N based on value in Seller Shipping Discount column
SELECT *
FROM PoshmarkSales;

ALTER TABLE PoshmarkSales
ADD [Discounted Shipping] VARCHAR(1);

ALTER TABLE PoshmarkSales
ALTER COLUMN [Seller Shipping Discount] varchar(10);

SELECT *
FROM PoshmarkSales;

SELECT DISTINCT([Seller Shipping Discount])
FROM PoshmarkSales;

SELECT [Seller Shipping Discount]
,	CASE WHEN [Seller Shipping Discount] = '0.00' THEN 'N'
		 WHEN [Seller Shipping Discount] != '0.00' THEN 'Y'
		 ELSE [Seller Shipping Discount]
		 END
FROM PoshmarkSales;

Update PoshmarkSales
SET [Discounted Shipping] = CASE WHEN [Seller Shipping Discount] = '0.00' THEN 'N'
		 WHEN [Seller Shipping Discount] != '0.00' THEN 'Y'
		 ELSE [Seller Shipping Discount]
		 END;

SELECT *
FROM PoshmarkSales;

------------------------------------------------------------------------------------------------------------------------
-- PoshmarkSales: Remove columns Listing Date, Order Date, Order Id, Cost Price, Upgraded Shipping, Net Earnings, Sales Tax (Paid by Buyer), Sales Tax (Paid by Seller), Notes, Other Info

SELECT [Listing Date], [Order Date], [Order Id], [Cost Price], [Upgraded Shipping Label Fee], [Net Earnings], [Sales Tax (Paid by Buyer)], [Sales Tax (Paid by Seller)], Notes, [Other Info]
FROM PoshmarkSales;

ALTER TABLE PoshmarkSales
DROP COLUMN [Listing Date], [Order Date], [Order Id], [Cost Price], [Upgraded Shipping Label Fee], [Net Earnings], [Sales Tax (Paid by Buyer)], [Sales Tax (Paid by Seller)], Notes, [Other Info];

SELECT [Listing Date], [Order Date], [Order Id], [Cost Price], [Upgraded Shipping Label Fee], [Net Earnings], [Sales Tax (Paid by Buyer)], [Sales Tax (Paid by Seller)], Notes, [Other Info]
FROM PoshmarkSales;

------------------------------------------------------------------------------------------------------------------------
-- PoshmarkSales: Add columns Purchase Location, COGS, Date Listed, Net Profit, Date Sold, Days in Inventory

SELECT *
FROM PoshmarkSales;

ALTER TABLE PoshmarkSales
ADD
	PurchaseLocation VARCHAR(50),
	COGS MONEY,
	[Date Listed] DATE,
	[Net Profit] MONEY,
	[Date Sold] DATE,
	[Days in Inventory] INT;

 SELECT *
 FROM PoshmarkSales;

 ------------------------------------------------------------------------------------------------------------------------
-- PoshmarkSales: Populate missing SKUs using data from other tables, then remove blank rows

SELECT *
FROM PoshmarkSales
WHERE SKU IS NULL;

SELECT *
FROM MySales20192020;


SELECT a.[Listing Title], a.SKU, b.Item, b.SKU, ISNULL(a.SKU, b.SKU)
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.[Listing Title] = b.Item
	AND a.SKU IS NULL

SELECT a.[Listing Title], a.SKU, b.Item, b.SKU, ISNULL(a.SKU, b.SKU)
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.[Listing Title] = b.Item
	AND a.SKU IS NULL

Update a
SET SKU = ISNULL(a.SKU, b.SKU)
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.[Listing Title] = b.Item
	AND a.SKU IS NULL

Update a
SET SKU = ISNULL(a.SKU, b.SKU)
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.[Listing Title] = b.Item
	AND a.SKU IS NULL

-- Then, PoshmarkSales: Remove blank rows

DELETE FROM PoshmarkSales
WHERE SKU IS NULL;

	   	 
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

/*

Query PoshmarkSales table and populate columns, by matching SKU, to generate one consolidated list of sold items with desired information

*/

------------------------------------------------------------------------------------------------------------------------
-- From MySales20192020 populate columns PurchaseLocation, COGS, Date Listed, Net Profit, Date Sold, Days in Inventory//FIXME

-- PurchaseLocation
SELECT *
FROM PoshmarkSales;

Select a.sku, a.PurchaseLocation, b. sku, b.source, ISNULL(a.PurchaseLocation, b.source)
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE PurchaseLocation IS NULL;

Update a
SET PurchaseLocation = ISNULL(a.PurchaseLocation, b.source)
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE PurchaseLocation IS NULL;

-- COGS
SELECT *
FROM PoshmarkSales;

Select a.sku, a.COGS, b. sku, b.COGS, ISNULL(a.COGS, b.COGS)
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE a.COGS IS NULL;

Update a
SET a.COGS = ISNULL(a.COGS, b.COGS)
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.SKU
WHERE a.COGS IS NULL;

-- Date Listed
SELECT *
FROM PoshmarkSales;

SELECT *
FROM MySales20192020;

Select a.sku, a.[Date Listed], b. sku, b.[Date_Listed], ISNULL(a.[Date Listed], b.[Date_Listed])
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE [Date Listed] IS NULL;

Update a
SET [Date Listed] = ISNULL(a.[Date Listed], b.[Date_Listed])
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE [Date Listed] IS NULL;

-- Net Profit
SELECT *
FROM PoshmarkSales;

Select a.sku, a.[Net Profit], b. sku, b.[Net_Profit], ISNULL(a.[Net Profit], b.[Net_Profit])
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE [Net Profit] IS NULL;

Update a
SET [Net Profit] = ISNULL(a.[Net Profit], b.[Net_Profit])
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE [Net Profit] IS NULL;

-- Date Sold
SELECT *
FROM PoshmarkSales;

Select a.sku, a.[Date Sold], b. sku, b.[Date_Sold], ISNULL(a.[Date Sold], b.[Date_Sold])
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE [Date Sold] IS NULL;

Update a
SET [Date Sold] = ISNULL(a.[Date Sold], b.[Date_Sold])
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE [Date Sold] IS NULL;

-- Days in Inventory
SELECT *
FROM PoshmarkSales;

Select a.sku, a.[Days in Inventory], b. sku, b.Age_of_Listing, ISNULL(a.[Days in Inventory], b.Age_of_Listing)
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE [Days in Inventory] IS NULL;

Update a
SET [Days in Inventory] = ISNULL(a.[Days in Inventory], b.Age_of_Listing)
FROM PoshmarkSales a
JOIN MySales20192020 b
	on a.sku = b.sku
WHERE [Days in Inventory] IS NULL;

------------------------------------------------------------------------------------------------------------------------
-- From MySales2021 populate columns PurchaseLocation, COGS, Date Listed, Net Profit, Date Sold, Days in Inventory

-- PurchaseLocation
SELECT *
FROM PoshmarkSales;

Select a.sku, a.PurchaseLocation, b. sku, b.source, ISNULL(a.PurchaseLocation, b.source)
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE PurchaseLocation IS NULL;

Update a
SET PurchaseLocation = ISNULL(a.PurchaseLocation, b.source)
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE PurchaseLocation IS NULL;

-- COGS
SELECT *
FROM PoshmarkSales;

Select a.sku, a.COGS, b. sku, b.COGS, ISNULL(a.COGS, b.COGS)
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE a.COGS IS NULL;

Update a
SET a.COGS = ISNULL(a.COGS, b.COGS)
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.SKU
WHERE a.COGS IS NULL;

-- Date Listed
SELECT *
FROM PoshmarkSales;

SELECT *
FROM MySales2021;

Select a.sku, a.[Date Listed], b. sku, b.[Date_Listed], ISNULL(a.[Date Listed], b.[Date_Listed])
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE [Date Listed] IS NULL;

Update a
SET [Date Listed] = ISNULL(a.[Date Listed], b.[Date_Listed])
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE [Date Listed] IS NULL;

-- Net Profit
SELECT *
FROM PoshmarkSales;

Select a.sku, a.[Net Profit], b. sku, b.[Net_Profit], ISNULL(a.[Net Profit], b.[Net_Profit])
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE [Net Profit] IS NULL;

Update a
SET [Net Profit] = ISNULL(a.[Net Profit], b.[Net_Profit])
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE [Net Profit] IS NULL;

-- Date Sold
SELECT *
FROM PoshmarkSales;

Select a.sku, a.[Date Sold], b. sku, b.[Date_Sold], ISNULL(a.[Date Sold], b.[Date_Sold])
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE [Date Sold] IS NULL;

Update a
SET [Date Sold] = ISNULL(a.[Date Sold], b.[Date_Sold])
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE [Date Sold] IS NULL;

-- Days in Inventory
SELECT *
FROM PoshmarkSales;

Select a.sku, a.[Days in Inventory], b. sku, b.Age_of_Listing, ISNULL(a.[Days in Inventory], b.Age_of_Listing)
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE [Days in Inventory] IS NULL;

Update a
SET [Days in Inventory] = ISNULL(a.[Days in Inventory], b.Age_of_Listing)
FROM PoshmarkSales a
JOIN MySales2021 b
	on a.sku = b.sku
WHERE [Days in Inventory] IS NULL;

------------------------------------------------------------------------------------------------------------------------
-- From MySales2022 populate columns PurchaseLocation, COGS, Date Listed, Net Profit, Date Sold, Days in Inventory

-- PurchaseLocation
SELECT *
FROM PoshmarkSales;

Select a.sku, a.PurchaseLocation, b. sku, b.source, ISNULL(a.PurchaseLocation, b.source)
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE PurchaseLocation IS NULL;

Update a
SET PurchaseLocation = ISNULL(a.PurchaseLocation, b.source)
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE PurchaseLocation IS NULL;

-- COGS
SELECT *
FROM PoshmarkSales;

Select a.sku, a.COGS, b. sku, b.COGS, ISNULL(a.COGS, b.COGS)
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE a.COGS IS NULL;

Update a
SET a.COGS = ISNULL(a.COGS, b.COGS)
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.SKU
WHERE a.COGS IS NULL;

-- Date Listed
SELECT *
FROM PoshmarkSales;

SELECT *
FROM MySales2022;

Select a.sku, a.[Date Listed], b. sku, b.[Date_Listed], ISNULL(a.[Date Listed], b.[Date_Listed])
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE [Date Listed] IS NULL;

Update a
SET [Date Listed] = ISNULL(a.[Date Listed], b.[Date_Listed])
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE [Date Listed] IS NULL;

-- Net Profit
SELECT *
FROM PoshmarkSales;

Select a.sku, a.[Net Profit], b. sku, b.[Net_Profit], ISNULL(a.[Net Profit], b.[Net_Profit])
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE [Net Profit] IS NULL;

Update a
SET [Net Profit] = ISNULL(a.[Net Profit], b.[Net_Profit])
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE [Net Profit] IS NULL;

-- Date Sold
SELECT *
FROM PoshmarkSales;

Select a.sku, a.[Date Sold], b. sku, b.[Date_Sold], ISNULL(a.[Date Sold], b.[Date_Sold])
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE [Date Sold] IS NULL;

Update a
SET [Date Sold] = ISNULL(a.[Date Sold], b.[Date_Sold])
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE [Date Sold] IS NULL;

-- Days in Inventory
SELECT *
FROM PoshmarkSales;

Select a.sku, a.[Days in Inventory], b. sku, b.Age_of_Listing, ISNULL(a.[Days in Inventory], b.Age_of_Listing)
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE [Days in Inventory] IS NULL;

Update a
SET [Days in Inventory] = ISNULL(a.[Days in Inventory], b.Age_of_Listing)
FROM PoshmarkSales a
JOIN MySales2022 b
	on a.sku = b.sku
WHERE [Days in Inventory] IS NULL;

--Delete rows with missing PurchaseLocation

SELECT *
FROM PoshmarkSales
WHERE PurchaseLocation IS NULL;

DELETE FROM PoshmarkSales
WHERE PurchaseLocation IS NULL;
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
