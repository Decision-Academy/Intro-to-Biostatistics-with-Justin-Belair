# =============================================================================
# Introduction to Biostatistics - Descriptive Statistics: The Median
# Sections 2-6, 2-7, 2-8
# Author: Justin Belair | Statistical Consultant
# =============================================================================

# -----------------------------------------------------------------------------
# THE MEDIAN
# -----------------------------------------------------------------------------
# The median is another measure of central tendency. It is the value that
# separates the data into two equal parts after the data has been sorted in
# increasing order.
#
# - If the number of data points is odd, the median is the middle value.
# - If the number of data points is even, the median is the average of the
#   two middle values.
# -----------------------------------------------------------------------------

# --- Example: Salary data with an outlier ------------------------------------
# Recall the salary data: 1000, 1300, 1500, 2000, 50000 (ordered)
# The median is the middle value: $1,500 -- much more representative of a
# "typical" salary than the mean ($11,160), which was pulled up by the outlier.

salary <- c(1000, 2000, 1500, 1300, 50000)

salary_median <- median(salary)
salary_median

# -----------------------------------------------------------------------------
# ROBUSTNESS
# -----------------------------------------------------------------------------
# The median is considered a "robust" measure of central tendency. In
# statistics, "robust" means a procedure performs well even when the data has
# undesirable or problematic features (e.g., outliers or skewness).
#
# The median is more robust to outliers than the mean.
# -----------------------------------------------------------------------------

# --- Example: The median is NOT robust to everything -------------------------
# Consider weekly salaries of 6 individuals:
#   1300, 5000, 1600, 1500, 1400, 10000
# Ordered: 1300, 1400, 1500, 1600, 5000, 10000
# Median = (1500 + 1600) / 2 = $1,550

# Now change one data point (1500 -> 15000):
#   1300, 5000, 1600, 15000, 1400, 10000
# Ordered: 1300, 1400, 1600, 5000, 10000, 15000
# Median = (1600 + 5000) / 2 = $3,300
#
# By changing one data point, the median more than doubled!

# -----------------------------------------------------------------------------
# KEY TAKEAWAYS
# -----------------------------------------------------------------------------
# - A statistic is robust to *certain* features -- it cannot be robust to
#   everything!
# - The mean is robust to changes in the middle of the distribution; the
#   median is robust to outliers.
# - In statistics, nothing is perfect. We use different tools to answer
#   different questions in different settings.
# -----------------------------------------------------------------------------
