data <- read.csv("C:/Users/adity/OneDrive/Desktop/Lab/BT307/End Sem Biplap/Lab 5/facs.csv")

set.seed(1)

k2 <- kmeans(data, 2, iter.max=1000, nstart=50)
k3 <- kmeans(data, 3, iter.max=1000, nstart=50)
k4 <- kmeans(data, 4, iter.max=1000, nstart=50)
k5 <- kmeans(data, 5, iter.max=1000, nstart=50)
k6 <- kmeans(data, 6, iter.max=1000, nstart=50)

w2 <- k2$tot.withinss
w3 <- k3$tot.withinss
w4 <- k4$tot.withinss
w5 <- k5$tot.withinss
w6 <- k6$tot.withinss

wcss <- c(w2,w3,w4,w5,w6)

barplot(wcss, names=seq(2,6), xlab="k", ylab="within cluster ss")

col2 <- data$FL2.H
col3 <- data$FL3.H
col4 <- data$FL4.H

plot(col2, col3, col=k3$cluster, ylab="FL2.H", xlab="FL3.H", main="FL2.H vs FL3.H", pch=20, cex=1)
plot(col3, col4, col=k3$cluster, ylab="FL3.H", xlab="FL4.H", main="FL3.H vs FL4.H", pch=20, cex=1)
