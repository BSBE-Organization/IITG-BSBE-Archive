data <- read.csv("C:/Users/adity/OneDrive/Desktop/Lab/BT307/End Sem Biplap/Lab 3/data2.csv")

reg <- lm( S ~ . , data = data)

summary(reg)

reg2 <- lm(S ~ M + P + R, data = data)

summary(reg2)
