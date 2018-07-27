

library(lubridate)

semester.start <- as.Date("2018/08/27")
semester.end   <- as.Date("2018/12/18")#grades due 18, finals end 15


full.date <- seq.Date(from = semester.start,to = semester.end, by = "day")
date.x    <- day(full.date)
mo.num      <- month(full.date)
mo.name      <- month(full.date,label = TRUE)

day.x     <- wday(full.date,label = T)

fall.2018 <- data.frame(full =full.date,
                        mo = mo.num,
                        mo2 = mo.name,
                        date = date.x,
                        day = day.x)

i.wk.end <- which(day.x %in% c("Sun","Sat"))
fall.2018 <- fall.2018[-i.wk.end,]

fall.2018$class <- ""
i.class <- which(fall.2018$day == "Thu")
fall.2018$class[i.class] <- paste("class",1:length(i.class))



holiday.dates <- c("2018/9/3",
              "2018/10/15",
              "2018/11/21",
              "2018/11/22",
              "2018/11/23")
holiday <- c("Labor day",
             "Fall break",
             rep("Thanks giving",3))

holiday.df <- data.frame(full =as.Date(holiday.dates),
                         event = holiday,
                         stringsAsFactors = F)
                                  


events.df <- data.frame(rbind(c("2018/12/07","Last day of class")
     ,c("2018/12/10","Finals begin")
     ,c("2018/12/18","Grades due at midnight")),
     stringsAsFactors = F)
names(events.df) <- c("full","event")
events.df$full <- as.Date(events.df$full)

holiday.df
events.df

events.all <- rbind(holiday.df,events.df)


fall.2018.temp <- merge(fall.2018,events.all,all = T)

fall.2018.temp$event[is.na(fall.2018.temp$event)] <- ""


write.csv(fall.2018.temp, "_2018_fall_calendar_by_day.csv",row.names = F)
