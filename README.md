# Brazilian E-Commerce Sales Dashboard

## Project Overview
This project presents an interactive dashboard analyzing Brazilian e-commerce sales data. The dashboard provides comprehensive insights into sales performance, customer behavior, payment methods, and product trends across different regions and time periods.

## Dataset Source
**Brazilian E-Commerce Public Dataset by Olist**
- **Link:** https://www.kaggle.com/olistbr/brazilian-ecommerce
- **Source:** Kaggle
- **Description:** This dataset contains real Brazilian e-commerce transactions from Olist, including customer data, orders, products, payments, reviews, and geographic information.

## Tools & Technologies Used
- **Python** - Data cleaning, exploratory data analysis (EDA), and data processing
- **SQL** - Database queries and data extraction
- **Data Visualization** - Interactive dashboards for business intelligence
- **Data Cleaning** - Removing duplicates, handling missing values, standardizing formats
- **Exploratory Data Analysis (EDA)** - Statistical analysis and pattern discovery

## Dashboard Components

### Home Dashboard - Brazilian E-commerce Sales
A comprehensive overview page featuring:
- **Key Metrics:**
  - Total Revenue: 9.98K
  - Average Revenue per Order: 203.67
  - Average Order Value: 226.81
  - Total Orders: 44
  - Total Customers: 44
  - 5-Star Rating Percentage: 48.84%
  - Total Payment: 9.98K
  - Average Rating: 4.12

- **Filters:**
  - Customer State (currently showing AP)
  - Year/Month selection (2017, 2018)
  - Payment Type filters (boleto, credit_card, voucher)

- **Navigation:** Quick access to analytics and charts sections

### Analytics Dashboard
A detailed multi-chart analysis showing:

**Top Section:**
- **Avg Rating:** 4.21 out of 5
- **Total Revenue:** 6.45M with growth trend (0.00M to 12.91M)
- **Order Status:** 40.13K delivered orders, canceled orders also tracked
- **Payment Methods:** Breakdown of boleto, credit_card, and debit_card usage
- **Customer State:** Filter options available

**Charts & Visualizations:**

1. **Count of Different Ratings**
   - Bar chart showing distribution of review scores (1-5 stars)
   - Peak at 5-star ratings (~20K reviews)

2. **Total Revenue by Year and Month**
   - Line chart tracking revenue trends from Oct 2016 to Oct 2017
   - Shows steady growth pattern with seasonal variations

3. **Relation between Freight and Prices**
   - Scatter plot analyzing product prices vs freight costs
   - Categories: product_english, industry_commerce, kitchen_dining, la_cuisine
   - Price range: 0M to 0.5M, Freight values: 0K to 80K

4. **Total Revenue by City**
   - Horizontal bar chart ranking cities by revenue
   - Top cities: Sao Paulo, Rio de Janeiro, Belo Horizonte, Brasilia, Porto Alegre

5. **Payment Methods Count**
   - Bar chart comparing payment method popularity
   - Credit card leads with ~40K transactions
   - Boleto follows with ~20K transactions

6. **Total Revenue by Products**
   - Horizontal bar chart showing top product categories
   - Top performers: bed_bath, health_b, watches, sports_leisure, computers

7. **Top Products with More Orders**
   - Treemap visualization showing product categories by order volume
   - Key categories: bed_bath_table, furniture_decor, sports_leisure, garden_tools
   - Other notable: health_beauty, computers, toys, watches, cooling_appliances

## Data Processing Methodology

### Data Cleaning
- Removed duplicate entries
- Handled missing values appropriately
- Standardized date formats and categorical variables
- Cleaned payment type and order status fields
- Validated customer and product information

### Exploratory Data Analysis (EDA)
- Analyzed distribution of ratings and reviews
- Examined revenue trends over time
- Identified top-performing cities and products
- Studied payment method preferences
- Analyzed freight and pricing relationships
- Discovered seasonal patterns in sales

### Key Insights Discovered
1. **Strong Performance:** 4.21 average rating indicates customer satisfaction
2. **Growth Trend:** Steady revenue increase from Oct 2016 to Oct 2017
3. **Geographic Concentration:** Sao Paulo dominates revenue generation
4. **Payment Preference:** Credit cards are the most popular payment method
5. **Product Leaders:** Bed & bath products consistently top sales
6. **Customer Quality:** 48.84% of customers give 5-star ratings

## How to Use
1. Select desired filters (Customer State, Year, Month, Payment Type)
2. Navigate between Home and Analytics sections
3. Hover over charts for detailed information
4. Use year/month selectors to view specific time periods
5. Analyze trends and patterns across different dimensions

## Performance Metrics
- **Avg Rating:** 4.21/5
- **Total Revenue:** 6.45M
- **Order Completion Rate:** 40.13K delivered orders
- **Customer Satisfaction:** 48.84% 5-star ratings
- **Top Product Revenue:** Bed & Bath products leading

## Future Improvements
- Add predictive analytics for revenue forecasting
- Implement customer segmentation analysis
- Add more granular geographic analysis
- Include seasonal trend predictions
- Expand product category insights

---

**Project created using Python data cleaning, SQL queries, and exploratory data analysis techniques.**

**Project created using Python data cleaning, SQL queries, and exploratory data analysis techniques.**
Dashobard link:
https://drive.google.com/file/d/1e_XPK6TfzYacvHQaVWEgqmi43S6VAeQN/view?usp=sharing
