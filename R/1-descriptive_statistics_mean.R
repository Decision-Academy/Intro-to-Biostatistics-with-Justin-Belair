# =============================================================================
# Introduction to Biostatistics - Descriptive Statistics: The Mean
# Sections 2-3, 2-4, 2-5
# Author: Justin Belair | Statistical Consultant
# =============================================================================

options(max.print = 100)

# -----------------------------------------------------------------------------
# THE MEAN
# -----------------------------------------------------------------------------
# The most basic summary statistic is the mean. It only makes sense to compute
# a mean for quantitative variables.
#
# The mean is the average of the data points, calculated by summing all values
# and dividing by the number of data points.
#
# Notation: For a variable X, the sample mean is denoted x-bar.
#   Formula: x_bar = (1/n) * sum(x_i)  for i = 1 to n
# -----------------------------------------------------------------------------

# --- Example: Rolling a die 5 times -----------------------------------------
# We roll a die 5 times and record: 2, 6, 1, 4, 5
x <- c(2, 6, 1, 4, 5)
x_bar <- mean(x)
x_bar

# -----------------------------------------------------------------------------
# THE MEAN IS NOT PERFECT
# -----------------------------------------------------------------------------
# The mean is a measure of central tendency -- it seeks to describe the
# "center" of the distribution, what a "typical" value looks like.
#
# However, it is sensitive to outliers. Consider weekly salaries of 5
# individuals: 1000, 2000, 1500, 1300, and 50000.
# -----------------------------------------------------------------------------

salary <- c(1000, 2000, 1500, 1300, 50000)
salary_mean <- mean(salary)
salary_mean

# The mean is $11,160 -- not quite representative of a "typical" salary!
# This is due to a single outlier (e.g., a CEO earning $50,000/week), while
# the others have working-class salaries. The mean is heavily influenced by
# this single extreme value.
#
# This is one reason to complement summary statistics with visual
# representations of the data.
