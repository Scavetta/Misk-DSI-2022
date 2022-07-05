# We flipped a coin <n> times and observedd <obs> heads.
# What is the probability of this event?
# Should I get excited? i.e. is it unusual?

# The total number of coint toses
n <- 12

# We will test later based on the null hypothesis that the coin is fair, i.e.
p <- 0.5
# Hypothesis testing:
# Step 1 - Assume the null hypothesis (p = 0.5) is true

# The number of observed successes (from 0 - n)
obs <- 6

# the probabilities of observing eactly 0 up to 12 successes
# change n to increase the number of observations (individuals, coint tosses, etc.)
# change obs to match the event you obserced
# change p if you have a good reason to not assume that the coin was fair. 
prob_theo <- dbinom(0:n, size = n, prob = p)
prob_theo

# A basic plot, i.e. the theorteical probability distribution  
barplot(prob_theo )
# Hypothesis testing:
# Step 2 - Derive the Null Distribution and the test statistice (here, simpley
# the number of observed successes in object obs)

# Hypothesis testing:
# Step 3 - Place the test statistic (i.e. the observed value) on the Nulle distrbution
#        - Add up all the point probabilities for your obserced value and anything more extreme
# To make our lives easier we'll add up all the point probabilities beginning from zero up 
# until the observed value if it is less than 1/2 of n (i.e. on the left side of the plot)
# or if the observed value is greater than 1/2 of n ( i.e. on the right side of the plot
# then we convert to the equidistant left side equivalent.
obs_test <- ifelse(obs < n/2, obs, n - obs)

# This will be 0 for the more extreme case, thus
# find the sum of the point probabilities for the let side and then multiply by two
sum(prob_theo[1:(obs_test+1)]) * 2
# We can also use the cumulative probability density function
pbinom(0:n, size = n, prob = p)[obs_test+1] * 2


# Extra material:
# The point probability for the the maximum number of successes
# (i.e. get the last value with length(prob_theo)
prob_theo[length(prob_theo)]

# We can double this to account for the equidistant extreme value on the other side
# or calculate the point probability for 0 successes 
prob_theo[1]

# the 1 in x chance, use:
1/(prob_theo[1]*2)
# which is equivalen to saying the 1 in 2^obs chance of seeing exactly the maximum number of successes
2^obs

