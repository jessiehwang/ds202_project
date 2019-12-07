library(dplyr)


data <- read.csv(file="athlete_events.csv", header=TRUE, sep=",")
noc <- read.csv(file="noc_regions.csv", header=TRUE)
 
sum(is.na(data))
sum(is.na(data$Height))
sum(is.na(data$Weight))

sapply(data, class)

#change the missing values of "Medal" to "DNW" (Did Not Win)
data$Medal <- as.character(data$Medal)
data$Medal[is.na(data$Medal)]<- "DNW"
data$Medal <- as.factor(data$Medal)

#change `ID`, `Name`, `Event`, `NOC` to character, `Height` to numeric, sex and game season in levels
data$ID <- as.character(data$ID)
data$Name <- as.character(data$Name)
data$Event <- as.character(data$Event)
data$NOC <- as.character(data$NOC)
noc$NOC <- as.character(noc$NOC)

data$Height <- as.numeric(data$Height)
data$Weight <- as.numeric(data$Weight)
data$Sex<-factor(data$Sex,levels=c("M","F"))
data$Season<-factor(data$Season,levels = c("Summer","Winter"))


#omit rows where either `Height`` or `Weight`` have missing values and save the new data
data<-na.omit(data, cols=c("Height", "Weight"))
sum(is.na(data))

# list the structure of data
str(data)

#Merge two datasets as "olympics", so we can use the NOC code as the primary key
olympics<-inner_join(data, noc, by="NOC")%>%filter(!is.na(region))

#replace `Team` with `Country` and remove the missing values because there are too many duplicates with small differences typos in the original `team` colunm
olympics<-select(olympics, -c("Team"))
colnames(olympics)[colnames(olympics)=="region"] <- "Country"
olympics<-na.omit(olympics, cols=c("Country"))


# list levels of factor Country in data
levels(olympics$Country)

str(olympics)





