  CREATE view [dbo].[vCurrencyNew] as 
  
  SELECT [code], ROW_NUMBER() OVER (ORDER BY CASE WHEN [code] = 'EUR' THEN [code] END desc,
  CASE WHEN [code] = 'DKK' THEN [code] END desc,
  CASE WHEN [code] in (SELECT DISTINCT BankAccounts_Currency AS Currency FROM LINK.tblBankAccounts) THEN [code] END desc) AS RowNum
  FROM [ObtonData].[dbo].[IbanCurrency]
  GROUP BY [code]
