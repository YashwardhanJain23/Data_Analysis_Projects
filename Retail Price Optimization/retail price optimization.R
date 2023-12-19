install.packages("reshape2")


library(readr)
library(dplyr)
library(ggplot2)
library(corrplot)
library(reshape2)



retail_price <- read.csv("C:/Users/yashj/OneDrive/Desktop/Data_Analysis_Projects/Retail Price Optimization/retail_price.csv")
View(retail_price)

head(retail_price)

# Check for missing values and sum them up for each column
missing_values <- retail_price %>%
  summarise_all(~ sum(is.na(.)))

print(missing_values)

# Summary statistics for numeric columns in 'retail_price' dataset
summary(retail_price)

# Create a histogram for the 'total_price' column
ggplot(retail_price, aes(x = total_price)) +
  geom_histogram(binwidth = 200, color = "black", fill = "skyblue") +
  labs(title = "Distribution of Total Price", x = "Total Price") +
  theme_minimal()

# Create a scatter plot for 'qty' vs 'total_price' with a linear trendline
ggplot(retail_price, aes(x = qty, y = total_price)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Quantity vs Total Price", x = "Quantity", y = "Total Price") +
  theme_minimal()

cat("Thus, the relationship between quantity and total prices is linear. It indicates that the price structure is based on a fixed unit price, where the total price is calculated by multiplying the quantity by the unit price.")

# Create a bar plot for average total prices by product categories
avg_total_prices <- aggregate(total_price ~ product_category_name, retail_price, mean)

ggplot(avg_total_prices, aes(x = product_category_name, y = total_price)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Average Total Price by Product Category", x = "Product Category", y = "Average Total Price") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotating x-axis labels for better readability

# Assuming 'weekday' and 'holiday' are categorical variables representing days and holiday status
# Convert 'weekday' and 'holiday' columns to factors if they are not already factors
retail_price$weekday <- as.factor(retail_price$weekday)
retail_price$holiday <- as.factor(retail_price$holiday)

# Box plot of total prices by weekday
ggplot(retail_price, aes(x = weekday, y = total_price)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Box Plot of Total Price by Weekday", x = "Weekday", y = "Total Price") +
  theme_minimal()

# Box plot of total prices by holiday
ggplot(retail_price, aes(x = holiday, y = total_price)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Box Plot of Total Price by Holiday", x = "Holiday", y = "Total Price") +
  theme_minimal()

# Selecting only numerical columns for correlation analysis
numerical_data <- subset(retail_price, select = sapply(retail_price, is.numeric))

# Calculating correlation matrix
correlation_matrix <- cor(numerical_data)

# Convert correlation matrix to long format for plotting
correlation_melted <- melt(correlation_matrix)

# Plotting the correlation heatmap
ggplot(correlation_melted, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title = "Correlation Heatmap of Numerical Features", x = "Features", y = "Features") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

cat("Understanding and optimizing retail prices involves a critical analysis of competitors’ pricing strategies. By continuously monitoring and benchmarking against competitors’ prices, retailers can uncover valuable insights. This allows for strategic decisions on pricing—whether it's to position products competitively by pricing above or below the competition. Now, let’s compute the average difference in prices compared to competitors, categorized by product category.")

# Calculate the competitor price difference
retail_price$comp_price_diff <- retail_price$unit_price - retail_price$comp_1

# Group by product category and calculate the average competitor price difference
avg_price_diff_by_category <- aggregate(comp_price_diff ~ product_category_name, retail_price, mean)

# Plotting the average competitor price difference by product category
ggplot(avg_price_diff_by_category, aes(x = product_category_name, y = comp_price_diff)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Average Competitor Price Difference by Product Category",
       x = "Product Category",
       y = "Average Competitor Price Difference")

# Using a basic linear regression model
model_lm <- lm(total_price ~ qty + unit_price + comp_1 + product_score + comp_price_diff, data = retail_price)

# Predicting prices
predictions <- predict(model_lm, newdata = retail_price)

# Visualizing predicted vs. actual prices
ggplot(retail_price, aes(x = total_price, y = predictions)) +
  geom_point(color = 'blue', size = 3, alpha = 0.7, aes(label = 'Actual vs. Predicted')) +
  geom_abline(intercept = 0, slope = 1, color = 'red', aes(label = 'Ideal Prediction')) +
  labs(title = 'Predicted vs. Actual Retail Price',
       x = 'Actual Retail Price',
       y = 'Predicted Retail Price') +
  theme_minimal() +
  theme(legend.position = 'bottom') +
  guides(color = guide_legend(title = NULL))
