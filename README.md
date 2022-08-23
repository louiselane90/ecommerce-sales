# ecommerce-sales
Sales data from various ecommerce platforms

## Project Description
Identify sales trends across one or more ecommerce platforms leveraging seller data tracked in-house and on the platform(s).

Uses the following applications: 
SQL Server 2019, Tableau, Excel

## Development

### Obtain Data
POSHMARK
1. Log in to the account at www.poshmark.com.
2. Navigate to 'My Sales Report.'
3. Select desired timeframe for sales data (recommended: 'Custom Range' to obtain all time sales data).
4. Report will be emailed to the email associated with the Poshmark account. Click link in email to download report.
5. Save report as .xls (recommended: Excel 97-2003).
6. Delete top 12 rows.
7. Save and close.

PERSONAL EXCEL FILES (Template in Repository)
1. Save prior year inventory and sales tracking excel file(s).
2. Save current inventory and sales tracking excel file.

EBAY (Coming Soon)<br />
ETSY (Coming Soon)<br />
DEPOP (Coming Soon)<br />
MERCARI (Coming Soon)<br />
AMAZON (Coming Soon)<br />

### Load Data
1. Open SSMS.
2. Connect to applicable server.
3. Right-click on 'Databases' under 'Object Explorer.'
4. Select 'New Database.'
5. Fill in 'Database name' to eC (recommended: eCommerceSalesData).
6. Select 'Ok.'
7. Expand 'Databases' list.
8. Right-click on the database you just created.
9. Select 'Tasks' > 'Import Data.'
10. The Import/Export Wizard welcome screen will appear, select 'Next.'
11. From the 'Data source' drop down, select 'Microsoft Excel.'
12. Select 'Browse...'
13. Locate the file then select 'Next.'
14. From the 'Destination' drop down, select "SQL Server Native Client 11.0.'
15. From the 'Server name' drop down, select the applicable server.
16. Select the applicable 'Authenticaton' radio button.
17. From the 'Database' drop down, ensure the correct database is selected (created in step 5).
18. Select the radio button, "Copy data from..." then select 'Next.'
19. Under the 'Destination' column, edit the text to rename your table as follows:
19a. Rename Poshmark Sales Report download to PoshmarkSales
19b. Rename Personal Excel File(s) to MySales[year]
20. Check the box 'Run immediately' and leave 'Save SSIS Package' unchecked, then select 'Finish,' then 'Finish' again.
21. Resolve any errors identified or select 'Close.'
22. Repeat steps 7-21 until all files are imported.

### Clean Raw Data
1. 
2. 
3. 

### Import to Tableau & Create New Dashboard
1. 
2. 
3. 

### Import to Tableau & Update Existing Dashboard
1. 
2. 
3. 
