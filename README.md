

#  Subscription Churn Analysis (SQL)

## Project Description

This project focuses on analyzing **subscription churn over time** using SQL. The analysis helps evaluate how well different user segments are being retained or lost month-to-month. Churn analysis is essential for making data-driven decisions to improve customer retention.

---

##  Tools & Technologies

- SQL (SQLite)
- Git/GitHub for version control
- Jupyter Notebook (optional for documentation)

---

## 📄 Dataset Overview

- **Columns**: `id`, `subscription_start`, `subscription_end`, `segment`
- **User Segments**: 87 and 30  
- **Date Range**: 2016-12-01 to 2017-03-30

Example of raw data:

| id | subscription_start | subscription_end | segment |
|----|---------------------|------------------|---------|
| 1  | 2016-12-01          | 2017-02-01       | 87      |
| 2  | 2016-12-01          | 2017-01-24       | 87      |
| 3  | 2016-12-01          | 2017-03-07       | 87      |
| 4  | 2016-12-01          | 2017-02-12       | 87      |
| 5  | 2016-12-01          | 2017-03-09       | 87      |

Date range:
- **Earliest Subscription**: `2016-12-01`
- **Latest Subscription**: `2017-03-30`

---

##  Monthly Churn Table

| month      | sum_active_87 | sum_canceled_87 | churn_rate_87 | sum_active_30 | sum_canceled_30 | churn_rate_30 |
|------------|----------------|------------------|----------------|----------------|------------------|----------------|
| 2017-01-01 | 278            | 70               | 0.2518         | 291            | 22               | 0.0756         |
| 2017-02-01 | 462            | 148              | 0.3203         | 518            | 38               | 0.0734         |
| 2017-03-01 | 531            | 258              | 0.4859         | 716            | 84               | 0.1173         |

---

##  Actionable Insights

1. **Segment 87 is at high risk**  
   - Churn rate increased significantly from **25.18% in Jan** to **48.59% in Mar**.  
   - This suggests retention issues despite growth in active users.

2. **Segment 30 is relatively stable but needs monitoring**  
   - Churn was low in Jan (**7.56%**) and Feb (**7.34%**), but increased to **11.73% in Mar**.

3. **Strong acquisition, weak retention**  
   - Both segments saw an increase in active users (e.g., Segment 87 grew from 278 to 531).  
   - However, rising churn rates offset these gains and require urgent attention.

4. **March 2017 is a red flag month**  
   - Combined cancellations: **258 (Segment 87)** + **84 (Segment 30)** = **342 total**.  
   - Indicates a possible systemic issue (e.g., billing, service drop, competitor move).

---

## 📂 Files in This Repository

- `churn_analysis.sql` – SQL code used for monthly churn calculations  
- `README.md` – This project documentation

---
Please note: The raw dataset is not available for download as this project was completed within the Codecademy workspace.


