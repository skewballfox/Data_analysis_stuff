
carconomics<-cbind(c(.33,2000,40,3,2),
                   c(18000,.8,40,80,200),
                   c(.5,1500,20,2,1),
                   c(20000,1.6,60,120,360))

colnames(carconomics)<-c("quantity '00 (qi0)", 
                         " unit price '00(pi0)",
                         " quantity '04(qit)", 
                         "unit price '04 (pit)")

rownames(carconomics)<-c("car","petrol (litre)",
                         "servicing(h)", "tyre",
                         "clutch")

numerator=0
denominator=0


for (row in 1:nrow(carconomics))
  numerator=numerator+(carconomics[row,1]*carconomics[row,4])
  denominator=denominator+(carconomics[row,1]*carconomics[row,2])

  laspeyre_price_index=numerator/denominator
  
  