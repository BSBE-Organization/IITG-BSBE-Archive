data <- read.csv("C:/Users/adity/OneDrive/Desktop/Lab/BT307/End Sem Biplap/Lab 1/data1.csv")

plot(data, xlab="Age", ylab="Systolic Blood Pressure", pch=21, cex=1.5)

cor(data$age, data$systolic.pressure, method="pearson")

cor.test(data$age, data$systolic.pressure, method="pearson")
