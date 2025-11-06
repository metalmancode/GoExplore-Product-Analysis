## GoExplore - Product Performance Analysis

This project is an end-to-end analysis of product sales performance for GoExplore, a retail company. The goal was to build a dynamic dashboard for the executive (Sabah), finance (Sarah), and retail (Dustin) teams to identify key profit drivers and market opportunities.

This analysis started as a visualization project but became a critical data quality investigation upon discovering a hidden $1 million loss in the raw data.

Tools Used: Google BigQuery (SQL), Looker Studio, and Google Sheets.

1. The $1M Data Quality Investigation
During initial data profiling, I discovered over 500 sales transactions with a unit_sale_price of $0. While these sales generated $0 in revenue, their product costs were still being calculated, resulting in a hidden loss of $971,406.29.

This "dirty data" was incorrectly dragging down the profitability of key product lines like 'Golf Equipment' and 'Camping Equipment', giving leadership a false picture of their performance.

The Finding (from Google Sheets / BigQuery):
My investigation query (sql/01_investigation_query.sql) identified the 16 products responsible for this loss.

This insight was critical. The solution was to filter out these non-sale transactions from our "master view" to ensure all reporting was based on actual sales.

2. The Data Pipeline (BigQuery)
To create a clean, fast, and reliable data source for the dashboard, I built a single "master view" in BigQuery. This view:

Joins 4 raw tables: daily_sales, products, retailers, and methods.

Calculates key business metrics (Revenue, Profit, and Profit Margin) from raw quantity, unit_sale_price, and unit_cost fields.

Cleans the data by filtering out the $0 sales identified in the investigation.

Groups the data by product, country, and month to be ready for any visualization.

You can view the full script here: sql/02_master_view_query.sql.

3. The Final Dashboard (Looker Studio)
The final dashboard connects live to the BigQuery master view. It is designed to provide answers for the entire leadership team.

Key Features & Insights:
For Sarah (Finance): The "Profit Margin" chart  shows the true profitability of each product line after fixing the $1M data error. We can see 'Personal Accessories' is our most profitable line, not just our highest revenue.

For Dustin (Retail): The Country Filter allows him to see the top-selling and most profitable products for any specific market, helping him build a "success playbook" for new retailers.

For Sabah (Executive): All charts are built with Drill-Down enabled. Sabah can click on "Personal Accessories" to see the product types inside it (e.g., "Eyewear," "Watches"), and click again to see the individual products, giving him a full overview from 30,000 feet down to 3 feet.
