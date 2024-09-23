data <- read.csv("C:/Users/adity/OneDrive/Desktop/Lab/BT307/End Sem Biplap/Lab 2/data1.csv")

y <- data$g1
x <- data$g2
plot(x, y, xlab="g2", ylab="g1", col="blue", main="Expression of g1 and g2")

cor(x, y , method="pearson")

reg1 <- lm(y ~ x, data = data)
summary(reg1)
abline(reg1, col="red")

reg2 <- lm(y ~ x+0, data = data)
summary(reg2)
abline(reg2, col="red")
