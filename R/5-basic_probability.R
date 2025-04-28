## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------------------
options(max.print = 100)
knitr::opts_chunk$set(warning = FALSE, message = FALSE)

set.seed(1)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
# Define the sample space
omega <- 2:12

# Define the events
E1 <- omega[omega %% 2 == 0]  # Even sums
E2 <- omega[omega > 9]  # Sums greater than 9
E3 <- c(2, 3, 5, 7, 11)  # Prime number sums


## ----echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
# Display the sets
cat("Sample space Ω:", omega, "\n")
cat("Event E1 (even sum):", E1, "\n")
cat("Event E2 (sum > 9):", E2, "\n")
cat("Event E3 (prime sum):", E3, "\n")


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
intersection_E1_E2 <- intersect(E1, E2)

union_E1_E3 <- union(E1, E3)


## ----echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
cat("E1 intersection E2:", intersection_E1_E2, "\n")
cat("E1 union E3 = ", union_E1_E3)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
dice_outcomes <- expand.grid(die1 = 1:6, die2 = 1:6)


## ----echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
head(dice_outcomes, n = 7L)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
dice_outcomes$sum <- dice_outcomes$die1 + dice_outcomes$die2
total_outcomes <- nrow(dice_outcomes)


## ----echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
head(dice_outcomes, n =7L)
cat("\n Total number of outcomes:", total_outcomes)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
dice_outcomes$E1 <- dice_outcomes$sum %% 2 == 0   # Sum is even
dice_outcomes$E2 <- dice_outcomes$sum > 9         # Sum is greater than 9
dice_outcomes$E3 <- dice_outcomes$sum %in% c(2, 3, 5, 7, 11) # Sum is prime


## ----echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
head(dice_outcomes, n = 8L)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
dice_outcomes$E1_i_E2 <- dice_outcomes$E1 & dice_outcomes$E2
dice_outcomes$E1_u_E3 <- dice_outcomes$E1 | dice_outcomes$E3
dice_outcomes$E1_c <- !dice_outcomes$E1
dice_outcomes$E1_u_E2 <- dice_outcomes$E1 | dice_outcomes$E2


## ----echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
head(dice_outcomes, n = 8L)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
P_E1 <- sum(dice_outcomes$E1) / total_outcomes
P_E2 <- sum(dice_outcomes$E2) / total_outcomes
P_E3 <- sum(dice_outcomes$E3) / total_outcomes
P_E1_intersect_E2 <- sum(dice_outcomes$E1_i_E2) / total_outcomes
P_E1_union_E3 <- sum(dice_outcomes$E1_u_E3) / total_outcomes
P_E1_complement <- sum(dice_outcomes$E1_c) / total_outcomes
P_E1_union_E2 <- sum(dice_outcomes$E1_u_E2) / total_outcomes


## ----echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
cat("P(E1) =", P_E1, "\n")
cat("P(E2) =", P_E2, "\n")
cat("P(E3) =", P_E3, "\n")
cat("P(E1 intersect E2) =", P_E1_intersect_E2, "\n")
cat("P(E1 union E3) =", P_E1_union_E3)


## ----echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
cat("Verification of P(E1) + P(E1^c) = 1:\n")
cat("P(E1) + P(E1^c) =", P_E1, "+", P_E1_complement, "=", P_E1 + P_E1_complement, "\n\n")

cat("Verification of P(E1 ∪ E2) = P(E1) + P(E2) - P(E1 ∩ E2):\n")
cat("P(E1 ∪ E2) =", P_E1_union_E2, "\n")
cat("P(E1) + P(E2) - P(E1 ∩ E2) =", P_E1, "+", P_E2, "-", P_E1_intersect_E2, "=", P_E1 + P_E2 - P_E1_intersect_E2, "\n")


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
library(dplyr)
library(ggplot2)

rolls <- 10000
die1 <- sample(1:6, rolls, replace = TRUE)
die2 <- sample(1:6, rolls, replace = TRUE)
sum_df <- data.frame(sum=die1 + die2)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
empirical_df <- sum_df %>%
  count(sum) %>%
  mutate(probability = n / rolls)


## ----echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
head(empirical_df, n = 7L)


## ----echo = FALSE-----------------------------------------------------------------------------------------------------------------------------------------------
empirical_plot <- ggplot() +
  geom_bar(data = empirical_df, aes(x = sum, y = probability), 
           stat = "identity", fill = "skyblue", alpha = 0.7) +
  labs(title = "Distribution of Dice Sums (10,000 rolls)",
       x = "Sum",
       y = "Probability") +
  scale_x_continuous(breaks = 2:12) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    panel.grid.minor = element_blank()
  ) +
  guides(fill = FALSE)

print(empirical_plot)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
E1 <- sum_df$sum %% 2 == 0  # Sum is even
E2 <- sum_df$sum > 9        # Sum is greater than 9
E3 <- sum_df$sum %in% c(2, 3, 5, 7, 11) # Sum is prime

E1_intersect_E2 <- E1 & E2
E1_union_E3 <- E1 | E3


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
# Calculate empirical probabilities
P_E1_empirical <- sum(E1) / rolls
P_E2_empirical <- sum(E2) / rolls
P_E3_empirical <- sum(E3) / rolls
P_E1_intersect_E2_empirical <- sum(E1_intersect_E2) / rolls
P_E1_union_E3_empirical <- sum(E1_union_E3) / rolls


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
# probabilities from Problem 1
P_E1_theoretical <- P_E1
P_E2_theoretical <- P_E2
P_E3_theoretical <- P_E3
P_E1_intersect_E2_theoretical <- P_E1_intersect_E2
P_E1_union_E3_theoretical <- P_E1_union_E3


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
results <- data.frame(
  Event = c("P(E1)", "P(E2)", "P(E3)", "P(E1 intersect E2)", "P(E1 union E3)"),
  Empirical = c(P_E1_empirical, P_E2_empirical, P_E3_empirical, 
                P_E1_intersect_E2_empirical, P_E1_union_E3_empirical),
  Theoretical = c(P_E1_theoretical, P_E2_theoretical, P_E3_theoretical, 
                  P_E1_intersect_E2_theoretical, P_E1_union_E3_theoretical),
  Difference = c(P_E1_empirical - P_E1_theoretical, 
                 P_E2_empirical - P_E2_theoretical,
                 P_E3_empirical - P_E3_theoretical,
                 P_E1_intersect_E2_empirical - P_E1_intersect_E2_theoretical,
                 P_E1_union_E3_empirical - P_E1_union_E3_theoretical)
)


## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------------------
print(results)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
theoretical_df <- data.frame(
  sum = 2:12,
  probability = c(1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1) / 36
)


## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------------------
head(theoretical_df, n = 7L)


## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------------------
empirical_plot +
  geom_point(data = theoretical_df, aes(x = sum, y = probability), 
             color = "red", size = 3) +
  geom_line(data = theoretical_df, aes(x = sum, y = probability), 
            color = "red", size = 1, group = 1) +
  annotate("text", x = 3, y = 0.15, 
           label = "Red: Theoretical\nBlue: Empirical", 
           hjust = 0)


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------
comparison_df <- data.frame(
  Event = rep(c("P(E1)", "P(E2)", "P(E3)", "P(E1 intersect E2)", "P(E1 union E3)"), 2),
  Type = c(rep("Empirical", 5), rep("Theoretical", 5)),
  Probability = c(P_E1_empirical, P_E2_empirical, P_E3_empirical, P_E1_intersect_E2_empirical, P_E1_union_E3_empirical,
                 P_E1_theoretical, P_E2_theoretical, P_E3_theoretical, P_E1_intersect_E2_theoretical, P_E1_union_E3_theoretical)
)


## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------------------
head(comparison_df, n = 7L)


## ----echo= FALSE------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(comparison_df, aes(x = Event, y = Probability, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  labs(title = "Comparison of Empirical vs Theoretical Probabilities",
       x = "Event",
       y = "Probability") +
  scale_fill_manual(values = c("Empirical" = "skyblue", "Theoretical" = "coral")) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "top"
  )