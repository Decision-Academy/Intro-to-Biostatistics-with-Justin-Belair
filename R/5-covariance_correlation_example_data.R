# =============================================================================
# Introduction to Biostatistics - Modelling:
# Covariance and Correlation (Example with Data)
# Section 6-3
# Author: Justin Belair | Statistical Consultant
# =============================================================================

# --- Load required packages --------------------------------------------------
library(ggplot2)
library(dplyr)

set.seed(1)

# -----------------------------------------------------------------------------
# COVARIANCE AND CORRELATION
# -----------------------------------------------------------------------------
# In a sample, we use the sample covariance and sample correlation to estimate
# the population covariance and correlation.
#
# Sample covariance:
#   s_XY = (1 / (n-1)) * sum( (X_i - X_bar) * (Y_i - Y_bar) )
#
# Sample correlation:
#   r_XY = s_XY / (s_X * s_Y)
#
# The correlation standardizes the covariance to lie between -1 and 1.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# THE DIABETES DATASET
# -----------------------------------------------------------------------------
# This dataset contains information about patients with diabetes, including
# age, cholesterol levels, and other health metrics.
#
# Source: Vanderbilt Biostatistics Datasets (https://hbiostat.org/data/)
# References:
#   - Willems JP, Saunders JT, et al. (1997). Southern Medical Journal 90:814-820
#   - Schorling JB, Roach J, et al. (1997). Preventive Medicine 26:92-101
# Data dictionary: https://hbiostat.org/data/repo/cdiabetes
# -----------------------------------------------------------------------------

data <- read.csv("https://raw.githubusercontent.com/Decision-Academy/Intro-to-Biostatistics-with-Justin-Belair/refs/heads/main/data/diabetes.csv")

# --- Scatter plot of Cholesterol vs Age --------------------------------------
# A scatter plot shows the relationship between two continuous variables.

chol.age.plot <- data %>%
  ggplot(aes(x = age, y = chol)) +
  geom_point() +
  labs(title = "Scatter Plot of Cholesterol vs Age",
       x = "Age (years)",
       y = "Cholesterol (mg/dL)") +
  theme_minimal()

chol.age.plot

# --- Compute covariance and correlation --------------------------------------
# First, remove rows with missing values in chol or age
data.complete <- data[complete.cases(data$chol) & complete.cases(data$age), ]

# Sample covariance between cholesterol and age
var(data.complete$chol, data.complete$age)

# Sample correlation between cholesterol and age
cor(data.complete$chol, data.complete$age)

# Verify: correlation = covariance / (sd_X * sd_Y)
var(data.complete$chol, data.complete$age) /
  (sd(data.complete$chol) * sd(data.complete$age))
