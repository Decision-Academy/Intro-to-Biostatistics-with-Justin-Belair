# =============================================================================
# Introduction to Biostatistics - Descriptive Statistics:
# Variance and Standard Deviation (Coding Example)
# Section 2-14
# Author: Justin Belair | Statistical Consultant
# =============================================================================

# -----------------------------------------------------------------------------
# VARIANCE AND STANDARD DEVIATION
# -----------------------------------------------------------------------------
# The variance and standard deviation measure the spread (dispersion) of data
# around the mean.
#
# Let's compute both for a salary dataset.
# -----------------------------------------------------------------------------

salary2 <- c(1000, 2000, 3000, 4000, 5000)

# Sample variance
var(salary2)

# Sample standard deviation
sd(salary2)

# Confirm that sd() is simply the square root of var()
sqrt(var(salary2))

# -----------------------------------------------------------------------------
# NOTE ON DENOMINATORS IN R
# -----------------------------------------------------------------------------
# R's var() function uses the *unbiased* formula with (n - 1) as the
# denominator (Bessel's correction). You can verify this by checking the
# documentation with ?var, which states:
#   "The denominator n - 1 is used which gives an unbiased estimator of the
#    (co)variance for i.i.d. observations."
#
# This is different from Python's numpy, where the default np.var() uses n
# as the denominator (biased estimator). To match R's behavior in Python,
# you must set ddof=1, e.g.: np.var(data, ddof=1).
# -----------------------------------------------------------------------------
