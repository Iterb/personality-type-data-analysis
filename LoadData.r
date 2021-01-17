#library(qdap)

data = read.csv("mbti_1.csv")

INTJ <- data[data$type=="INTJ",]
INTP <- data[data$type=="INTP",]
ENTJ <- data[data$type=="ENTJ",]
ENTP <- data[data$type=="ENTP",]
INFJ <- data[data$type=="INFJ",]
INFP <- data[data$type=="INFP",]
ENFJ <- data[data$type=="ENFJ",]
ENFP <- data[data$type=="ENFP",]
ISTJ <- data[data$type=="ISTJ",]
ISFJ <- data[data$type=="ISFJ",]
ESTJ <- data[data$type=="ESTJ",]
ESFJ <- data[data$type=="ESFJ",]
ISTP <- data[data$type=="ISTP",]
ISFP <- data[data$type=="ISFP",]
ESTP <- data[data$type=="ESTP",]
ESFP <- data[data$type=="ESFP",]
length(INTJ[,1])
length(INTP[,1])
#summary(data)
#data[1,]
#data[,1]

#replaces URLs with word "link"
data$posts <- gsub('http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|(?:%[0-9a-fA-F][0-9a-fA-F]))+', 'link', data$posts)

#removes all noise from text
data$posts <- gsub('[^a-zA-Z]', " ", data$posts)
head(data,3)