lambda<-0.2
nosim <- 1000 # number of simulations
n <- 40 #number of draws
estimated_means <- apply(matrix(rexp(nosim * n, lambda), nosim), 1, mean) #means from  1000 simulations of 40 exp.distributions

#saving plot
g<-hist(estimated_
        means, main = "Histogram of the samples' means")
ozone.ylim.normal = range(0, g$density, dnorm(estimated_means, mean = mean(estimated_means), sd = sd(estimated_means)), na.rm = T)
hist(estimated_means, breaks = 15, freq = F,   main = 'Histogram of Ozone Pollution Data with Normal Density Curve')
curve(dnorm(x, mean = mean(estimated_means), sd = sd(estimated_means)), add = T)
abline(v=1/lambda,col="red", lwd =2)
png('hist_means.png')
dev.off()


#variability of the sample
estimated_var <- apply(matrix(rexp(nosim * n, lambda), nosim), 1, var)
mean(estimated_var)

hist(estimated_var, main = "Histogram of the samples' variances")
abline(v=(1/lambda)^2,col="red", lwd =2)
dev.copy(png,'hist_var.png')
dev.off()


library(ggplot2)

######Part2 ######
#loading data
data(ToothGrowth)
str(ToothGrowth)
#summary
summary(ToothGrowth)

#histogram and boxplots of tooth length
hist(ToothGrowth$len)
dev.copy(png,'hist_length.png')
dev.off()
ToothGrowth$dose <-as.factor(ToothGrowth$dose)
plot(ToothGrowth$dose, ToothGrowth$len, main = 'Scatterplot of tooth length vs dose')
png('plot_lenghtVSdose.png')
dev.off()
plot(ToothGrowth$supp, ToothGrowth$len, main = 'Scatterplot of tooth length per supplement type')
png('plot_legthVSsupplement')
dev.off()

#sumarizing per group
ToothGrowth %>% arrange(supp, dose) %>%
  group_by(supp, dose) %>%
  summarise_each(funs(mean, sd))

#testing supplements differences
t.test(len ~ supp, data = ToothGrowth, paired=FALSE,var.equal=TRUE)
t.test(len ~ supp, data = ToothGrowth, paired=FALSE,var.equal=FALSE)



#testing dose differences
#creating data for dose types
d05 <- ToothGrowth[which(ToothGrowth$dose==.5),1]
d1 <- ToothGrowth[which(ToothGrowth$dose==1),1]
d2 <- ToothGrowth[which(ToothGrowth$dose==2),1]


t1.05_1 <- t.test(d05, d1, paired=FALSE, var.equal=FALSE)
t2.05_2 <- t.test(d05, d2, paired=FALSE, var.equal=FALSE)
t3.1_2 <- t.test(d1, d2, paired=FALSE, var.equal=FALSE)

#putting testing results in one table
result <- data.frame("p-value"=c(t1.05_1$p.value, t2.05_2$p.value, t3.1_2$p.value),"Conf-Low"=c(t1.05_1$conf[1], t2.05_2$conf[1], t3.1_2$conf[1]),"Conf-High"=c(t1.05_1$conf[2], t2.05_2$conf[2], t3.1_2$conf[2]), row.names=c("0.5_1","0.5_2", "1_2"), "dose"="[0.5..1]")
result


