setwd("~/github/Data_Analysis_Stuff/HW/")
library(forecast)
www<-"cbe.dat"
CBE<-read.table(www, header =T)
CBE[1:4, ]

Chocolate.ts <- ts (CBE[, 1], start = 1958, freq=12)

Beer.ts <- ts (CBE[, 2], start = 1958, freq=12)

Electricity.ts <- ts (CBE[, 3], start = 1958, freq=12)

plot(cbind(Electricity.ts, Beer.ts, Chocolate.ts))

plot(Electricity.ts, xlab="Year", 
     ylab="Electricity (Millions of kWh)",
     main="Monthly production of Electricity")
Electricity.year<-aggregate(Electricity.ts, FUN=sum)

plot(Electricity.year, xlab="Year", 
     ylab="Electricity (Millions of kWh)",
     main="Annual production of Electricity")

boxplot(Electricity.ts~cycle(Electricity.ts), 
        xlab="Month",ylab="Electricity (Millions of kWh)",
        main="Monthly Production of Electricity",
        xaxt="n")
axis(1, 1:12, month.abb[1:12])

#This is part B

#The following is breaking down the time series into 
#it's components

#the first is using a centered average to detect a trend

trend_electricity=  ma(Electricity.ts, order=12, centre=T)
plot(as.ts(Electricity.ts))
lines(trend_electricity)

plot(trend_electricity, xlab="Year",
     ylab="Electricity (Millions of kWh)",
     main="Trend Decomposition of Electricity")

# This next part is detrending the original time series
#in order to explore the seasonality of the data

detrended_electricity=Electricity.ts/trend_electricity
plot(as.ts(detrended_electricity))

## next we average the detrended data to expose the seasonality
monthly_electricity=t(matrix(data= detrended_electricity,nrow= 12))
seasonal_electricty=colMeans(monthly_electricity, na.rm=T)
plot(as.ts(rep(seasonal_electricty,12)))


##next we examine the randomness of the residuals to make
##sure that they are actually random 

random_electricity=Electricity.ts/(trend_electricity*seasonal_electricty)
plot(as.ts(random_electricity))

## Lastly we will reconstruct the original plot in order to verify that
## our process was correct

recomposed_electricity =trend_electricity*seasonal_electricty*random_electricty
plot(as.ts(recomposed_electricity))

