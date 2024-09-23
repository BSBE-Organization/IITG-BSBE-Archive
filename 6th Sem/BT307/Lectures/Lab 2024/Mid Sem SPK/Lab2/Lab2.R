# Import the data using read.csv()
AJData = read.csv("CardioGoodFitness.csv", stringsAsFactors = F)

# Print the header of the data
print(head(AJData))

# Print the tail part of the data
print(tail(AJData))

#For next plot (i.e. histogram), a library “ggplot2” would be required. Import it.
library(ggplot2)

# Plot all the variables as histogram, for example
ggplot(AJData, aes(x=Age)) +
  geom_histogram(binwidth = 2, fill = "green", color = "blue", alpha = 0.8 )+
  labs(title = "Age Distribution", x="Age", y="Frequency")

ggplot(AJData, aes(x=Education)) +
  geom_histogram(binwidth = 2, fill = "green", color = "blue", alpha = 0.8 )+
  labs(title = "Education Distribution", x="Education", y="Frequency")

ggplot(AJData, aes(x=Fitness)) +
  geom_histogram(binwidth = 2, fill = "green", color = "blue", alpha = 0.8 )+
  labs(title = "Fitness Distribution", x="Fitness", y="Frequency")

# Now, first let us calculate the number of bins and bin size, e.g. for Age.
no_of_bins = 1 + 3.322*(log10(180))
bin_size_age = (50-18)/no_of_bins
bin_size_education = (21-12)/no_of_bins
bin_size_fitness = (5-1)/no_of_bins
cat("Number of bins: ",no_of_bins)
cat("Bin size age: ",bin_size_age)
cat("Bin size education: ",bin_size_education)
cat("Bin size fitness: ",bin_size_fitness)

# Re-plot the histogram with new number of bins and size
ggplot(AJData, aes(x=Age)) +
  geom_histogram(binwidth = bin_size_age, fill = "green", color = "blue", alpha = 1.0 )+
  labs(title = "Age Distribution", x="Age", y="Frequency")

ggplot(AJData, aes(x=Education)) +
  geom_histogram(binwidth = bin_size_education, fill = "green", color = "blue", alpha = 1.0 )+
  labs(title = "Education Distribution", x="Education", y="Frequency")

ggplot(AJData, aes(x=Fitness)) +
  geom_histogram(binwidth = bin_size_fitness, fill = "green", color = "blue", alpha = 0.8 )+
  labs(title = "Fitness Distribution", x="Fitness", y="Frequency")

# Calculate the mean value for all the numerical variables. For example,
mean_age = mean(AJData$Age)
mean_education = mean(AJData$Education)
mean_fitness = mean(AJData$Fitness)

# Print the mean values for all the numerical variables. For example,
print(paste("Mean of age:", mean_age))
print(paste("Mean of education:", mean_education))
print(paste("Mean of fitness:", mean_fitness))

# Calculate the median value for all the numerical variables. For example,
median_age = median(AJData$Age)
median_education = median(AJData$Education)
median_fitness = median(AJData$Fitness)

# Print the median values for all the numerical variables. For example,
print(paste("Median of age:", median_age))
print(paste("Median of education:", median_education))
print(paste("Median of fitness:", median_fitness))

# Calculate the mode value for all the numerical variables. For example,
library(modeest)
library(statip)
mode_age = mfv(AJData$Age)
mode_education = mfv(AJData$Education)
mode_fitness = mfv(AJData$Fitness)

# Print the mode values for all the numerical variables. For example,
print(paste("Mode of age:", mode_age))
print(paste("Mode of education:", mode_education))
print(paste("Mode of fitness:", mode_fitness))

# Calculate and print the range value for all the numerical variables.
max_age = max(AJData$Age)
min_age = min(AJData$Age)
range_age1 = max_age - min_age
cat("Range of age: ", range_age1, "\n")
range_age2 = range(AJData$Age)
cat("Range interval of age is: ", range_age2)

max_education = max(AJData$Education)
min_education = min(AJData$Education)
range_education1 = max_education - min_education
cat("Range of Education: ", range_education1, "\n")
range_education2 = range(AJData$Education)
cat("Range interval of education is: ", range_education2)

max_fitness = max(AJData$Fitness)
min_fitness = min(AJData$Fitness)
range_fitness1 = max_fitness - min_fitness
cat("Range of fitness: ", range_fitness1, "\n")
range_fitness2 = range(AJData$Fitness)
cat("Range interval of fitness is: ", range_fitness2)

# Calculate and print the variance and standard deviation for all the variables
var_age = var(AJData$Age)
std_age = sd(AJData$Age)
cat("The variance and standard deviation of age are: ", var_age, "and", std_age, "\n")

var_education = var(AJData$Education)
std_education = sd(AJData$Education)
cat("The variance and standard deviation of education are: ", var_education, "and", std_education, "\n")

var_fitness = var(AJData$Fitness)
std_fitness = sd(AJData$Fitness)
cat("The variance and standard deviation of fitness are: ", var_fitness, "and", std_fitness, "\n")

# Calculate and print the quartiles values for all the variables
quartiles_age = quantile(AJData$Age)
print(quartiles_age)

quartiles_education = quantile(AJData$Education)
print(quartiles_education)

quartiles_fitness = quantile(AJData$Fitness)
print(quartiles_fitness)

# Calculate and print the interquartile range value for all the variables.
iqr_age = IQR(AJData$Age)
cat("The interquartile range of age is: ", iqr_age, "\n")

iqr_education = IQR(AJData$Education)
cat("The interquartile range of education is: ", iqr_education, "\n")

iqr_fitness = IQR(AJData$Fitness)
cat("The interquartile range of fitness is: ", iqr_fitness, "\n")

# All these individual parameters can be calculated once also
summary_age = summary(AJData$Age)
print(summary_age)

summary_education = summary(AJData$Education)
print(summary_education)

summary_fitness = summary(AJData$Fitness)
print(summary_fitness)

# Similary, summary of all the data can be calculated once also
summary_all = summary(AJData)
print(summary_all)
