data = read.csv('applications.csv')

## data cleaning
library(lubridate)
colnames(data)[1] = "record"
data$date = mdy(data$date)
data$dob = mdy(data$dob)
year(data$dob) = ifelse(year(data$dob) > 2000, year(data$dob) - 100, year(data$dob))

app = data

## creating variables
library(sqldf)

# ssn
ssn = sqldf("
SELECT a.record,

COUNT(CASE WHEN a.date = b.date THEN a.record ELSE NULL END) -1 AS same_ssn_1,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN a.record ELSE NULL END) -1 AS same_ssn_3,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN a.record ELSE NULL END) -1 AS same_ssn_7,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN a.record ELSE NULL END) -1 AS same_ssn_14,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN a.record ELSE NULL END) -1 AS same_ssn_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.address ELSE NULL END) -1 AS same_ssn_diff_address_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.address ELSE NULL END) -1 AS same_ssn_diff_address_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.address ELSE NULL END) -1 AS same_ssn_diff_address_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.address ELSE NULL END) -1 AS same_ssn_diff_address_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.address ELSE NULL END) -1 AS same_ssn_diff_address_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.homephone ELSE NULL END) -1 AS same_ssn_diff_phone_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.homephone ELSE NULL END) -1 AS same_ssn_diff_phone_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.homephone ELSE NULL END) -1 AS same_ssn_diff_phone_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.homephone ELSE NULL END) -1 AS same_ssn_diff_phone_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.homephone ELSE NULL END) -1 AS same_ssn_diff_phone_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_ssn_diff_bdname_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_ssn_diff_bdname_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_ssn_diff_bdname_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_ssn_diff_bdname_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_ssn_diff_bdname_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_ssn_diff_zipname_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_ssn_diff_zipname_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_ssn_diff_zipname_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_ssn_diff_zipname_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_ssn_diff_zipname_30

FROM app a, app b

WHERE a.date - b.date BETWEEN 0 AND 29 

AND a.record - b.record BETWEEN 0 AND 94865

AND a.ssn = b.ssn

GROUP BY 1
")

# address
address = sqldf("
SELECT a.record,

COUNT(CASE WHEN a.date = b.date THEN a.record ELSE NULL END) -1 AS same_address_1,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN a.record ELSE NULL END) -1 AS same_address_3,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN a.record ELSE NULL END) -1 AS same_address_7,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN a.record ELSE NULL END) -1 AS same_address_14,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN a.record ELSE NULL END) -1 AS same_address_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.ssn ELSE NULL END) -1 AS same_address_diff_ssn_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.ssn ELSE NULL END) -1 AS same_address_diff_ssn_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.ssn ELSE NULL END) -1 AS same_address_diff_ssn_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.ssn ELSE NULL END) -1 AS same_address_diff_ssn_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.ssn ELSE NULL END) -1 AS same_address_diff_ssn_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.homephone ELSE NULL END) -1 AS same_address_diff_phone_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.homephone ELSE NULL END) -1 AS same_address_diff_phone_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.homephone ELSE NULL END) -1 AS same_address_diff_phone_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.homephone ELSE NULL END) -1 AS same_address_diff_phone_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.homephone ELSE NULL END) -1 AS same_address_diff_phone_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_address_diff_bdname_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_address_diff_bdname_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_address_diff_bdname_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_address_diff_bdname_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_address_diff_bdname_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_address_diff_zipname_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_address_diff_zipname_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_address_diff_zipname_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_address_diff_zipname_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_address_diff_zipname_30

FROM app a, app b

WHERE a.date - b.date BETWEEN 0 AND 29 

AND a.record - b.record BETWEEN 0 AND 94865

AND a.address = b.address

GROUP BY 1
")


# phone
phone = sqldf("
SELECT a.record,

COUNT(CASE WHEN a.date = b.date THEN a.record ELSE NULL END) -1 AS same_phone_1,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN a.record ELSE NULL END) -1 AS same_phone_3,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN a.record ELSE NULL END) -1 AS same_phone_7,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN a.record ELSE NULL END) -1 AS same_phone_14,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN a.record ELSE NULL END) -1 AS same_phone_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.address ELSE NULL END) -1 AS same_phone_diff_address_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.address ELSE NULL END) -1 AS same_phone_diff_address_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.address ELSE NULL END) -1 AS same_phone_diff_address_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.address ELSE NULL END) -1 AS same_phone_diff_address_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.address ELSE NULL END) -1 AS same_phone_diff_address_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.ssn ELSE NULL END) -1 AS same_phone_diff_ssn_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.ssn ELSE NULL END) -1 AS same_phone_diff_ssn_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.ssn ELSE NULL END) -1 AS same_phone_diff_ssn_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.ssn ELSE NULL END) -1 AS same_phone_diff_ssn_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.ssn ELSE NULL END) -1 AS same_phone_diff_ssn_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_phone_diff_bdname_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_phone_diff_bdname_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_phone_diff_bdname_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_phone_diff_bdname_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_phone_diff_bdname_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_phone_diff_zipname_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_phone_diff_zipname_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_phone_diff_zipname_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_phone_diff_zipname_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_phone_diff_zipname_30

FROM app a, app b

WHERE a.date - b.date BETWEEN 0 AND 29 

AND a.record - b.record BETWEEN 0 AND 94865

AND a.homephone = b.homephone

GROUP BY 1
")


# birthday&name
bdname = sqldf("
SELECT a.record,

COUNT(CASE WHEN a.date = b.date THEN a.record ELSE NULL END) -1 AS same_bdname_1,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN a.record ELSE NULL END) -1 AS same_bdname_3,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN a.record ELSE NULL END) -1 AS same_bdname_7,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN a.record ELSE NULL END) -1 AS same_bdname_14,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN a.record ELSE NULL END) -1 AS same_bdname_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.address ELSE NULL END) -1 AS same_bdname_diff_address_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.address ELSE NULL END) -1 AS same_bdname_diff_address_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.address ELSE NULL END) -1 AS same_bdname_diff_address_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.address ELSE NULL END) -1 AS same_bdname_diff_address_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.address ELSE NULL END) -1 AS same_bdname_diff_address_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.homephone ELSE NULL END) -1 AS same_bdname_diff_phone_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.homephone ELSE NULL END) -1 AS same_bdname_diff_phone_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.homephone ELSE NULL END) -1 AS same_bdname_diff_phone_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.homephone ELSE NULL END) -1 AS same_bdname_diff_phone_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.homephone ELSE NULL END) -1 AS same_bdname_diff_phone_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.ssn ELSE NULL END) -1 AS same_bdname_diff_ssn_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.ssn ELSE NULL END) -1 AS same_bdname_diff_ssn_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.ssn ELSE NULL END) -1 AS same_bdname_diff_ssn_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.ssn ELSE NULL END) -1 AS same_bdname_diff_ssn_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.ssn ELSE NULL END) -1 AS same_bdname_diff_ssn_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_bdname_diff_zipname_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_bdname_diff_zipname_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_bdname_diff_zipname_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_bdname_diff_zipname_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.firstname || b.zip5 || b.lastname ELSE NULL END) -1 AS same_bdname_diff_zipname_30

FROM app a, app b

WHERE a.date - b.date BETWEEN 0 AND 29 

AND a.record - b.record BETWEEN 0 AND 94865

AND a.firstname = b.firstname AND a.dob = b.dob AND a.lastname = b.lastname

GROUP BY 1
")


#zipcode&name
zipname = sqldf("
SELECT a.record,

COUNT(CASE WHEN a.date = b.date THEN a.record ELSE NULL END) -1 AS same_zipname_1,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN a.record ELSE NULL END) -1 AS same_zipname_3,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN a.record ELSE NULL END) -1 AS same_zipname_7,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN a.record ELSE NULL END) -1 AS same_zipname_14,

COUNT(CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN a.record ELSE NULL END) -1 AS same_zipname_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.address ELSE NULL END) -1 AS same_zipname_diff_address_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.address ELSE NULL END) -1 AS same_zipname_diff_address_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.address ELSE NULL END) -1 AS same_zipname_diff_address_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.address ELSE NULL END) -1 AS same_zipname_diff_address_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.address ELSE NULL END) -1 AS same_zipname_diff_address_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.homephone ELSE NULL END) -1 AS same_zipname_diff_phone_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.homephone ELSE NULL END) -1 AS same_zipname_diff_phone_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.homephone ELSE NULL END) -1 AS same_zipname_diff_phone_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.homephone ELSE NULL END) -1 AS same_zipname_diff_phone_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.homephone ELSE NULL END) -1 AS same_zipname_diff_phone_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.ssn ELSE NULL END) -1 AS same_zipname_diff_ssn_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.ssn ELSE NULL END) -1 AS same_zipname_diff_ssn_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.ssn ELSE NULL END) -1 AS same_zipname_diff_ssn_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.ssn ELSE NULL END) -1 AS same_zipname_diff_ssn_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.ssn ELSE NULL END) -1 AS same_zipname_diff_ssn_30,

COUNT(DISTINCT CASE WHEN a.date = b.date THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_zipname_diff_bdname_1, 

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 2 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_zipname_diff_bdname_3,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 6 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_zipname_diff_bdname_7,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 13 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_zipname_diff_bdname_14,

COUNT(DISTINCT CASE WHEN a.date - b.date BETWEEN 0 AND 29 THEN b.firstname || b.dob || b.lastname ELSE NULL END) -1 AS same_zipname_diff_bdname_30

FROM app a, app b

WHERE a.date - b.date BETWEEN 0 AND 29 

AND a.record - b.record BETWEEN 0 AND 94865

AND a.firstname = b.firstname AND a.zip5 = b.zip5 AND a.lastname = b.lastname

GROUP BY 1
")


# join all the variables into one table
all = sqldf("

SELECT * FROM app INNER JOIN ssn AS s JOIN address AS a JOIN phone AS p JOIN bdname AS b JOIN zipname AS z

ON app.record = s.record AND app.record = a.record AND app.record = p.record AND app.record = b.record AND app.record = z.record
")

all = all[c(-11,-37,-63,-89,-115)]


## replacing frivolous field value with 0
library(dplyr)
newall = all %>%
  mutate(same_ssn_1 = ifelse(ssn == 737610282, 0, same_ssn_1)) %>%
  mutate(same_ssn_3 = ifelse(ssn == 737610282, 0, same_ssn_3)) %>%
  mutate(same_ssn_7 = ifelse(ssn == 737610282, 0, same_ssn_7)) %>%
  mutate(same_ssn_14 = ifelse(ssn == 737610282, 0, same_ssn_14)) %>%
  mutate(same_ssn_30 = ifelse(ssn == 737610282, 0, same_ssn_30)) %>%
  mutate(same_ssn_diff_address_1 = ifelse(ssn == 737610282, 0, same_ssn_diff_address_1)) %>%
  mutate(same_ssn_diff_address_3 = ifelse(ssn == 737610282, 0, same_ssn_diff_address_3)) %>%
  mutate(same_ssn_diff_address_7 = ifelse(ssn == 737610282, 0, same_ssn_diff_address_7)) %>%
  mutate(same_ssn_diff_address_14 = ifelse(ssn == 737610282, 0, same_ssn_diff_address_14)) %>%
  mutate(same_ssn_diff_address_30 = ifelse(ssn == 737610282, 0, same_ssn_diff_address_30)) %>%
  mutate(same_ssn_diff_phone_1 = ifelse(ssn == 737610282, 0, same_ssn_diff_phone_1)) %>%
  mutate(same_ssn_diff_phone_3 = ifelse(ssn == 737610282, 0, same_ssn_diff_phone_3)) %>%
  mutate(same_ssn_diff_phone_7 = ifelse(ssn == 737610282, 0, same_ssn_diff_phone_7)) %>%
  mutate(same_ssn_diff_phone_14 = ifelse(ssn == 737610282, 0, same_ssn_diff_phone_14)) %>%
  mutate(same_ssn_diff_phone_30 = ifelse(ssn == 737610282, 0, same_ssn_diff_phone_30)) %>%
  mutate(same_ssn_diff_bdname_1 = ifelse(ssn == 737610282, 0, same_ssn_diff_bdname_1)) %>%
  mutate(same_ssn_diff_bdname_3 = ifelse(ssn == 737610282, 0, same_ssn_diff_bdname_3)) %>%
  mutate(same_ssn_diff_bdname_7 = ifelse(ssn == 737610282, 0, same_ssn_diff_bdname_7)) %>%
  mutate(same_ssn_diff_bdname_14 = ifelse(ssn == 737610282, 0, same_ssn_diff_bdname_14)) %>%
  mutate(same_ssn_diff_bdname_30 = ifelse(ssn == 737610282, 0, same_ssn_diff_bdname_30)) %>%
  mutate(same_ssn_diff_zipname_1 = ifelse(ssn == 737610282, 0, same_ssn_diff_zipname_1)) %>%
  mutate(same_ssn_diff_zipname_3 = ifelse(ssn == 737610282, 0, same_ssn_diff_zipname_3)) %>%
  mutate(same_ssn_diff_zipname_7 = ifelse(ssn == 737610282, 0, same_ssn_diff_zipname_7)) %>%
  mutate(same_ssn_diff_zipname_14 = ifelse(ssn == 737610282, 0, same_ssn_diff_zipname_14)) %>%
  mutate(same_ssn_diff_zipname_30 = ifelse(ssn == 737610282, 0, same_ssn_diff_zipname_30)) %>%
  mutate(same_phone_1 = ifelse(homephone == 9105580920, 0, same_phone_1)) %>%
  mutate(same_phone_3 = ifelse(homephone == 9105580920, 0, same_phone_3)) %>%
  mutate(same_phone_7 = ifelse(homephone == 9105580920, 0, same_phone_7)) %>%
  mutate(same_phone_14 = ifelse(homephone == 9105580920, 0, same_phone_14)) %>%
  mutate(same_phone_30 = ifelse(homephone == 9105580920, 0, same_phone_30)) %>%
  mutate(same_phone_diff_address_1 = ifelse(homephone == 9105580920, 0, same_phone_diff_address_1)) %>%
  mutate(same_phone_diff_address_3 = ifelse(homephone == 9105580920, 0, same_phone_diff_address_3)) %>%
  mutate(same_phone_diff_address_7 = ifelse(homephone == 9105580920, 0, same_phone_diff_address_7)) %>%
  mutate(same_phone_diff_address_14 = ifelse(homephone == 9105580920, 0, same_phone_diff_address_14)) %>%
  mutate(same_phone_diff_address_30 = ifelse(homephone == 9105580920, 0, same_phone_diff_address_30)) %>%
  mutate(same_phone_diff_ssn_1 = ifelse(homephone == 9105580920, 0, same_phone_diff_ssn_1)) %>%
  mutate(same_phone_diff_ssn_3 = ifelse(homephone == 9105580920, 0, same_phone_diff_ssn_3)) %>%
  mutate(same_phone_diff_ssn_7 = ifelse(homephone == 9105580920, 0, same_phone_diff_ssn_7)) %>%
  mutate(same_phone_diff_ssn_14 = ifelse(homephone == 9105580920, 0, same_phone_diff_ssn_14)) %>%
  mutate(same_phone_diff_ssn_30 = ifelse(homephone == 9105580920, 0, same_phone_diff_ssn_30)) %>%
  mutate(same_phone_diff_bdname_1 = ifelse(homephone == 9105580920, 0, same_phone_diff_bdname_1)) %>%
  mutate(same_phone_diff_bdname_3 = ifelse(homephone == 9105580920, 0, same_phone_diff_bdname_3)) %>%
  mutate(same_phone_diff_bdname_7 = ifelse(homephone == 9105580920, 0, same_phone_diff_bdname_7)) %>%
  mutate(same_phone_diff_bdname_14 = ifelse(homephone == 9105580920, 0, same_phone_diff_bdname_14)) %>%
  mutate(same_phone_diff_bdname_30 = ifelse(homephone == 9105580920, 0, same_phone_diff_bdname_30)) %>%
  mutate(same_phone_diff_zipname_1 = ifelse(homephone == 9105580920, 0, same_phone_diff_zipname_1)) %>%
  mutate(same_phone_diff_zipname_3 = ifelse(homephone == 9105580920, 0, same_phone_diff_zipname_3)) %>%
  mutate(same_phone_diff_zipname_7 = ifelse(homephone == 9105580920, 0, same_phone_diff_zipname_7)) %>%
  mutate(same_phone_diff_zipname_14 = ifelse(homephone == 9105580920, 0, same_phone_diff_zipname_14)) %>%
  mutate(same_phone_diff_zipname_30 = ifelse(homephone == 9105580920, 0, same_phone_diff_zipname_30))


## final variable table
variables = newall[c(1:2, 11:135, 10)]
write.csv(variables, "variables.csv")
