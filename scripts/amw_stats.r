list.of.packages <- c("jsonlite", "dplyr", "ggplot2", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos = "http://cran.us.r-project.org")
library("jsonlite")
library("dplyr")
library("ggplot2")
library("lubridate")
currentDate <- lubridate::today()
since <- currentDate - months(1)
actions <- jsonlite::fromJSON('../exported/actions.json')
actions$`_id` <- actions$`_id`$`$oid`
actions$user <- actions$user$`$oid`
actions[,"type"] <- factor(actions[,"type"])

confessions <- jsonlite::fromJSON('../exported/confessions.json')
confessions$`_id` <- confessions$`_id`$`$oid`
confessions$user <- confessions$user$`$oid`

replies <- jsonlite::fromJSON( './exported/replies.json' )
replies$`_id` <- replies$`_id`$`$oid`
replies$`parentID` <- replies$`parentID`$`$oid`

users <- jsonlite::fromJSON( './exported/users.json' )
users$`_id`<-users$`_id`$`$oid`

actionsWithUsers <- merge(actions, users, by.x="user", by.y = "_id")

lastMonth <- actionsWithUsers %>% filter(time > since)
usersActiveInLastMonth <- distinct(lastMonth['username'])

actionsInLastMonthPerUser <- lastMonth %>% group_by(username) %>% summarise(total = length(user))

#plot 1 actionsInLastMonthPerUser
ggplot2::ggplot(data=actionsInLastMonthPerUser, ggplot2::aes(x=username, y=total)) + ggplot2::geom_bar(stat = 'identity') + ggplot2::labs(x="Moderator", y="Wykonane akcje", title="Ilość wykonanych akcji w ciągu ostatniego tygodnia")
ggplot2::ggsave("results/actionsInLastWeek.png")

confessionsPerHour <- confessions %>% group_by(createdAt=lubridate::hour(createdAt)) %>% count(name = "confessionsPerHour", createdAt)
repliesPerHour <- replies %>% group_by(createdAt=lubridate::hour(createdAt)) %>% count(name = "repliesPerHour", createdAt)

ggplot2::ggplot(data=confessionsPerHour, ggplot2::aes(x=createdAt, y=confessionsPerHour)) + ggplot2::geom_bar(stat = 'identity') + ggplot2::labs(x="Godzina", y="Dodane wyznania", title="Ilość dodanych wyznań o danej godzinie")
ggplot2::ggsave("results/activityPerHour.png")

confessions$weekday <- weekdays(confessions$createdAt)
# confessions$weekday <- factor(confessions$weekday)

replies$weekday <- weekdays(replies$createdAt)
# replies$weekday <- factor(replies$weekday)

confessionsPerDay = confessions %>% group_by(weekday = weekday) %>% count(name = "amount_per_day", weekday)
repliesPerDay = replies %>% group_by(weekday = weekday) %>% count(name = "amount_per_day", weekday)

ggplot2::ggplot(data=confessionsPerDay, ggplot2::aes(x=weekday, y=amount_per_day)) + ggplot2::geom_bar(stat = 'identity') + ggplot2::labs(x="Dzien tygodnia", y="Dodane wyznania", title="Ilość dodanych wyznań w danym dniu tygodnia")
ggplot2::ggsave("results/activityPerDay.png")

numberOfConfessions <- nrow(confessions)
declinedConfessions <- sum(confessions$status==-1)
acceptedConfessions <- sum(confessions$status==1)

numberOfReplies <- nrow(replies)
declinedReplies <- sum(replies$status==-1)
acceptedReplies <- sum(replies$status==1)


totalCreated <- numberOfConfessions + numberOfReplies
totalDeclined <-  declinedConfessions + declinedReplies
totalAccepted <- acceptedConfessions + acceptedReplies

acceptedRatio <- (totalAccepted/totalCreated)*100


print(totalCreated)
print(totalDeclined)
print(acceptedRatio)


confessions$tags2<- lapply(confessions$tags, `[`, ,1)
tags <- as.data.frame(table(unlist(confessions$tags2)))
sortedTags <- tags[
  with(tags, order(Freq, decreasing = TRUE)),
]
ggplot(sortedTags[2:10,], aes(x = reorder(Var1, Freq), y = Freq, fill=Var1)) + geom_bar(stat = "identity") + coord_flip() + labs(x="Tag", y="Liczba uzyc tagu")
ggplot2::ggsave("results/tags.png")

resultText <- sprintf("#anonimowemirkowyznaniastatystyki\nStatystyki z ostatniego tygodnia:\nDodane wyznania i komentarze: %s\nOdrzucone: %s\nprocent dodanych: %.2f\n", totalCreated, totalDeclined, acceptedRatio)
message(resultText)

resultTextFile <- file("results/resultText.txt")
writeLines(resultText, resultTextFile)
close(resultTextFile)
