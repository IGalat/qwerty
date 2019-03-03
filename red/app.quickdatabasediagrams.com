# to all tables: add created/by, changed/by

account
-
id long pk
clientId long #todo client table
typeId long FK >- accountType.id
state string #enum
mfo long
currency string(3)
okpo string
opened date null
closed date null


accountFinance
-
accountId long pk FK >- account.id
creditEnabled boolean
creditLimit long
overdraftEnabled boolean
overdraftLimit long
cashLimitDaily long
cashLimitDailyUsed long
cashLimitMonthly long
cashLimitMonthlyUsed long
debitBalance long
creditBalance long


accountType #premium/gold etc
-
id long pk
name string unique
maxBalance long
maxCreditLimit long
maxOverdraftLimit long
maxCashLimitDaily long
maxCashLimitMonthly long
#todo commissions


#todo tables account operations; types
