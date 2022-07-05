# Examples for 95% CI & hypothesis testing

library(tidyverse)

# data
martian_tb <- read_tsv("data/martians.txt")

summary(martian_tb)

martian_summary <- martian_tb %>%
  group_by(Site) %>%
  summarise(avg = mean(Height),
            stdev = sd(Height),
            n = n()) %>% 
  filter(Site == "Site I")


# Using the N distribution ----
correction <- 1.96

# 95% CI - 
# lower limit: avg - 1.96 * (stdev/sqrt(n))
# upper limit: avg + 1.96 * (stdev/sqrt(n))

SEM_1 <-  (martian_summary$stdev/sqrt(martian_summary$n))
martian_summary$avg - correction * SEM_1
martian_summary$avg + correction * SEM_1
# [196.28, 203.72]

# H_0: u_0 = 195cm - Scenario 1 (.s1)
H_0.s1 <- 195
# Q: Is this H_0.s1 plausable?
# A: No, We reject the H_0 because it's outside our 95% CI

# H_0: u_0 = 196cm - Scenario 2
H_0.s2 <- 196
# Q: Is this H_0.s2 plausable?
# A: No, We reject the H_0 because it's outside our 95% CI

# Classical hypothesis testing with the signal:noise ratio
# signal:noise = (obs - hypo)/scale = (avg - u_0)/SEM
(martian_summary$avg - H_0.s1)/SEM_1
# 2.64

# So....
# Q: Is this H_0.s1 = 195 plausable?
# A: No, We reject the H_0 because it's outside the range [-1.96, 1.96]

# for the scenario 2
(martian_summary$avg - H_0.s2)/SEM_1
# 2.1 (lower because we have a smaller signal)

# Q: Is this H_0.s2 = 196 plausable?
# A: No, We reject the H_0 because it's outside the range [-1.96, 1.96]

# Using the t distribution ----
# To get 95% from the center I have to count from the -Inf
# Thus I look for 97.5%
correction <- qt(0.975, df = martian_summary$n - 1)
# 2.26 not 1.96

# 95% CI - 
# lower limit: avg - 2.26 * (stdev/sqrt(n))
# upper limit: avg + 2.26 * (stdev/sqrt(n))

SEM_1 <-  (martian_summary$stdev/sqrt(martian_summary$n))
martian_summary$avg - correction * SEM_1
martian_summary$avg + correction * SEM_1
# now [195.71, 204.29]
# not ... [196.28, 203.72]

# H_0: u_0 = 195cm - Scenario 1 (.s1)
H_0.s1 <- 195
# Q: Is this H_0.s1 plausable?
# A: No, We reject the H_0 because it's outside our 95% CI

# H_0: u_0 = 196cm - Scenario 2
H_0.s2 <- 196
# Q: Is this H_0.s2 plausable?
# A: Yes! We fail to reject the H_0 because it's inside our 95% CI

# Classical hypothesis testing with the signal:noise ratio
# This doesn't change when we now consider using the t-distribution
# signal:noise = (obs - hypo)/scale = (avg - u_0)/SEM
(martian_summary$avg - H_0.s1)/SEM_1
# 2.64

# So....
# Q: Is this H_0.s1 = 195 plausable?
# A: No, We reject the H_0 because it's outside the range [-2.26, 2.26]

# for the scenario 2
(martian_summary$avg - H_0.s2)/SEM_1
# 2.1 (lower because we have a smaller signal)

# Q: Is this H_0.s2 = 196 plausable?
# A: Yes! We fail to reject the H_0 because it's inside the range [-2.26, 2.26]

# Calculate the p-value
martian_heights_I <- martian_tb$Height[martian_tb$Site == "Site I"]

# test for H_0.s1 of 195cm 
t.test(x = martian_heights_I, mu = H_0.s1)
# p-value = 0.027


# test for H_0.s2 of 196cm 
t.test(x = martian_heights_I, mu = H_0.s2)
# p-value = 0.06 - Fail to reject


# 2sample t-test for heights
t.test(Height ~ Site, data = martian_tb)

# 95% CI: centered on -10 +/- corr*sd(y-bar_i - y_bar_ii )
# [-15.63, -4.37]

