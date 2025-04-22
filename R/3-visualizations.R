## ----echo=FALSE------------------------------------------------------------------------------------------------------------
options(max.print = 100)
library(ggplot2)
library(gridExtra)
set.seed(1)


## --------------------------------------------------------------------------------------------------------------------------
sample_data <- c(120, 145, 130, 200, 155, 165, 2500, 175, 190, 150)

# Calculate the mean and median
mean(sample_data)
median(sample_data)


## --------------------------------------------------------------------------------------------------------------------------
# Calculate the variance and standard deviation
var(sample_data)
sd(sample_data)


## --------------------------------------------------------------------------------------------------------------------------
# Calculate the 1st, 3rd, 25th, 50th, 75th, 95th, and 99th percentiles
quantile(sample_data, probs = c(0.01, 0.03, 0.25, 0.5, 0.75, 0.95, 0.99))


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
sample_data <- data.frame(value = c(120, 145, 130, 200, 155, 165, 2500, 175, 190, 150))

ggplot(sample_data, aes(x = value)) +
  geom_histogram(binwidth = 25, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Sample Data", x = "Value", y = "Frequency") +
  theme_minimal()


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
# Create a sample data frame
sample_data_gamma <- data.frame(value = rgamma(n = 1000, shape = 2, scale = 50))

# Create a histogram
ggplot(sample_data_gamma, aes(x = value)) +
  geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Sample Data", x = "Value", y = "Frequency") +
  theme_minimal()


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
ggplot(sample_data_gamma, aes(x = value)) +
  geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.7, 
                aes(y = after_stat(density))) +
  labs(title = "Histogram of Sample Data", x = "Value", y = "Density") +
  theme_minimal()


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
ggplot(sample_data_gamma, aes(x = value)) +
  geom_density(fill = "blue", alpha = 0.7) +
  labs(title = "Density Plot of Sample Data", x = "Value", y = "Density") +
  theme_minimal()


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
ggplot(sample_data_gamma, aes(x = "", y = value)) +
  geom_violin(fill = "blue", alpha = 0.7) +
  labs(title = "Violin Plot of Sample Data", x = "Density", y = "Value") +
  coord_flip() +
  theme_minimal()


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
ggplot(sample_data_gamma, aes(x = "", y = value)) +
  geom_violin(fill = "blue", alpha = 0.7) +
  geom_jitter(width = 0.3, height = 0.05, alpha = 0.25, color = "red") +
  labs(title = "Violin Plot of Sample Data", x = "Density", y = "Value") +
  coord_flip() +
  theme_minimal()


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
ggplot(sample_data_gamma, aes(x = "", y = value)) +
  geom_boxplot(fill = "blue", alpha = 0.7) +
  labs(title = "Boxplot of Sample Data", x = "Density", y = "Value") +
  coord_flip() +
  theme_minimal()


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
ggplot(sample_data_gamma, aes(x = "", y = value)) +
  geom_violin(fill = "blue", alpha = 0.7) +
  # Add boxplot without the box - just the whiskers and quartile lines
  geom_boxplot(width = 0.15, color = "black", fill = NA, outlier.shape = NA, alpha = 0) +
  # Add separate points for the quartiles for more visibility
  stat_summary(fun = "quantile", fun.args = list(probs = c(0, 0.25, 0.5, 0.75, 1)), 
               geom = "point", size = 2, color = "red", shape = 18) +
  # Keep the mean point
  stat_summary(fun = "mean", geom = "point", size = 3, color = "black") +
  
  # Add text labels with the actual values for quartiles
  stat_summary(fun = "quantile", fun.args = list(probs = c(0)), 
               geom = "text", aes(label = after_stat(round(y, 1))), vjust=-1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.25)), 
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.5)), 
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.75)), 
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(1)), 
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  
  # Add label with the actual value for mean
  stat_summary(fun = "mean", geom = "text", 
               aes(label = after_stat(round(y, 1))), 
               vjust = 2, color = "black") +
  
  labs(title = "Violin Plot with Distribution Markers", 
       subtitle = "Showing min, Q1, median, Q3, max (red diamonds) and mean (black dot)",
       x = "Density", y = "Value") +
  coord_flip() +
  theme_minimal()


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
# Create the histogram
p1 <- ggplot(sample_data_gamma, aes(x = value)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Histogram with Boxplot", x = "", y = "Frequency") +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        plot.margin = margin(b = 0))

# Create the boxplot
p2 <- ggplot(sample_data_gamma, aes(x = value, y = 1)) +
  geom_boxplot(fill = "steelblue", alpha = 0.7) +
  labs(x = "Value", y = "") +
  theme_minimal() +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = margin(t = 0),
        axis.line = element_blank(),
        panel.grid = element_blank())

# Combine the plots
grid.arrange(p1, p2, heights = c(4, 1), ncol = 1)


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
# Create a sample data frame
sample_data_binomial <- data.frame(value = rbinom(n = 1000, size = 10, prob = 0.3))

# Create a bar plot
ggplot(sample_data_binomial, aes(x = factor(value))) +
  geom_bar(fill = "blue", color = "black", alpha = 0.7) +
  # Add count labels above each bar
  geom_text(stat = "count", 
            aes(label = after_stat(count)),
            vjust = -0.5,  # Adjust vertical position (negative to place above bars)
            color = "black",
            size = 3.5) +  # Adjust text size as needed
  labs(title = "Bar Plot of Sample Data", x = "Value", y = "Count") +
  # Extend the y-axis range higher to make room for labels
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.2))) +
  theme_minimal()


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
# Create a sample data frame
sample_data_categorical <- data.frame(value = sample(c("A", "B", "C", "D", "E", "F", "G"), size = 100, replace = TRUE))

# Create a bar plot
ggplot(sample_data_categorical, aes(x = value)) +
  geom_bar(fill = "blue", color = "black", alpha = 0.7) +
  # Add count labels above each bar
  geom_text(stat = "count", 
            aes(label = after_stat(count)),
            vjust = -0.5,  # Adjust vertical position (negative to place above bars)
            color = "black",
            size = 3.5) +  # Adjust text size as needed
  labs(title = "Bar Plot of Sample Data", x = "Value", y = "Count") +
  # Extend the y-axis range higher to make room for labels
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.2))) +
  theme_minimal()


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
p <- ggplot(sample_data_gamma, aes(x = "", y = value)) +
  geom_violin(fill = "blue", alpha = 0.3) +
  coord_flip()

p


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
p <- p +
  geom_jitter(width = 0.3, height = 0.05, alpha = 0.1, color = "black")

p


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
p <- p +
  labs(title = "Violin Plot Example", 
       x = "Density", y = "Value")

p


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
p <- p + # Add separate points for the quartiles for more visibility
  stat_summary(fun = "quantile", fun.args = list(probs = c(0, 0.25, 0.5, 0.75, 1)), 
               geom = "point", size = 2, color = "red", shape = 18) +
  # Keep the mean point
  stat_summary(fun = "mean", geom = "point", size = 3, color = "black") +
  
  # Add text labels with the actual values for quartiles
  stat_summary(fun = "quantile", fun.args = list(probs = c(0)), 
               geom = "text", aes(label = after_stat(round(y, 1))), vjust=-1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.25)), 
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.5)), 
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(0.75)), 
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  stat_summary(fun = "quantile", fun.args = list(probs = c(1)), 
               geom = "text", aes(label = after_stat(round(y, 1))), vjust = -1.4, color = "red") +
  
  # Add label with the actual value for mean
  stat_summary(fun = "mean", geom = "text", 
               aes(label = after_stat(round(y, 1))), 
               vjust = 2, color = "black")

p


## ----fig.width=7, fig.height=3, echo=FALSE---------------------------------------------------------------------------------
p <- p + 
  theme_minimal() +
  theme(axis.text = element_blank(),
        panel.grid = element_blank())

p

