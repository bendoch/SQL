USE adventureworks;

-- Implementa una vista denominata Product al fine di creare unʼanagrafica (dimensione) prodotto completa.
--  La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome prodotto, il nome della sottocategoria associata
--  e il nome della categoria associata.

CREATE VIEW vw_prodotto 
AS(
   SELECT p.ProductKey
          , p.EnglishProductName
          , pc.EnglishProductCategoryName
          , psc.EnglishProductSubcategoryName
   FROM dimproduct AS p
   JOIN dimproductsubcategory AS psc
       ON psc.ProductSubcategoryKey=p.ProductSubcategoryKey
	JOIN dimproductcategory AS pc
       ON pc.ProductCategoryKey=psc.ProductCategoryKey
   );
   
-- Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa.
-- La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome del reseller, il nome della città e il nome della regione.

CREATE VIEW vw_reseller
AS(
   SELECT r.ResellerKey
          , r.ResellerName
          , g.City
          , g.EnglishCountryRegionName
   FROM dimreseller AS r
   JOIN dimgeography AS g
       ON g.GeographyKey=r.GeographyKey
);
   
-- Crea una vista denominata Sales che deve restituire la data dellʼordine, il codice documento, la riga di corpo del documento, 
-- la quantità venduta, lʼimporto totale e il profitto.

CREATE VIEW vw_sales
AS(
   SELECT p.ProductKey
          , rs.ResellerKey
		  , rs.OrderDate
          , rs.SalesOrderNumber
          , rs.SalesOrderLineNumber
          , rs.OrderQuantity
          , rs.SalesAmount
          , rs.TotalProductCost
          , p.StandardCost
          , IFNULL(rs.TotalProductCost, p.StandardCost * rs.OrderQuantity) AS TotalCost
          , rs.SalesAmount - IFNULL(rs.TotalProductCost, p.StandardCost * rs.OrderQuantity) AS Profit
   FROM factresellersales AS rs
   JOIN dimproduct AS p
       ON p.ProductKey=rs.ProductKey
);
