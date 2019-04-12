# to all tables: add created/by, changed/by

ACCOUNT
-
id long pk
clientId long FK >- CLIENT.id
accountTypeId long FK >- ACCOUNT_TYPE.id
accountStatusId long FK >- ACCOUNT_STATUS.id
mfo long
number long
currency string(3)
okpo long
iban string #International Bank Account Number
opened date null
closed date null
created date
changed date

ACCOUNT_STATUS #immutable; prohibited
-
id long pk
name string unique
description string  null
created date
changed date

ACCOUNT_FINANCE
-
accountId long pk FK >- ACCOUNT.id
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


ACCOUNT_TYPE #premium/gold etc
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

OPERATIONS #immutable
-
id long pk
typeId long FK >- OPERATION_TYPE.id
subjectClientId long FK >- CLIENT.id
subjectAccountId long FK >- ACCOUNT.id null
objectAccountId long FK >- ACCOUNT.id null
objectFullName string
objectTaxId long
objectPassport string
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

OPERATION_TYPE #immutable; prohibited
-
id long pk
name string unique
monetary boolean
description string null
created date
changed date

COMMISSIONS
-
opTypeId long pk FK >- OPERATION_TYPE.id
commissionAbsolute long
commissionPercentage double
created date
changed date

CLIENT
-
id long pk
fullName string
taxId long unique
passport string unique
created date
changed date

CURRENCY_VALUES
-
currency string(3)
bankSellRatio double
bankBuyRatio double
created date
changed date

CURRENCY_VALUES_HISTORY #immutable
-
currency string(3)
bankSellRatio double
bankBuyRatio double
startDate date
created date
changed date
