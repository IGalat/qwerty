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
created date
changed date

acountStatus #immutable; prohibited
-
id long pk
name string unique
description string  null
created date
changed date

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
debitBalance long
creditBalance long
blockedSum long
created date
changed date


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
created date
changed date
#todo commissions

operations #immutable
-
id long pk
typeId long FK >- operationType.id
subjectClientId long FK >- client.id
subjectAccountId long FK >- account.id null
objectAccountId long FK >- account.id null
currency string(3) null
operationAmount long null #сумма в валюте операции
commission long null
subjectBalanceChange long null
objectBalanceChange long null
system string null #откуда сделана?
description string null
createdOp date
executed date
created date
changed date

commissions
-
opTypeId long pk FK >- operationType.id
commissionAbsolute long
commissionPercentage double
created date
changed date


operationType #immutable; prohibited
-
id long pk
name string unique
monetary boolean
description string null
created date
changed date

client
-
id long pk
fullName string
taxId long unique
passport string unique
created date
changed date

currencyValues
-
bankBuying string(3)
bankSelling string(3)
valueRatio double
reverse boolean
created date
changed date

currencyValuesHistory #immutable
-
bankBuying string(3)
bankSelling string(3)
valueRatio double
reverse boolean
startDate date
created date
changed date
