# 📊 GA4 E-commerce Analysis

## 🔹 Project Overview

This project analyzes user behavior in an e-commerce platform using the Google Analytics 4 (GA4) sample dataset from BigQuery.

The goal is to understand the user journey, identify drop-off points, and provide actionable insights to improve conversion rates.

---

## 🔹 Dataset

* Source: Google Analytics 4 Public Dataset
* Table: `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
* Type: Event-based data (user interactions)

---

## 🔹 Tools Used

* SQL (Google BigQuery)
* Power BI

---

## 🔹 Key Objectives

* Analyze user behavior across the platform
* Build a conversion funnel (View → Add to Cart → Purchase)
* Evaluate traffic sources performance
* Identify top-performing countries
* Detect drop-off points in the funnel

---

## 🔹 Key KPIs

* Total Users
* Total Sessions
* Conversion Rate
* Add-to-Cart Rate
* Purchase Rate
* Top Traffic Source
* Top Countries

---

## 🔹 Funnel Analysis

The user journey is analyzed through three main stages:

1. **View Item**
2. **Add to Cart**
3. **Purchase**

Conversion rates are calculated between each step to identify where users drop off.

---

## 🔹 Analysis Performed

### 1. Traffic Source Analysis

* Compared different traffic sources (Google, Direct, etc.)
* Identified sources with high traffic but low conversion

### 2. Country Analysis

* Analyzed user activity by country
* Compared traffic vs purchase behavior across regions

### 3. Funnel Analysis

* Measured conversion rates between each funnel stage
* Identified major drop-off points

---

## 🔹 Key Insights

* Some traffic sources generate high user volume but low conversion rates
* Significant drop-off occurs between product view and add-to-cart stage
* Certain countries show high engagement but low purchasing activity

---

## 🔹 Recommendations

* Improve landing pages for high-traffic, low-conversion sources
* Optimize product pages (pricing, description, UX) to increase add-to-cart rate
* Enhance localization (payment methods, language) for underperforming countries

---

## 🔹 Dashboard

The Power BI dashboard includes:

* KPI summary (Users, Conversion Rate, Purchases)
* Funnel visualization
* Traffic source performance
* Country distribution (map)
* User trends over time

---

## 🔹 Project Structure

```
/sql        → SQL queries  
/dashboard  → Power BI file  
/images     → Dashboard screenshots  
/insights   → Business insights  
```

---

## 🔹 Conclusion

This project demonstrates how raw event-based data can be transformed into meaningful business insights using SQL and visualization tools.

It focuses on real-world analytical thinking rather than machine learning, aligning with the responsibilities of a Data Analyst.

---
