## ----echo=FALSE------------------------------------------------------------------------------------------------------------
options(max.print = 100)
knitr::opts_chunk$set(warning = FALSE, message = FALSE)
library(ggplot2)
set.seed(1)


## --------------------------------------------------------------------------------------------------------------------------
sample_data <- read.csv("session_3_hw_data.csv")

head(sample_data)


## --------------------------------------------------------------------------------------------------------------------------
mean(sample_data$X0)
median(sample_data$X0)
sd(sample_data$X0)



## --------------------------------------------------------------------------------------------------------------------------
quantile(sample_data$X0, 
         probs = c(0.01, 0.03, 0.25, 0.5, 0.75, 0.95, 0.99))



## ----echo = FALSE, fig.width=7, fig.height=3-------------------------------------------------------------------------------
# Visualize the data
ggplot(sample_data, aes(x = X0)) +
  geom_density(fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Sample Data", x = "Value", y = "Frequency") +
  theme_minimal()


## --------------------------------------------------------------------------------------------------------------------------
rolls <- 10000
die1 <- sample(1:6, rolls, replace = TRUE)
die2 <- sample(1:6, rolls, replace = TRUE)
sums <- die1 + die2

