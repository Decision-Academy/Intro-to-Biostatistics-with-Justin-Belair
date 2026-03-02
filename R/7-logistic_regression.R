# =============================================================================
# Introduction to Biostatistics - Modelling: Logistic Regression
# Section 6-8
# Author: Justin Belair | Statistical Consultant
# =============================================================================

# --- Load required packages --------------------------------------------------
library(ggplot2)
library(dplyr)
library(stringr)

set.seed(1)

# -----------------------------------------------------------------------------
# LOGISTIC REGRESSION
# -----------------------------------------------------------------------------
# We study the prostate cancer dataset from the Vanderbilt Biostatistics Library.
#
# Reference: Byar DP, Green SB (1980). Bulletin Cancer, Paris 67:477-488
# More info: https://hbiostat.org/data/repo/prostate
# Data dictionary: https://hbiostat.org/data/repo/cprostate
#
# The 'status' variable is cleaned to create a binary 'death' indicator
# (1 = dead, 0 = alive).
# -----------------------------------------------------------------------------

# --- Load and prepare data ---------------------------------------------------
data.prostate <- read.csv("https://raw.githubusercontent.com/Decision-Academy/Intro-to-Biostatistics-with-Justin-Belair/refs/heads/main/data/prostate.csv") %>%
  mutate(death = str_trim(str_extract(status, "^[^-]*")),
         death = ifelse(death == "dead", 1, 0))

# --- Fit a logistic regression model -----------------------------------------
# Model death as a function of age, weight (wt), cancer stage, and treatment (rx).
# We use the binomial family with a logit link function.

glm.logistic <- glm(death ~ age + wt + stage + rx,
                     data = data.prostate, family = binomial(link = "logit"))

# --- Model summary -----------------------------------------------------------
summary(glm.logistic)

# -----------------------------------------------------------------------------
# INTERPRETING COEFFICIENTS
# -----------------------------------------------------------------------------
# The coefficients represent the change in log-odds of the outcome for a
# one-unit change in the predictor, holding all other predictors constant.
#
# Exponentiating the coefficients gives the odds ratios, which are easier
# to interpret.
# -----------------------------------------------------------------------------

# Odds ratios (excluding the intercept)
exp(coef(glm.logistic)[-1]) %>%
  round(3)

# -----------------------------------------------------------------------------
# ANALYSIS OF DEVIANCE
# -----------------------------------------------------------------------------
# Since this is not a linear model, a standard ANOVA is not appropriate.
# Instead, we use the car package to perform an analysis of deviance, which
# is an analogous procedure for generalized linear models.
# -----------------------------------------------------------------------------

car::Anova(glm.logistic)

# The main effect of medication (rx) is very high and statistically significant.
# Note: Be careful with causal interpretations of this model.
