# =============================================================================
# Introduction to Biostatistics - Visualizations
# Section 3
# Author: Justin Belair | Statistical Consultant
# =============================================================================

# --- Load required packages --------------------------------------------------
library(ggplot2)
# library(gridExtra)

options(max.print = 100)
set.seed(1)

# =============================================================================
# PART 1: SUMMARY STATISTICS RECAP
# =============================================================================
# Before visualizing data, compute some key summary statistics on a small
# sample dataset. Note the outlier value of 2500.
# =============================================================================

sample_data <- c(120, 145, 130, 200, 155, 165, 2500, 175, 190, 150)

# --- Mean and median ---------------------------------------------------------
mean(sample_data)
median(sample_data)

# --- Variance and standard deviation -----------------------------------------
var(sample_data)
sd(sample_data)

# --- Percentiles -------------------------------------------------------------
quantile(sample_data, probs = c(0.01, 0.03, 0.25, 0.5, 0.75, 0.95, 0.99))

# =============================================================================
# PART 2: HISTOGRAMS
# =============================================================================
# A histogram shows the frequency distribution of a continuous variable by
# grouping values into bins.
# =============================================================================

# --- Histogram of the small sample data (with outlier) -----------------------
sample_data <- data.frame(value = c(120, 145, 130, 200, 155, 165, 2500, 175, 190, 150))

ggplot(sample_data, aes(x = value)) +
  geom_histogram(binwidth = 25, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Sample Data", x = "Value", y = "Frequency") +
  theme_minimal()

# --- Histogram of gamma-distributed data -------------------------------------
# Generate a larger dataset from a Gamma distribution to illustrate skewness.
sample_data_gamma <- data.frame(value = rgamma(n = 1000, shape = 2, scale = 50))

ggplot(sample_data_gamma, aes(x = value)) +
  geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Sample Data", x = "Value", y = "Frequency") +
  theme_minimal()

# --- Histogram with density on the y-axis ------------------------------------
ggplot(sample_data_gamma, aes(x = value)) +
  geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.7,
                 aes(y = after_stat(density))) +
  labs(title = "Histogram of Sample Data", x = "Value", y = "Density") +
  theme_minimal()

# =============================================================================
# PART 3: DENSITY PLOT
# =============================================================================
# A density plot is a smoothed version of a histogram.
# =============================================================================

ggplot(sample_data_gamma, aes(x = value)) +
  geom_density(fill = "blue", alpha = 0.7) +
  labs(title = "Density Plot of Sample Data", x = "Value", y = "Density") +
  theme_minimal()

# =============================================================================
# PART 4: VIOLIN PLOTS
# =============================================================================
# A violin plot shows the distribution shape (like a density plot) but
# oriented vertically, making it easy to compare groups.
# =============================================================================

# --- Basic violin plot -------------------------------------------------------
ggplot(sample_data_gamma, aes(x = "", y = value)) +
  geom_violin(fill = "blue", alpha = 0.7) +
  labs(title = "Violin Plot of Sample Data", x = "Density", y = "Value") +
  coord_flip() +
  theme_minimal()

# --- Violin plot with jittered data points -----------------------------------
ggplot(sample_data_gamma, aes(x = "", y = value)) +
  geom_violin(fill = "blue", alpha = 0.7) +
  geom_jitter(width = 0.3, height = 0.05, alpha = 0.25, color = "red") +
  labs(title = "Violin Plot of Sample Data", x = "Density", y = "Value") +
  coord_flip() +
  theme_minimal()

# =============================================================================
# PART 5: BOXPLOT
# =============================================================================
# A boxplot displays the median, quartiles (Q1, Q3), and potential outliers.
# =============================================================================

ggplot(sample_data_gamma, aes(x = "", y = value)) +
  geom_boxplot(fill = "blue", alpha = 0.7) +
  labs(title = "Boxplot of Sample Data", x = "Density", y = "Value") +
  coord_flip() +
  theme_minimal()

# =============================================================================
# PART 6: VIOLIN + BOXPLOT COMBO WITH DISTRIBUTION MARKERS
# =============================================================================
# Combining a violin plot with a boxplot and labeled summary statistics
# (min, Q1, median, Q3, max as red diamonds; mean as a black dot).
# =============================================================================

ggplot(sample_data_gamma, aes(x = "", y = value)) +
  geom_violin(fill = "blue", alpha = 0.7) +
  geom_boxplot(width = 0.15, color = "black", fill = NA, outlier.shape = NA, alpha = 0) +
  # Quartile points (red diamonds)
  stat_summary(fun = "quantile", fun.args = list(probs = c(0, 0.25, 0.5, 0.75, 1)),
               geom = "point", size = 2, color = "red", shape = 18) +
  # Mean point (black dot)
  stat_summary(fun = "mean", geom = "point", size = 3, color = "black") +
  # Quartile value labels
  stat_summary(fun = "quantile", fun.args = list(probs = c(0)),
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.25)),
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.5)),
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.75)),
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(1)),
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  # Mean value label
  stat_summary(fun = "mean", geom = "text",
               aes(label = after_stat(round(y, 1))),
               vjust = 2, color = "black") +
  labs(title = "Violin Plot with Distribution Markers",
       subtitle = "Showing min, Q1, median, Q3, max (red diamonds) and mean (black dot)",
       x = "Density", y = "Value") +
  coord_flip() +
  theme_minimal()

# =============================================================================
# PART 7: HISTOGRAM WITH BOXPLOT UNDERNEATH
# =============================================================================
# Stacking a histogram above a boxplot gives a combined view of the
# distribution shape and its five-number summary.
# =============================================================================

# Histogram (top panel)
p1 <- ggplot(sample_data_gamma, aes(x = value)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Histogram with Boxplot", x = "", y = "Frequency") +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        plot.margin = margin(b = 0))

# Boxplot (bottom panel)
p2 <- ggplot(sample_data_gamma, aes(x = value, y = 1)) +
  geom_boxplot(fill = "steelblue", alpha = 0.7) +
  labs(x = "Value", y = "") +
  theme_minimal() +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = margin(t = 0),
        axis.line = element_blank(),
        panel.grid = element_blank())

# Combine the two panels
grid.arrange(p1, p2, heights = c(4, 1), ncol = 1)

# =============================================================================
# PART 8: BAR PLOTS
# =============================================================================
# Bar plots are used to visualize the counts (frequencies) of categorical
# or discrete variables.
# =============================================================================

# --- Bar plot of binomial-distributed data -----------------------------------
sample_data_binomial <- data.frame(value = rbinom(n = 1000, size = 10, prob = 0.3))

ggplot(sample_data_binomial, aes(x = factor(value))) +
  geom_bar(fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count",
            aes(label = after_stat(count)),
            vjust = -0.5, color = "black", size = 3.5) +
  labs(title = "Bar Plot of Sample Data", x = "Value", y = "Count") +
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.2))) +
  theme_minimal()

# --- Bar plot of categorical data --------------------------------------------
sample_data_categorical <- data.frame(
  value = sample(c("A", "B", "C", "D", "E", "F", "G"), size = 100, replace = TRUE)
)

ggplot(sample_data_categorical, aes(x = value)) +
  geom_bar(fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count",
            aes(label = after_stat(count)),
            vjust = -0.5, color = "black", size = 3.5) +
  labs(title = "Bar Plot of Sample Data", x = "Value", y = "Count") +
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.2))) +
  theme_minimal()

# =============================================================================
# PART 9: BUILDING A VIOLIN PLOT STEP BY STEP
# =============================================================================
# This section demonstrates how to build up a ggplot layer by layer,
# starting from a bare violin and progressively adding data points,
# labels, summary statistics, and theme adjustments.
# =============================================================================

# Step 1: Base violin
p <- ggplot(sample_data_gamma, aes(x = "", y = value)) +
  geom_violin(fill = "blue", alpha = 0.3) +
  coord_flip()

p

# Step 2: Add jittered data points
p <- p +
  geom_jitter(width = 0.3, height = 0.05, alpha = 0.1, color = "black")

p

# Step 3: Add title and axis labels
p <- p +
  labs(title = "Violin Plot Example",
       x = "Density", y = "Value")

p

# Step 4: Add quartile markers (red diamonds) and mean (black dot) with labels
p <- p +
  # Quartile points
  stat_summary(fun = "quantile", fun.args = list(probs = c(0, 0.25, 0.5, 0.75, 1)),
               geom = "point", size = 2, color = "red", shape = 18) +
  # Mean point
  stat_summary(fun = "mean", geom = "point", size = 3, color = "black") +
  # Quartile value labels
  stat_summary(fun = "quantile", fun.args = list(probs = c(0)),
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.25)),
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.5)),
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.75)),
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(1)),
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  # Mean value label
  stat_summary(fun = "mean", geom = "text",
               aes(label = after_stat(round(y, 1))),
               vjust = 2, color = "black")

p

# Step 5: Clean up the theme
p <- p +
  theme_minimal() +
  theme(axis.text = element_blank(),
        panel.grid = element_blank())

p
