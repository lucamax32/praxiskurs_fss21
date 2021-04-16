data<-read.csv('RKI_COVID19.csv')



lk<-unique(data$Landkreis)
lk_groß<-(data$Landkreis)
MA_count <- sum(data$AnzahlFall[data$Landkreis=='SK Mannheim'])



datum<- data$Meldedatum
data$Meldedatum<-as.Date(data$Meldedatum, format = "%Y/%m/%d")
data$Geschlecht<-as.factor(data$Geschlecht)
frauen<- sum(data$AnzahlFall[data$Meldedatum =='2021-04-15' & data$Geschlecht == 'W'])

april<-sum(data$AnzahlFall[data$Meldedatum>='2021-04-01'])


