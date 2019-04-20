ACCOUNT
-
id long pk
clientId long FK >- CLIENT.id
accountTypeId long FK >- ACCOUNT_TYPE.id
accountStatusId long FK >- ACCOUNT_STATUS.id
bankMfo integer FK >- BANK.mfo
number long
currency string(3)
iban string(40) #International Bank Account Number
opened date null
closed date null
createdDate date
createdBy string
changedDate date
changedBy string

ACCOUNT_STATUS #immutable; prohibited
-
id long pk
name string unique
description string null
createdDate date
createdBy string
changedDate date
changedBy string

ACCOUNT_FINANCE
-
accountId long pk FK >- ACCOUNT.id
loanBlocked boolean
reasonLoanBLocked string null
loanEnabled boolean #user's setting this
loanLimit long
overdraftEnabled boolean
overdraftLimit long
cashLimitDaily long
cashLimitDailyUsed long
cashLimitMonthly long
cashLimitMonthlyUsed long
debitBalance long
creditBalance long
blockedSum long
createdDate date
createdBy string
changedDate date
changedBy string


ACCOUNT_TYPE #premium/gold etc
-
id long pk
name string(50) unique
description string
maxBalance long
maxLoanLimit long
maxOverdraftLimit long
maxCashLimitDaily long
maxCashLimitMonthly long
createdDate date
createdBy string
changedDate date
changedBy string

OPERATION #immutable
-
id long pk
operationTypeId long FK >- OPERATION_TYPE.id
subjectAccountId long FK >- ACCOUNT.id
objectAccountId long FK >- ACCOUNT.id null
objectFullName string null
objectTaxId long null
objectPassport string(8) null
currency string(3) null
operationAmount long null #сумма в валюте операции
commission long null
subjectBalanceChange long null
objectBalanceChange long null
system string null #откуда сделана?
description string null
executed date
createdDate date
createdBy string
changedDate date
changedBy string

OPERATION_TYPE #immutable; prohibited
-
id long pk
name string(100) unique
description string null
monetary boolean
monetaryLimit long null
createdDate date
createdBy string
changedDate date
changedBy string

COMMISSION
-
operationTypeId long PK FK >- OPERATION_TYPE.id
commissionMinAbsolute long null
commissionPercentage double null
createdDate date
createdBy string
changedDate date
changedBy string

CLIENT
-
id long pk
fullName string
taxId long unique
passport string(8) unique
createdDate date
createdBy string
changedDate date
changedBy string

CURRENCY_VALUES
-
currency string(3) PK
bankSellRatio integer
bankBuyRatio integer
createdDate date
createdBy string
changedDate date
changedBy string

BANK
-
id long PK
name string(100) unique
description string null
legalName string unique
mfo integer unique
edrpou integer unique
createdDate date
createdBy string
changedDate date
changedBy string
