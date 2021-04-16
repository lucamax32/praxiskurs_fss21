# Mit setwd setzt ihr in R euer "working directory"
setwd("~/Documents/Praxiskurs_FSS21/")

# Daten werden eingelesen mit der Funktion read.csv bzw read.csv2
df_covid <- read.csv("data/RKI_COVID19.csv")

?read.csv2

library(readr)
help(read_csv)

# Die Funktion str gibt grundlegende Informationen über R-Objekte aus
str(df_covid)

# Mehr Informationen zu data frames stehen in der Dokumentation
help(data.frame)

# Auch ganz interessant: die head Funktion
head(df_covid)

# Um alle Spaltennamen zu kriegen, existiert colnames 
colnames(df_covid)

df_covid$IdBundesland

df_covid[1]

df_covid["Bundesland"]

df_covid[[1]]

# Auch hier: help Funktion 
help("[[")

bundeslaender  <- unique(df_covid$Bundesland)
print(bundeslaender)

bundeslaender <- as.character(bundeslaender)
# Bundeslaender mit Bindestrich trennen:
strsplit(bundeslaender,"-")

# Großer Unterschied: Einfache Klammer liefert wieder eine Liste wenn sie auf data frames angwerdet wird 
print(str(df_covid["Bundesland"]))
print(str(df_covid$Bundesland))

head(df_covid[df_covid$Bundesland=="Baden-Württemberg",])

plot(df_covid$AnzahlFall)

smoothScatter(df_covid$AnzahlFall)

hist(df_covid$AnzahlFall)

hist(df_covid$AnzahlFall,breaks=200,xlim=c(-10,10),freq=FALSE, main="Histogramm von Fallübermittlungen")

summary(df_covid$AnzahlFall)

hist(df_covid$AnzahlFall[df_covid$AnzahlFall<0])

# Nun schauen wir uns die Fallzahlen pro Tag für Deutschland an
dates <- unique(df_covid$Meldedatum)
cases_per_day <- double(length(dates))
for(day in 1:length(dates)){
    cases_per_day[day]  <- sum(df_covid$AnzahlFall[df_covid$Meldedatum == dates[day]])
}
head(data.frame(dates=dates, cases=cases_per_day))

# Eine elegantere und etwas schnellere Methode liefert sapply
help(sapply)

# Damit bekommen wir das gleiche Ergebnis, nur kompakter geschrieben
cases_per_day  <- sapply(dates, function(date) sum(df_covid$AnzahlFall[df_covid$Meldedatum == date])  )
str(cases_per_day)

# Wir speichern die Daten im richten Format und erstellen einen data frame dafür
dates <- as.POSIXct(dates, format="%Y/%m/%d")
df_cases_per_day <- data.frame(dates=dates,cases=cases_per_day)
head(df_cases_per_day)

range(df_cases_per_day$dates)

# Order und sort liefern Sortiermethoden
help(order)

head(sort(df_cases_per_day$dates))

head(order(df_cases_per_day$dates))

(df_cases_per_day <- df_cases_per_day[order(df_cases_per_day$dates),])

plot(df_cases_per_day$dates,df_cases_per_day$cases)

plot(df_cases_per_day$dates,df_cases_per_day$cases, 
     type="l", xlab="Day", ylab="Date", main="Timeseries of cases per day")

# Mit dem POSIX Format lassen sich auch einfach Informationen aus Datumsangaben extrahieren, 
# beispielsweise den Wochentag
df_cases_per_day$wday  <- weekdays(df_cases_per_day$dates)
head(df_cases_per_day$wday)

# Damit können wir uns auch die Gesamtanzahl an Fällen pro Wochentag anschauen
wdays <- c("Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag","Sonntag")
cases_per_wday <-  sapply(wdays, function(wday) sum(df_cases_per_day$cases[df_cases_per_day$wday ==wday] ))
print(cases_per_wday)

# Diese Statistik können wir dann auch plotten
plot(cases_per_wday)


# ... und wieder verschönern
plot(cases_per_wday, type="b", xaxt="n", ylim =c(0,max(cases_per_wday)))
axis(1,at = 1:7,labels = wdays,cex.axis=0.8)

ticks  <- seq(df_cases_per_day$dates[1],df_cases_per_day$dates[length(dates)], by="month")
ticks
