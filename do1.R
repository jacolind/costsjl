# example
df %>%
  filter(month(date) == 2, card == "everyday") %>%
  arrange(amount)

##  Count per category

df %>%
  count(cat1) %>%
  arrange(desc(n))


##  Belopp by category, sum and %

SPEND_TOTAL <- sum(df$amount)

df %>%
  group_by(cat1) %>%
  summarise(spend = sum(amount)) %>%
  mutate(spend_pct = round(spend / SPEND_TOTAL, 2)) %>%
  arrange(spend)


##  Total spending by month

# df <- df %>%
#   mutate(year = year(date),
#          month = month(date),
#          day = day(date))

df %>%
  mutate(year = year(date),
         month = month(date),
         day = day(date)) %>%
  group_by(year, month) %>%
  summarise(spend_thousand = sum(amount)/1000) %>%
  arrange(year, month)

# todo idea plot 90 day moving average for the categories instead of grouping by month - that reduces the seasonality

##  Belopp by category, sum, monthly


df %>%
  group_by(cat1) %>%
  summarise(spend = sum(amount)) %>%
  arrange(spend)

# tod i dont know how to make a pivot.

##

df %>%
  group_by(year(date), month(date), cat1) %>%
  summarise(spend = sum(amount)) %>%
  filter(cat1 %in% c("mat", "handla", "boende"))

## plot belopp by category 90d moving average

ma <- function(x,n=5){filter(x,rep(1/n,n), sides=2)}

df %>%
  group_by(year(date), month(date), cat1) %>%
  mutate(amount_avg = cummean(amount)) %>%
  filter(year(date) == 2019) %>%
  select(amount_avg)

## using rollapply()

library(zoo)
df %>%
  group_by(cat1, date) %>% # or jsut group_by(cat1) %>% arrange(date)
  mutate(ma2=rollapply(amount,2,mean,align='right',fill=NA))

## using library(RcppRoll)

library(RcppRoll)
# todo...

##  % by övrigt category

##  delete categories.

# cannot be done with existing data because i exported after removing delete categories.

## yearly

# look at yearly spend per category
# but use 1st of aug because that is more like my life is structured
# escpecially when it comes to vacations.

# crate period: 1 2 3 4 etc. last period is aug 2017 to aug 2018 (not done yet).
