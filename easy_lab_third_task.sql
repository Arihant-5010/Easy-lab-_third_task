create database task_intern;
use task_intern;

/*Total Sales and Profit by Category*/
SELECT 
    Category,
    SUM(Amount) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
    details
GROUP BY 
    Category
ORDER BY 
    TotalSales DESC;
    
/*Orders with High Quantity (more than 5 items)*/
SELECT 
    `Order ID`,       
    Quantity,
    Amount,
    Category,
    `Sub-Category`       
FROM 
    details
WHERE 
    Quantity > 5;
    
/*Total Sales and Profit by Category (filtered by Quantity > 2)*/
SELECT 
    Category,
    SUM(Amount) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
    details
WHERE 
    Quantity > 2
GROUP BY 
    Category
ORDER BY 
    TotalSales DESC;
    
/*Combine orders and details for full order info*/
SELECT 
    o.`Order ID`,
    o.CustomerName,
    o.City,
    d.Amount,
    d.Profit,
    d.Category
FROM 
    orders o
INNER JOIN 
    details d ON o.`Order ID` = d.`Order ID`;
    
    /*Show all orders, even if they don’t have matching details*/
    SELECT 
    o.`Order ID`,
    o.CustomerName,
    d.Amount
FROM 
    orders o
LEFT JOIN 
    details d ON o.`Order ID` = d.`Order ID`;
    
    /*Show all details, even if orders are missing*/
    SELECT 
    d.`Order ID`,
    d.Category,
    o.City
FROM 
    details d
RIGHT JOIN 
    orders o ON d.`Order ID` = o.`Order ID`;
    
    /* Cities with above-average total sales*/
    SELECT 
    City,
    SUM(Amount) AS TotalSales
FROM 
    orders o
JOIN 
    details d ON o.`Order ID` = d.`Order ID`
GROUP BY 
    City
HAVING 
    TotalSales > (
        SELECT AVG(city_sales)
        FROM (
            SELECT SUM(Amount) AS city_sales
            FROM orders o
            JOIN details d ON o.`Order ID` = d.`Order ID`
            GROUP BY City
        ) AS avg_table
    );
    
    /*Average profit and total quantity per payment mode*/
    SELECT 
    PaymentMode,
    AVG(Profit) AS AvgProfit,
    SUM(Quantity) AS TotalQuantity
FROM 
    details
GROUP BY 
    PaymentMode;
    
    
    
    /* Sales Analysis by Category and Sub-Category*/
    SELECT 
    Category,
    `Sub-Category`,
    SUM(Amount) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
    details
WHERE 
    Quantity > 2
GROUP BY 
    Category, `Sub-Category`
ORDER BY 
    TotalSales DESC;
    
    /* Aggregate Sales by Payment Mode*/
    SELECT 
    PaymentMode,
    SUM(Amount) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
    details
WHERE 
    Quantity > 2
GROUP BY 
    PaymentMode
ORDER BY 
    TotalSales DESC;
    
    /*Top Customers by Sales*/
    SELECT 
    o.CustomerName,
    SUM(d.Amount) AS TotalSales
FROM 
    orders o
JOIN 
    details d ON o.`Order ID` = d.`Order ID`
WHERE 
    d.Quantity > 2
GROUP BY 
    o.CustomerName
ORDER BY 
    TotalSales DESC
LIMIT 10;

/*compare sales and profit across different states*/
SELECT 
    o.State,
    SUM(d.Amount) AS TotalSales,
    SUM(d.Profit) AS TotalProfit
FROM 
    orders o
JOIN 
    details d ON o.`Order ID` = d.`Order ID`
WHERE 
    d.Quantity > 2
GROUP BY 
    o.State
ORDER BY 
    TotalSales DESC;
    
    /*Compare Total Sales for Each Category*/
    SELECT 
    Category,
    SUM(Amount) AS TotalSales
FROM 
    details
GROUP BY 
    Category
HAVING 
    TotalSales > (
        SELECT AVG(TotalSales) 
        FROM (
            SELECT SUM(Amount) AS TotalSales
            FROM details
            GROUP BY Category
        ) AS AvgSales
    )
ORDER BY 
    TotalSales DESC;
    
   
    
    
    /*Sales by City and Sub-Category*/
    SELECT 
    o.City,
    d.`Sub-Category`,
    SUM(d.Amount) AS TotalSales
FROM 
    orders o
JOIN 
    details d ON o.`Order ID` = d.`Order ID`
WHERE 
    d.Quantity > 2
GROUP BY 
    o.City, d.`Sub-Category`
ORDER BY 
    TotalSales DESC;

















