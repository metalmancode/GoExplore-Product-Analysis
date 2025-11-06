-- Investigation: What are our $0 sales and what's their true cost?
SELECT
  products.product_line,
  products.product_type,
  products.product AS product_name,
  COUNT(*) AS number_of_free_transactions,
  SUM(sales.quantity) AS total_quantity_given_away,
  SUM(sales.quantity * products.unit_cost) AS total_cost_of_giveaways
FROM
  `goexplore-476414.Bootcamp.daily_sales_renamed` AS sales
LEFT JOIN
  `goexplore-476414.Bootcamp.products_renamed` AS products
  ON sales.product_number = products.product_number
WHERE
  sales.unit_sale_price = 0
GROUP BY 1, 2, 3
ORDER BY total_cost_of_giveaways DESC;
