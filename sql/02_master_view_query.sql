-- Final Master View: v_product_performance
-- This view joins all tables, calculates metrics, filters $0 sales,
-- and includes date/retailer info for Looker Studio.
WITH sales_with_details AS (
  SELECT
    DATE_TRUNC(sales.date, MONTH) AS sales_month,
    products.product_line,
    products.product_type,
    products.product AS product_name,
    retailers.Country,
    retailers.Retailer_Name,
    sales.quantity,
    (sales.quantity * sales.unit_sale_price) AS revenue,
    ( (sales.quantity * sales.unit_sale_price) - (sales.quantity * products.unit_cost) ) AS profit
  FROM
    `goexplore-476414.Bootcamp.daily_sales_renamed` AS sales
  LEFT JOIN
    `goexplore-476414.Bootcamp.products_renamed` AS products
    ON sales.product_number = products.product_number
  LEFT JOIN
    `goexplore-476414.Bootcamp.retailers_renamed` AS retailers
    ON sales.retailer_code = retailers.retailer_code
  WHERE
    sales.unit_sale_price > 0
)
SELECT
  sales_month,
  product_line,
  product_type,
  product_name,
  Country,
  Retailer_Name,
  SUM(quantity) AS total_quantity,
  SUM(revenue) AS total_revenue,
  SUM(profit) AS total_profit,
  SAFE_DIVIDE(SUM(profit), SUM(revenue)) AS profit_margin
FROM
  sales_with_details
GROUP BY
  1, 2, 3, 4, 5, 6;
