############# Confidence interval for the mean ###########################
x <- rnorm(50, mean = 10, sd = 2)
t.test(x, conf.level = 0.95)$conf.int

############# Confidence interval for the proportion ######################
x <- c(15, 25)
n <- c(50, 50)
binom.test(x, n, conf.level = 0.95)$conf.int

############# One-sample t-test ########################################
data <- c(12, 10, 15, 14, 18, 20, 11, 9, 17, 13)
t.test(data, mu = 15)

############# Two-sample t-test #######################################
group1 <- c(12, 10, 15, 14, 18, 20, 11, 9, 17, 13)
group2 <- c(18, 17, 19, 20, 22, 21, 25, 28, 29, 24)
t.test(group1, group2)

############# Paired t-test ############################################
pre_treatment <- c(12, 10, 15, 14, 18, 20, 11, 9, 17, 13)
post_treatment <- c(14, 12, 17, 16, 20, 22, 13, 11, 19, 10)
t.test(pre_treatment, post_treatment, paired = TRUE)

############# Chi-squared test #########################################
data <- matrix(c(10, 20, 30, 40), nrow = 2, ncol = 2, byrow = TRUE)
chisq.test(data)
  
############# One-way ANOVA ########################################
install.packages("dplyr")
library(dplyr)
group1 <- c(5, 8, 6, 7, 5)
group2 <- c(3, 2, 4, 6, 4)
group3 <- c(9, 7, 8, 10, 11)
data <- data.frame(scores = c(group1, group2, group3), group = factor(rep(
                     c("Group1", "Group2", "Group3"), times = c(length(group1),
                      length(group2), length(group3)))))
anova_result <- aov(scores ~ group, data = data)
summary(anova_result)

############# Type I error #############################################
alpha <- 0.05
sample_size <- 30
num_simulations <- 10000
set.seed(123)
false_positives <- 0
for (i in 1:num_simulations) {
  sample1 <- rnorm(sample_size, mean = 0, sd = 1)
  sample2 <- rnorm(sample_size, mean = 0, sd = 1)
  
  test_result <- t.test(sample1, sample2)
  
  if (test_result$p.value < alpha) {
    false_positives <- false_positives + 1
  }
}
type1_error_rate <- false_positives / num_simulations
cat("Type I Error Rate:", type1_error_rate)