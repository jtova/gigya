library(data.table)

users = fread(input = "./data/accounts20160602.csv")

str(users)
summary(users)

colnames(users)

set.seed(100)
sample(users$lastLogin, 10)
head(users$lastLogin)
?strptime()

head(strptime(users$lastLogin, format="%Y-%m-%dT%H:%M:%S"))


# Por problemas al usar strptime que deja 11 campos sin rellenar
users[,lastLogin.date := as.POSIXct(lastLogin, format="%Y-%m-%dT%H:%M:%S")]


head(users$lastLogin.date)
boxplot(users$lastLogin.date)

summary(users$lastLogin.date)
hist(users$lastLogin.date, breaks = "days")

# Fecha de creación
users[,created.date := as.POSIXct(created, format="%Y-%m-%dT%H:%M:%S")]

sample(users$created, 20)

hist(users$created.date, breaks = c("years", "months"))

summary(users$created.date)
?hist.POSIXt

# diferencia entr creados y last login, que al menos han accedido una vez en otro día distinto al login
users[difftime(lastLogin.date, created.date, units = "days") > 0, .N]


