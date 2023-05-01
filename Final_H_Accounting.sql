USE H_Accounting;

DROP PROCEDURE if EXISTS LL_BS_Statement;

DELIMITER $$

CREATE PROCEDURE LL_BS_Statement(varCalendarYear SMALLINT)
BEGIN


#---------------------------------BALANCE SHEET------------------------------#

DECLARE varCurrentAssets FLOAT;
DECLARE varCurrentAssets_py FLOAT;
DECLARE varFixedAssets FLOAT;
DECLARE varFixedAssets_py FLOAT;
DECLARE varDeferredAssets FLOAT;
DECLARE varDeferredAssets_py FLOAT;
DECLARE varCurrentLiabilities FLOAT;
DECLARE varCurrentLiabilities_py FLOAT;
DECLARE varLongTermLiabilities FLOAT;
DECLARE varLongTermLiabilities_py FLOAT;
DECLARE varDeferredLiabilities FLOAT;
DECLARE varDeferredLiabilities_py FLOAT;
DECLARE varTotalAssetY1 FLOAT;
DECLARE varTotalAssetY0 FLOAT;
DECLARE varTotalLiabilitiesY1 FLOAT;
DECLARE varTotalLiabilitiesY0 FLOAT;
DECLARE varTotalEquityY1 FLOAT;
DECLARE varTotalEquityY0 FLOAT;
DECLARE varTotalLiabilitiesEquityY1 FLOAT;
DECLARE varTotalLiabilitiesEquityY0 FLOAT;

#--calculating current assets
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varCurrentAssets FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 61
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;
        
#--calculating current assets of previous year
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varCurrentAssets_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 61
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

#--calculating fixed assets
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varFixedAssets FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 62
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

#--calculating fixed assets of previous year
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varFixedAssets_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 62
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

#--calculating deferred assets
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varDeferredAssets FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 63
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

#--calculating deferred assets of previous year
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varDeferredAssets_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 63
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

#--calculating current liabilities
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varCurrentliabilities FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 64
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

#--calculating current liabilities of previous year
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varCurrentliabilities_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 64
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

#--calculating long term liabilities
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varLongTermLiabilities FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 65
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

#--calculating long term liabilities of previous year
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varLongTermLiabilities_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 65
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

#--calculating deferred liabilities
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varDeferredLiabilities FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 66
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;
        
#--calculating deferred liabilities of previous year
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varDeferredLiabilities_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 66
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

#--calculating total assets
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varTotalAssetY1 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id IN (61 , 62, 63)
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

#---calculating the previous year total assets
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varTotalAssetY0 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id IN (61 , 62, 63)
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

#--calculating total liabilities
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varTotalLiabilitiesY1 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id IN (64 , 65, 66)
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

#--calculating the previous year total liabilities
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varTotalLiabilitiesY0 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id IN (64 , 65, 66)
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

#--Calculating equity
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varTotalEquityY1 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 67
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

#--calculating the previous year equity
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varTotalEquityY0 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id = 67
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

#--calculating liabilities and equity
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varTotalLiabilitiesEquityY1 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id IN (64 , 65, 66, 67)
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

#---calculating the previous year of liabilities and equity
SELECT 
    SUM((jeli.debit) - (jeli.credit))
INTO varTotalLiabilitiesEquityY0 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    balance_sheet_section_id IN (64 , 65, 66, 67)
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

#---values and headers
DROP TABLE IF EXISTS balance_sheet;

#--creating columns that we needs
CREATE TABLE balance_sheet (
    line INT,
    Balance_Sheet VARCHAR(100),
    amount_in_000s_of_USD VARCHAR(50)
);
    
    
INSERT INTO balance_sheet
    (line,balance_sheet, amount_in_000s_of_USD)
    VALUES (1, 'Current Assets', format(varCurrentAssets/ 1000, 2)),
           (2, 'Fixed Assets', format(varFixedAssets / 1000, 2)),
           (3, 'Deferred Assets', format(varDeferredAssets / 1000,2)),
           (4, '',''),
           (5, 'Total Assets', format(varTotalAssetY1 / 1000, 2)),
           (6, '',''),
           (7, 'Current Liabilities', format(varCurrentLiabilities / 1000, 2)),
           (8, 'Long Term Liabilities', format(varLongTermLiabilities / 1000, 2)),
           (9, 'Deferred Liabilities', format(varDeferredLiabilities / 1000, 2)),
           (10, '', ''),
           (11, 'Total Liabilities', format(varTotalLiabilitiesY1 / 1000, 2)),
           (12, '',''),
           (13, 'Equity', format(varTotalEquityY1 /1000, 2)),
           (14, '',''),
           (15, 'Total Liabilities and Equity', format(varTotalLiabilitiesEquityY1 /1000, 2));

DROP TABLE IF EXISTS balance_sheet_change;

#--creating the columns we need for balance sheet
CREATE TABLE balance_sheet_change (
    line INT,
    Balance_sheet_Change VARCHAR(100),
    Y1_in_000s_of_USD VARCHAR(50),
    Y0_in_000s_of_USD VARCHAR(50),
    Percent_change VARCHAR(50)
);

INSERT INTO balance_sheet_change
		   (line, Balance_Sheet_Change , Y1_in_000s_of_USD, Y0_in_000s_of_USD, Percent_change)
	VALUES  (1, 'Total Assets', format(varTotalAssetY1 / 1000, 2), format(varTotalAssetY0 / 1000, 2), CONCAT(format(((varTotalAssetY1-varTotalAssetY0)/varTotalAssetY0)*100,2), '%')),
	        (2, 'Total Liabilities', format(varTotalLiabilitiesY1 / 1000, 2), format(varTotalLiabilitiesY0 / 1000, 2), CONCAT(format(((varTotalLiabilitiesY1-varTotalLiabilitiesY0)/varTotalLiabilitiesY0)*100,2), '%')),
	        (3, 'Total Equity', format(varTotalEquityY1 / 1000, 2), format(varTotalEquityY0 / 1000, 2), CONCAT(format(((varTotalEquityY1-varTotalEquityY0)/varTotalEquityY0)*100,2), '%')),
			(4, 'Total Liabilities and Equity', format(varTotalLiabilitiesEquityY1 / 1000, 2), format(varTotalLiabilitiesEquityY0 / 1000, 2), CONCAT(format(((varTotalLiabilitiesEquityY1-varTotalLiabilitiesEquityY0)/varTotalLiabilitiesEquityY0)*100,2), '%')),
			(5, 'Deferred Liabilities', format(varDeferredLiabilities / 1000, 2), format(varDeferredLiabilities_py / 1000, 2), CONCAT(format(((varDeferredLiabilities-varDeferredLiabilities_py)/varDeferredLiabilities_py)*100,2), '%')),
			(6, 'Long Term liabilities', format(varLongTermLiabilities / 1000, 2), format(varLongTermLiabilities_py / 1000, 2), CONCAT(format(((varLongTermLiabilities-varLongTermLiabilities_py)/varLongTermLiabilities_py)*100,2), '%')),
			(7, 'Current Liabilities', format(varCurrentLiabilities / 1000, 2), format(varCurrentLiabilities_py / 1000, 2), CONCAT(format(((varCurrentLiabilities-varCurrentLiabilities_py)/varCurrentLiabilities_py)*100,2), '%')),
			(8, 'Deferred Assets', format(varDeferredAssets / 1000, 2), format(varDeferredAssets_py / 1000, 2), CONCAT(format(((varDeferredAssets-varDeferredAssets_py)/varDeferredAssets_py)*100,2), '%')),
			(9, 'Fixed Assets', format(varFixedAssets / 1000, 2), format(varFixedAssets_py / 1000, 2), CONCAT(format(((varFixedAssets-varFixedAssets_py)/varFixedAssets_py)*100,2), '%')),
			(10, 'Current Assets', format(varCurrentAssets / 1000, 2), format(varCurrentAssets_py / 1000, 2), CONCAT(format(((varCurrentAssets-varCurrentAssets_py)/varCurrentAssets_py)*100,2), '%'));


End $$




#----------------------------Profit and Loss Statement---------------------------#

DELIMITER $$
DROP PROCEDURE if EXISTS LL_PL_Statement;
CREATE PROCEDURE LL_PL_Statement(varCalendarYear SMALLINT)
BEGIN

#--defining the variables used in the balance sheet---#
DECLARE varRevenue FLOAT;
DECLARE varRevenue_py FLOAT;
DECLARE varReturnsRefundsDiscounts FLOAT;
DECLARE varReturnsRefundsDiscounts_py FLOAT;
DECLARE varCOGS FLOAT;
DECLARE varCOGS_py FLOAT;
DECLARE varAdminExpenses FLOAT;
DECLARE varAdminExpenses_py FLOAT;
DECLARE varSellingExpenses FLOAT;
DECLARE varSellingExpenses_py FLOAT;
DECLARE varOtherExpenses FLOAT;
DECLARE varOtherExpenses_py FLOAT;
DECLARE varOtherIncome FLOAT;
DECLARE varOtherIncome_py FLOAT;
DECLARE varIncomeTax FLOAT;
DECLARE varOtherTax FLOAT;
DECLARE varGrossProfitY1 FLOAT;
DECLARE varGrossProfitY0 FLOAT;
DECLARE varEBITY1 FLOAT;
DECLARE varEBITY0 FLOAT;
DECLARE varProfitLossY1 FLOAT;
DECLARE varProfitLossY0 FLOAT;

#--calculating revenue
SELECT 
    SUM(jeli.credit)
INTO varRevenue FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 68
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;
    
#--calculating revenue of previous year
SELECT 
    SUM(jeli.credit)
INTO varRevenue_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 68
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

-- calculating returns, refunds, discounts 
SELECT 
    SUM(jeli.credit)
INTO varReturnsRefundsDiscounts FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 69
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;
    
-- calculating returns, refunds, discounts of previous year
SELECT 
    SUM(jeli.credit)
INTO varReturnsRefundsDiscounts_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 69
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

-- calculating cost of goods and services
SELECT 
    SUM(jeli.credit)
INTO varCOGS FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 74
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;
    
-- calculating cost of goods and services of previous year
SELECT 
    SUM(jeli.credit)
INTO varCOGS_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 74
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

-- calculating administrative expenses
SELECT 
    SUM(jeli.credit)
INTO varAdminExpenses FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 75
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

-- calculating administrative expenses of previous year
SELECT 
    SUM(jeli.credit)
INTO varAdminExpenses_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 75
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

-- calculating selling expenses
SELECT 
    SUM(jeli.credit)
INTO varSellingExpenses FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 76
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;
    
-- calculating selling expenses of previous year
SELECT 
    SUM(jeli.credit)
INTO varSellingExpenses_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 76
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

-- calculating other expenses
SELECT 
    SUM(jeli.credit)
INTO varOtherExpenses FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 77
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

-- calculating other expenses of previous year
SELECT 
    SUM(jeli.credit)
INTO varOtherExpenses_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 77
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

-- calculating other income
SELECT 
    SUM(jeli.credit)
INTO varOtherIncome FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 78
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

-- calculating other income of previous year
SELECT 
    SUM(jeli.credit)
INTO varOtherIncome_py FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 78
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

-- calculating income tax
SELECT 
    SUM(jeli.credit)
INTO varIncomeTax FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 79
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

-- calculating other tax
SELECT 
    SUM(jeli.credit)
INTO varOtherTax FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id = 80
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

-- calculating gross profit
SELECT 
    SUM(jeli.credit)
INTO varGrossProfitY1 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id IN (68 , 69, 74)
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

# --------calculating the previous year gross profit
SELECT 
    SUM(jeli.credit)
INTO varGrossProfitY0 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id IN (68 , 69, 74)
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

-- calculating ebit
SELECT 
    SUM(jeli.credit)
INTO varEBITY1 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id IN (68 , 69, 74, 75, 76, 77, 78)
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

# --------calculating the previous year ebit
SELECT 
    SUM(jeli.credit)
INTO varEBITY0 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id IN (68 , 69, 74, 75, 76, 77, 78)
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

-- calculating net profit/loss
SELECT 
    SUM(jeli.credit)
INTO varProfitLossY1 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id != 0
        AND YEAR(je.entry_date) = varCalendarYear
        AND je.company_id = 1;

-- calculating the previous year net profit/loss
SELECT 
    SUM(jeli.credit)
INTO varProfitLossY0 FROM
    account AS a
        INNER JOIN
    journal_entry_line_item AS jeli ON a.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON jeli.journal_entry_id = je.journal_entry_id
WHERE
    profit_loss_section_id != 0
        AND YEAR(je.entry_date) = varCalendarYear - 1
        AND je.company_id = 1;

# --------inserting values and headers

DROP TABLE IF EXISTS profit_loss;

-- creating the columns that we need
CREATE TABLE profit_loss (
    line INT,
    Profit_Loss VARCHAR(100),
    amount_in_000s_of_USD VARCHAR(50)
);

INSERT INTO profit_loss
		   (line, Profit_Loss , amount_in_000s_of_USD)
	VALUES  (1, 'Revenues', format(varRevenue / 1000, 2)),
	        (2, 'Returns Refunds and Discounts', format(varReturnsRefundsDiscounts/ 1000, 2)),
	        (3, 'Cost of Goods Services', format(varCOGS / 1000, 2)),
	        (4, '', ''),
	        (5, 'Gross Profit', format(varGrossProfitY1 / 1000, 2)),
	        (6, '', ''),
	        (7, 'Administrative Expenses', format(varAdminExpenses / 1000, 2)),
	        (8, 'Selling Expenses', format(varSellingExpenses / 1000, 2)),
	        (9, 'Other Expenses', format(varOtherExpenses / 1000, 2)),
	        (10, 'Other Income', format(varOtherIncome / 1000, 2)),
	        (11, '', ''),
	        (12, 'EBIT', format(varEBITY1 / 1000, 2)),
	        (13, '', ''),
	        (14, 'Income Tax', format(varIncomeTax / 1000, 2)),
	        (15, 'Other Tax', format(varOtherTax / 1000, 2)),
	        (16, 'Net Profit/Loss', format(varProfitLossY1 / 1000, 2))
;


DROP TABLE IF EXISTS profit_loss_change;

-- creating the columns that we need
CREATE TABLE profit_loss_change (
    line INT,
    Profit_Loss_Change VARCHAR(50),
    Y1_in_000s_of_USD VARCHAR(50),
    Y0_in_000s_of_USD VARCHAR(50),
    Percent_change VARCHAR(50)
);

INSERT INTO profit_loss_change
            (line, Profit_Loss_Change, Y1_in_000s_of_USD, Y0_in_000s_of_USD, Percent_change)
	VALUES  (1, 'Gross Profit', format(varGrossProfitY1 / 1000, 2), format(varGrossProfitY0 / 1000, 2), CONCAT(format(((varGrossProfitY1-varGrossProfitY0)/varGrossProfitY0)*100,2), '%')),
	        (2, 'EBIT', format(varEBITY1 / 1000, 2), format(varEBITY0 / 1000, 2), CONCAT(format(((varEBITY1-varEBITY0)/varEBITY0)*100,2), '%')),
	        (3, 'Net Profit/Loss', format(varProfitLossY1 / 1000, 2), format(varProfitLossY0 / 1000, 2), CONCAT(format(((varProfitLossY1-varProfitLossY0)/varProfitLossY0)*100,2), '%')),
			(4, 'Revenue', format(varRevenue / 1000, 2), format(varRevenue_py / 1000, 2), CONCAT(format(((varRevenue-varRevenue_py)/varRevenue_py)*100,2), '%')),
            (5, 'Returns, Refunds and Discounts', format(varReturnsRefundsDiscounts / 1000, 2), format(varReturnsRefundsDiscounts_py / 1000, 2), CONCAT(format(((varReturnsRefundsDiscounts-varReturnsRefundsDiscounts_py)/varReturnsRefundsDiscounts_py)*100,2), '%')),
            (6, 'COGS', format(varCOGS / 1000, 2), format(varCOGS_py / 1000, 2), CONCAT(format(((varCOGS-varCOGS_py)/varCOGS_py)*100,2), '%')),
            (7, 'Admin Expenses', format(varAdminExpenses / 1000, 2), format(varAdminExpenses_py / 1000, 2), CONCAT(format(((varAdminExpenses-varAdminExpenses_py)/varAdminExpenses_py)*100,2), '%')),
            (8, 'Selling Expenses', format(varSellingExpenses / 1000, 2), format(varSellingExpenses_py / 1000, 2), CONCAT(format(((varSellingExpenses-varSellingExpenses_py)/varSellingExpenses_py)*100,2), '%')),
            (9, 'Other Expenses', format(varOtherExpenses / 1000, 2), format(varOtherExpenses_py / 1000, 2), CONCAT(format(((varOtherExpenses-varOtherExpenses_py)/varOtherExpenses_py)*100,2), '%')),
            (10, 'Other Income', format(varOtherIncome / 1000, 2), format(varOtherIncome_py / 1000, 2), CONCAT(format(((varOtherIncome-varOtherIncome_py)/varOtherIncome_py)*100,2), '%'));
            
END $$

DELIMITER $$

-- Calling P&L and Balance Sheet Statements for the Year

CALL LL_PL_Statement(2015); CALL LL_BS_Statement(2015);

SELECT 
    *
FROM
    profit_loss;
SELECT 
    *
FROM
    balance_sheet;
SELECT 
    *
FROM
    balance_sheet_change;
SELECT 
    *
FROM
    profit_loss_change;
