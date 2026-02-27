## ---------------------------------------------------------------------------------------------------------------------------
options(max.print = 100)
knitr::opts_chunk$set(warning = FALSE, message = FALSE)

set.seed(1)


## -------------------------------------------------------------------------------------------------------------------------------------
library(dplyr)
library(ggplot2)
dat <- read.csv("~/simulated_data.csv")


## -------------------------------------------------------------------------------------------------------------------------
 dat %>%
   ggplot(aes(x = time.to.death)) +
   geom_histogram(binwidth = 1, fill = "blue", color = "black") +
   labs(title = "Histogram of Time to Death",
        x = "Time to Death (days)",
        y = "Count") +
   theme_minimal()


## -------------------------------------------------------------------------------------------------------------------------
dat %>% 
  ggplot(aes(x = time.to.death)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(title = "Histogram of Time to Death",
       x = "Time to Death (days)",
       y = "Count") +
  theme_minimal()


## -------------------------------------------------------------------------------------------------------------------------
 dat %>%
   group_by(age.binned, knew.celebrity.y.n) %>%
   summarise(count = n()) %>%
   mutate(proportion = count / sum(count)) %>%
   ggplot(aes(x = age.binned, y = proportion, fill = knew.celebrity.y.n)) +
   geom_bar(stat = "identity", position = "dodge") +
   labs(title = "Proportion of Individuals Who Knew the Celebrity by Age Group",
        x = "Age Group",
        y = "Proportion") +
   theme_minimal()


## -------------------------------------------------------------------------------------------------------------------------
dat %>% 
  group_by(age.binned, knew.celebrity.y.n) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count)) %>%
  ggplot(aes(x = age.binned, y = proportion, fill = knew.celebrity.y.n)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Proportion of Individuals Who Knew the Celebrity by Age Group",
       x = "Age Group",
       y = "Proportion") +
  theme_minimal()


## -------------------------------------------------------------------------------------------------------------------------------------
dat %>% 
  group_by(sex) %>%
  summarise(mean.time.to.death = mean(time.to.death),
            n())


## -------------------------------------------------------------------------------------------------------------------------------------
dat %>% 
  group_by(age.binned) %>%
  summarise(mean.time.to.death = mean(time.to.death),
            n())


## -------------------------------------------------------------------------------------------------------------------------------------
dat %>% 
  group_by(knew.celebrity.y.n) %>%
  summarise(mean.time.to.death = mean(time.to.death),
            n())


## -------------------------------------------------------------------------------------------------------------------------
 dat %>%
   group_by(sex, knew.celebrity.y.n) %>%
   summarise(mean.time.to.death = mean(time.to.death),
             n())


## -------------------------------------------------------------------------------------------------------------------------
dat %>% 
  group_by(sex, knew.celebrity.y.n) %>%
  summarise(mean.time.to.death = mean(time.to.death),
            n())


## -------------------------------------------------------------------------------------------------------------------------
 dat %>%
   group_by(age.binned, knew.celebrity.y.n) %>%
   summarise(mean.time.to.death = mean(time.to.death),
             n())


## -------------------------------------------------------------------------------------------------------------------------
dat %>% 
  group_by(age.binned, knew.celebrity.y.n) %>%
  summarise(mean.time.to.death = mean(time.to.death),
            n())


## -------------------------------------------------------------------------------------------------------------------------
 dat %>%
   group_by(sex, age.binned) %>%
   summarise(mean.time.to.death = mean(time.to.death),
             n())


## -------------------------------------------------------------------------------------------------------------------------
dat %>% 
  group_by(sex, age.binned) %>%
  summarise(mean.time.to.death = mean(time.to.death),
            n())


## -------------------------------------------------------------------------------------------------------------------------
 dat %>%
   group_by(sex, age.binned,  knew.celebrity.y.n) %>%
   summarise(mean.time.to.death = mean(time.to.death),
             n())


## ---------------------------------------------------------------------------------------------------------------------------
dat %>% 
  group_by(sex, age.binned,  knew.celebrity.y.n) %>%
  summarise(mean.time.to.death = mean(time.to.death),
            n())

