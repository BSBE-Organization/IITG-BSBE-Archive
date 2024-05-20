data <- read.csv("C:/Users/adity/OneDrive/Desktop/Lab/BT307/End Sem Biplap/Lab 6/image.csv")

cov.d <- cov(data[ ,2:14])

eigen <- eigen(cov.d)

L <- eigen$values

L.s <- L/sum(L)

plot(L.s, type="b",main="Scree Plot", xlab="Principal Component", ylab="Eigenvalue (Relative Variance)")

v <- eigen$vectors

v <- -v

data.mat <- data.matrix(data[ ,2:14])

P <- data.mat%*%v

colnames(P) <- c('PC1','PC2','PC3','PC4','PC5','PC6','PC7','PC8','PC9','PC10','PC11','PC12','PC13')
rownames(P) <- data[,1]

plot(P[,1:2],main = "PC1 vs PC2", xlab = "PC1", ylab = "PC2")
