
# Function usage ----

# The p*(x) equations, where * is a defined theoretical probability distribution,
# (e.g. pnorm(), pt(), pf(), etc.) take numeric argument x as the position on the x axis,
# and return how much AUC is covered from -Inf to that value.
# e.g. A Normal distribution, where position x == mean is by definition, 0.5.
mu <- 0 
sigma <- 1
pnorm(0, mean = mu, sd = sigma) # 50% of the AUC
pnorm(mu + 1.96*sigma, mean = mu, sd = sigma) # 97.5% of the AUC (see book diagrams)


# Measure how extreme/unusual/atypical/unexpected a value is
mystery <- 215

# Method 1: TBD with confidence intervals ----

# Method 2: Many Curves, One Value ----
# Is an observed value "extreme"?
# In which case is it more "extreme" 


## Site I ----
u_1 <- 200
s_1 <- 6

# 95% AUC:
u_1 + 1.96*s_1
u_1 - 1.96*s_1

# The probability of observing the mystery martian or something more extreme at site I is:
1 - pnorm(215, mean = u_1, sd = s_1)
# 0.006209665

## Site II ----
u_2 <- 210
s_2 <- 1

# 95% AUC:
u_2 + 1.96*s_2
u_2 - 1.96*s_2

# The probability of observing the mystery martian or something more extreme at site II is:
1 - pnorm(215, mean = 210, sd = 1)
# 2.866516e-07

# Instead of doing the above, use Z-scores: Signal-to-noise

# Method 3: One Curve, Many Values ----
# aka Z-Scores 

## Site I ----
(z_1 <- (mystery - u_1)/s_1)

## Site II ----
(z_2 <- (mystery - u_2)/s_2)



