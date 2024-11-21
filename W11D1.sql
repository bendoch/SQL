USE AdventureWorksDW;

-- 1.Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria.
-- Quali considerazioni/ragionamenti è necessario che tu faccia?

SELECT 
    COUNT(*) AS RecordTotali
    ,COUNT(DISTINCT p.ProductKey) AS ValuriUnici
FROM dimproduct AS p
   WHERE p.ProductKey IS NOT NULL;

-- 2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.

SELECT
    COUNT(*) AS Totale
    ,COUNT(DISTINCT rs.SalesOrderNumber , rs.SalesOrderLineNumber) AS PK
FROM factresellersales AS rs;

-- 3.Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020

SELECT
    COUNT(rs.SalesOrderLineNumber) AS TotalOrderLine
    ,rs.OrderDate
FROM factresellersales AS rs
GROUP BY rs.OrderDate
HAVING rs.OrderDate >= '2020-01-01';

-- 4.Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity)
-- e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020.
-- Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita.
-- I campi in output devono essere parlanti!

SELECT p.EnglishProductName AS ProductName
       , SUM(rs.SalesAmount) AS SalesTotal
       , SUM(rs.OrderQuantity) AS QuantityTotal
       , AVG(rs.UnitPrice) AS PriceAverage
FROM factresellersales AS rs
     INNER JOIN
	 dimproduct AS p
     ON rs.ProductKey=p.ProductKey
WHERE rs.OrderDate >= '2020-01-01'
GROUP BY p.ProductKey
ORDER BY rs.SalesAmount DESC;
     
-- 5.Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity)
-- per Categoria prodotto (DimProductCategory).
-- Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta.
-- I campi in output devono essere parlanti!

SELECT pc.EnglishProductCategoryName AS Category
       , SUM(rs.SalesAmount) AS TotalSales
       , SUM(rs.OrderQuantity) AS TotalQuantity
FROM dimproductcategory AS pc
     INNER JOIN dimproductsubcategory AS psc
     ON psc.ProductCategoryKey=pc.ProductCategoryKey
     INNER JOIN dimproduct AS p
     ON p.ProductSubcategoryKey=psc.ProductSubcategoryKey
     INNER JOIN factresellersales AS rs
     ON rs.ProductKey=p.ProductKey
GROUP BY pc.EnglishProductCategoryName;

-- 6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020.
-- Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K

SELECT geo.City
       , SUM(rs.SalesAmount) AS TotalSales
FROM dimgeography AS geo
    INNER JOIN factresellersales AS rs
    ON rs.SalesTerritoryKey=geo.SalesTerritoryKey
WHERE rs.OrderDate > '2020-01-01'
GROUP BY geo.City
HAVING SUM(rs.SalesAmount) > '6000000';
-- ho aumentato la quota minima di fatturato perchè con 60K mi restituiva 562 righe, le stesse restituite senza questa clausola