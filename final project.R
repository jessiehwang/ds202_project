library(dplyr)


data <- read.csv(file="athlete_events.csv", header=TRUE, sep=",")
noc <- read.csv(file="noc_regions.csv", header=TRUE)
 
sum(is.na(data))
sum(is.na(data$Height))
sum(is.na(data$Weight))

sapply(data, class)

#change the na of "Medal" to "DNW" (Did Not Win)
data$Medal <- as.character(data$Medal)
data$Medal[is.na(data$Medal)]<- "DNW"
data$Medal <- as.factor(data$Medal)

#omit rows where either "Height" or "Weight" have missing values and save the new data
data<-na.omit(data, cols=c("Height", "Weight"))
sum(is.na(data))

# list the structure of data
str(data)

#Merge two datasets as "olympics", so we can use the NOC code as the primary key
olympics<-inner_join(data, noc, by="NOC")

#drop duplicates NOC master data

#replace "Team" with "Country" and remove the missing values
olympics<-select(olympics, -c("Team"))
colnames(olympics)[colnames(olympics)=="region"] <- "Country"
olympics<-na.omit(olympics, cols=c("Country"))

# list levels of factor Country in data
levels(olympics$Country)


