# Import the data using read.csv()
AJdata = read.csv("CardioGoodFitness.csv", stringsAsFactors = F)

# Create a scatter plot between Age and Income.
plot(AJdata$Age, AJdata$Income)

# Modify the plot with labels and so on
plot(AJdata$Age, AJdata$Income,
     main = "Age Vs Income", xlab = "Age in years", ylab = "Income in dollars",
     pch = 16, col = "purple", cex = 1.5, cex.axis = 1.0, cex.lab = 1.0)

# Since there are multiple values of income for each age, let us take average
income_avg <- aggregate(Income ~ Age, AJdata, mean)

# Now, plot the Age vs Income
plot(income_avg$Age, income_avg$Income,
     main = "Age Vs Income", xlab = "Age in years", ylab = "Income in dollars",
     pch = 20, col = "black", cex = 1, cex.axis = 1.0, cex.lab = 1.0)

# We can also adjust the axes scales
plot(income_avg$Age, income_avg$Income,
     main = "Ags Vs Income", xlab = "Age in years", ylab = "Income in dollars",
     pch = 20, col = "red", cex = 1, cex.axis = 1.0, cex.lab = 1.0,
     xlim = c(15, 50), ylim = c(25000, 90000))

# Let us plot the same data as line graph
plot(income_avg$Age, income_avg$Income,
     main = "Ags Vs Income", xlab = "Age in years", ylab = "Income in dollars",
     pch = 20, col = "red", cex = 1, cex.axis = 1.0, cex.lab = 1.0,
     xlim = c(15, 50), ylim = c(25000, 90000), type = "b", lwd = 2)

#######################################################################

# Now, let us try to plot the bar graph.
product <- read.csv("Product_Avg.csv", stringsAsFactors = F)

# First let us make a bar plot for product TM195
product.tm195 <- product[1, 2:7]
product.tm195 <- data.matrix(product.tm195)
barplot(product.tm195,
        ylim = c(0, 60000), ylab = "Average values")

# Due to the large difference between the income and other variables, it is not clear. So, let us remove income for the time-being.
product.tm195 <- product[1, 2:6]
product.tm195 <- data.matrix(product.tm195)
barplot(product.tm195,
        ylim = c(0, 120), ylab = "Average values")

# Now let us include all the three product types
product.all <- data.matrix(product[ , 2:6])
barplot(product.all,
        beside = TRUE, ylim = c(0, 200), ylab = "Average values",
        legend.text = c("TM195", "TM498", "TM798"),
        args.legend = list(bty = "x", x = "top"))

# Let us add some more arguments
mycol <- c("red", "orange", "yellow")
barplot(product.all,
        beside = TRUE, ylim = c(0, 200), ylab = "Average values",
        legend.text = c("TM195", "TM498", "TM798"),
        args.legend = list(bty = "n", x = "topleft"),
        col = mycol, cex.axis = 1.25, cex.name = 1.25, cex.lab = 1.25)

#######################################################################

# Now let us try histogram plot
hist(AJdata$Income)

# Now we can do some formatting and plot
hist(AJdata$Income,
     xlim = c(20000, 120000), ylim = c(0,75), xlab = "Income in dollar",
     ylab = "Frequency", main = "Frequency distribution of Income", las = 0)

# By default, the no. of bins is calculated using Sturges's method. This time, let us use another rule called Freedman-Diaconis rule.
hist(AJdata$Income,
     xlim = c(20000, 120000), ylim = c(0,50), xlab = "Income in dollar", ylab = "Frequency",
     main = "Frequency distribution of Income - Freeman-Diaconis method", las = 0,
     breaks = "FD")

# We can use Scott method as well.
hist(AJdata$Income,
     xlim = c(20000, 120000), ylim = c(0,60), xlab = "Income in dollar", ylab = "Frequency",
     main = "Frequency distribution of Income - Scott Method", las = 1, breaks = "Scott")

# In a frequency distribution, we can mark mean and median
abline(v = mean(AJdata$Income), lwd = 2, col = "red")
abline(v = median(AJdata$Income), lwd = 2, col = "blue")

# Now, let us change the y-axis (frequency or count) to density.
hist(AJdata$Income,
     xlim = c(20000, 120000), xlab = "Income in dollar", ylab = "Density",
     main = "Frequency distribution of Income - Freeman-Diaconis method",
     las = 0, breaks = "FD", freq = FALSE)

# Now, let us change (frequency or count) to percentage value in y-axis.
percentage <- hist(AJdata$Income, plot = FALSE)

# convert density to percentage
percentage$density <- percentage$counts*100/sum(percentage$counts)

# Now plot the histogram with percentage
plot(percentage,
     xlim = c(20000, 120000), ylim = c(0, 60), xlab = "Income in dollar",
     ylab = "Income (%)",
     main = "Frequency distribution of Income - Freeman-Diaconis method",
     las = 1, col = "navyblue")

######################################################################

# Now let us try to plot the box plot
bp <- AJdata
boxplot(Income ~ Product, bp)

# We can do some formatting in the box plot
boxplot(Income ~ Product, bp,
        xlab = "Product type", ylab = "Income", cex.lab = 2.0, cex.axis = 2.0,
        ylim = c(20000, 110000), varwidth = FALSE, col = "cyan")

# Side-by-side box plot
age <- AJdata$Age
education <- AJdata$Education
rmiles <- AJdata$Miles
miles <- rmiles/5
age_education_miles = cbind(education, miles, age)
boxplot(age_education_miles, beside=T, col = "pink")

# We can format little bit
boxplot(age_education_miles, beside=T,
        ylim = c(0, 80), varwidth = TRUE, outpch = 10, outcol = "purple")

######################################################################

# Now let us try to plot heat map
hm <- data.matrix(AJdata)
heatmap(hm[ , 2:7], Rowv = NA, Colv = NA)

# Generate the dendogram
heatmap(hm[ , 2:7])

# We can scale the data
heatmap(hm[ , 2:7], scale = "column")

# We can remove the horizontal dendogram
heatmap(hm[ , 2:7], Rowv = NA, scale = "column")
