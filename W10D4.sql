-- 1.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).

SELECT p.EnglishProductName AS ProductName
       , p.ProductKey
       , p.EnglishDescription
       , p.ListPrice
       , psc.EnglishProductSubcategoryName AS ProductSubcategory
FROM dimproduct AS p
JOIN dimproductsubcategory AS psc
    ON p.ProductSubcategoryKey=psc.ProductSubcategoryKey
GROUP BY p.ProductKey;

-- 2.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria
-- (DimProduct, DimProductSubcategory, DimProductCategory)

SELECT p.EnglishProductName AS ProductName
       , psc.EnglishProductSubcategoryName AS ProductSubcategory
       , pc.EnglishProductCategoryName AS ProductCategory
       , p.ProductKey
       , p.EnglishDescription
       , p.ListPrice
FROM dimproduct AS p
JOIN dimproductsubcategory AS psc
    ON p.ProductSubcategoryKey=psc.ProductSubcategoryKey
JOIN dimproductcategory AS pc
    ON psc.ProductCategoryKey=pc.ProductCategoryKey
GROUP BY p.ProductKey;

-- 3.Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales).
SELECT p.EnglishProductName
       , p.ProductKey
FROM dimproduct AS p
INNER JOIN (
       SELECT r.SalesAmount
              , r.ProductKey
       FROM factresellersales AS r
       WHERE r.SalesAmount IS NOT NULL) AS rd
    ON rd.ProductKey=p.ProductKey
GROUP BY p.ProductKey;

-- 4.Esponi l’elenco dei prodotti non venduti 
-- (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).

SELECT p.EnglishProductName
       , p.ProductKey
FROM dimproduct AS p
INNER JOIN (
       SELECT r.SalesAmount
              , r.ProductKey
       FROM factresellersales AS r
       WHERE r.SalesAmount IS NULL) AS rd
    ON rd.ProductKey=p.ProductKey
WHERE p.FinishedGoodsFlag = 1
GROUP BY p.ProductKey;

-- 5.Esponi l’elenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)

SELECT r.SalesOrderNumber
       , r.SalesOrderLineNumber
       , p.EnglishProductName
FROM factresellersales AS r
JOIN dimproduct AS p
    ON r.ProductKey=p.ProductKey;

-- 6.Esponi l’elenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.

SELECT r.SalesOrderNumber
       , r.SalesOrderLineNumber
       , pc.EnglishProductCategoryName
FROM factresellersales AS r
JOIN dimproduct AS p
    ON r.ProductKey=p.ProductKey
JOIN dimproductsubcategory AS psc
    ON p.ProductSubcategoryKey=psc.ProductSubcategoryKey
JOIN dimproductcategory AS pc
    ON psc.ProductCategoryKey=pc.ProductCategoryKey;

-- 7.Esplora la tabella DimReseller.

DESCRIBE dimreseller;

-- 8.Esponi in output l’elenco dei reseller indicando, per ciascun reseller, anche la sua area geografica.

SELECT r.ResellerName
       , r.GeographyKey
FROM dimreseller AS r
GROUP BY r.ResellerKey;

-- 9-Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi: 
-- SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
-- Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e l’area geografica

SELECT rs.SalesOrderNumber
       , rs.SalesOrderLineNumber
       , rs.OrderDate
       , rs.UnitPrice
       , rs.OrderQuantity
       , rs.TotalProductCost
       , p.EnglishProductName
       , pc.EnglishProductCategoryName
       , r.ResellerName
       , geo.EnglishCountryRegionName
FROM factresellersales AS rs
JOIN dimreseller AS r
    ON r.ResellerKey=rs.ResellerKey
JOIN dimproduct AS p
	ON rs.ProductKey=p.ProductKey
JOIN dimproductsubcategory AS psc
    ON p.ProductSubcategoryKey=psc.ProductSubcategoryKey
JOIN dimproductcategory AS pc
    ON psc.ProductCategoryKey=pc.ProductCategoryKey
JOIN dimgeography AS geo
    ON r.GeographyKey=geo.GeographyKey;