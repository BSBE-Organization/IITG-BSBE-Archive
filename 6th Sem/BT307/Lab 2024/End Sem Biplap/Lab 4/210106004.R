train <- read.csv("C:/Users/adity/OneDrive/Desktop/Lab/BT307/End Sem Biplap/Lab 4/spider_train.csv")

logit <- glm( spider ~ size, data = train, family= "binomial" )

summary(logit)

test <- read.csv("C:/Users/adity/OneDrive/Desktop/Lab/BT307/End Sem Biplap/Lab 4/spider_test.csv")

p.test <- predict( logit, test, type= "response" )

# for cutoff = 0.3
c1.test <- ifelse( p.test > 0.3, 1, 0 )
tab1.test <- table( predicted = c1.test, Actual = test$spider )
print( tab1.test )

sn1.test <- tab1.test[2,2] / sum(tab1.test[,2])
sp1.test <- tab1.test[1,1] / sum(tab1.test[,1])

# for cutoff = 0.5
c2.test <- ifelse( p.test > 0.5, 1, 0 )
tab2.test <- table( predicted = c2.test, Actual = test$spider )
print( tab2.test )

sn2.test <- tab2.test[2,2] / sum(tab2.test[,2])
sp2.test <- tab2.test[1,1] / sum(tab2.test[,1])

# cutoff = 0.7
c3.test <- ifelse( p.test > 0.7, 1, 0 )
tab3.test <- table( predicted =c3.test, Actual= test$spider )
print( tab3.test )

sn3.test <- tab3.test[2,2] / sum(tab3.test[,2])
sp3.test <- tab3.test[1,1] / sum(tab3.test[,1])

x = c(0.3, 0.5, 0.7)
y = c(sn1.test, sn2.test, sn3.test)
barplot(y, x, xlab = "Cutoff", ylab = "Sensitivity", ylim = c(0,1), names.arg = c("0.3","0.5","0.7"), main = "Sensitivity vs Cutoff")
axis(1,c(1,2,3))
