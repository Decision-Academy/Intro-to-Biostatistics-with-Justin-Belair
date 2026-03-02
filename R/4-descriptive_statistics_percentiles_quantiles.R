# =============================================================================
# Introduction to Biostatistics - Descriptive Statistics:
# Percentiles and Quantiles (Coding Example)
# Section 2-18
# Author: Justin Belair | Statistical Consultant
# =============================================================================

# -----------------------------------------------------------------------------
# PERCENTILES AND QUANTILES
# -----------------------------------------------------------------------------
# In R, the quantile() function computes percentiles and quantiles.
# The 'probs' argument specifies which quantiles to compute (values from 0 to 1).
#
# For more details, see the documentation: ?quantile
# -----------------------------------------------------------------------------

salary <- c(1000, 2000, 3000, 4000, 5000)

# Compute several quantiles at once (0th, 1st, 2nd, 3rd, 25th, 50th, 95th percentiles)
quantile(salary, probs = c(0, 0.01, 0.02, 0.03, 0.25, 0.5, 0.95))

# -----------------------------------------------------------------------------
# DIFFERENT QUANTILE ALGORITHMS (type argument)
# -----------------------------------------------------------------------------
# R supports 9 different quantile algorithms via the 'type' argument.
# The default is type = 7. Other common choices include type 6 and type 8.
# See ?quantile for full details on each algorithm.
# -----------------------------------------------------------------------------

# Using type = 6
quantile(salary, probs = c(0, 0.01, 0.02, 0.03, 0.25, 0.5, 0.95), type = 6)

# Using type = 8
quantile(salary, probs = c(0, 0.01, 0.02, 0.03, 0.25, 0.5, 0.95), type = 8)
