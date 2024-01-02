# Retail Price Optimization Analysis with R

This project conducts an analysis on retail price optimization using R, exploring various aspects of pricing strategies and competitor benchmarking.

## Overview

The analysis focuses on retail pricing strategies, competitor benchmarking, and predictive modeling using a provided dataset related to retail prices.

## Data

The dataset used for analysis (`retail_price.csv`) includes attributes such as total price, quantity, unit price, competitor prices, product score, and weekday/holiday indicators.

## Analysis Steps

1. **Data Loading and Summary:**
   - Loads the dataset and examines summary statistics.
   - Identifies missing values in each column.

2. **Exploratory Data Analysis:**
   - Conducts graphical analysis to understand the distribution of total prices and relationships between variables.
   - Investigates the relationship between quantity and total prices, indicating a linear correlation.
   - Explores average total prices by product categories using bar plots.
   - Visualizes total prices by weekday and holiday using box plots.

3. **Correlation Analysis:**
   - Computes the correlation matrix of numerical features.
   - Presents the correlation heatmap to identify relationships between variables.

4. **Competitor Price Analysis:**
   - Determines the average difference in prices compared to competitors categorized by product category.
   - Visualizes the average competitor price difference across product categories.

5. **Predictive Modeling:**
   - Implements a basic linear regression model to predict retail prices.
   - Visualizes predicted versus actual retail prices to evaluate model performance.

## Conclusion

The analysis underscores the importance of understanding competitor pricing strategies and optimizing retail prices accordingly. Insights derived from this analysis can assist retailers in making strategic decisions related to pricing, positioning products competitively, and predictive modeling for optimized retail pricing.
