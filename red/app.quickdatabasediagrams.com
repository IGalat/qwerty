# to all tables: add created/by, changed/by

account
-
id long pk
clientId long FK >- client.id
typeId long FK >- accountType.id
statusId long FK >- acountStatus.id
mfo long
number long
currency string(3)
okpo long
iban string #International Bank Account Number
opened date null
closed date null

acountStatus #immutable; prohibited
-
id long pk
name string unique
description string  null

accountFinance
-
accountId long pk FK >- account.id
loanBlocked boolean
loanEnabled boolean #user's setting this
loanLimit long
overdrafgftEnabled boolean
overdraftLimit long
cashLimitDaily long
cashLimitDailyUsed long
cashLimitMonthly long
cashLimitMonthlyUsed long
balance long
blockedSum long


accountType #premium/gold etc
-
id long pk
name string unique
description string
maxBalance long
maxLoanLimit long
maxOverdraftLimit long
maxCashLimitDaily long
maxCashLimitMonthly long
#todo commissions

operations #immutable
-
id long pk
typeId long FK >- operationType.id
subjectAccountId long FK >- account.id
objectAccountId long FK >- account.id null
currency string(3) null
operationAmount long null #сумма в валюте операции
subjectBalanceChange long null
objectBalanceChange long null
commission long null
description string null
created date
executed date

operationType #immutable; prohibited
-
id long pk
name string unique
description string null

client
-
id long pk
fullName string
taxId long unique
passport string unique

#todo currencies values
