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

*All Files (complete one time)*
1. Open SSMS.
2. Connect to applicable server.
3. Right-click on 'Databases' under 'Object Explorer.'
4. Select 'New Database.'
5. Fill in 'Database name' to eCommerceSalesData.
6. Select 'Ok.'


*Excel Files*
1. Expand 'Databases' list.
2. Right-click on the database you just created.
3. Select 'Tasks' > 'Import Data.'
4. The Import/Export Wizard welcome screen will appear, select 'Next.'
5. From the 'Data source' drop down, select 'Microsoft Excel.'
6. Select 'Browse...'
7. Locate the file then select 'Next.'
8. From the 'Destination' drop down, select "SQL Server Native Client 11.0.'
9. From the 'Server name' drop down, select the applicable server.
10. Select the applicable 'Authenticaton' radio button.
11. From the 'Database' drop down, ensure the correct database is selected (created in step 5).
12. Select the radio button, "Copy data from..." then select 'Next.'
13. Under the 'Destination' column, edit the text to rename your table as follows:
13a. Rename Poshmark Sales Report download to PoshmarkSales
13b. Rename Personal Excel File(s) to MySales[year]
14. Check the box 'Run immediately' and leave 'Save SSIS Package' unchecked, then select 'Finish,' then 'Finish' again.
15. Resolve any errors identified or select 'Close.'
16. Repeat steps until all files are imported.


*CSV Files*
1. Expand 'Databases' list.
2. Right-click on the database you just created.
3. Select 'Tasks' > 'Import Flat File.'
4. The Import Flat File Wizard welcome screen will appear, select 'Next.'
5. Select 'Browse...'
6. Locate the file.
7. Under 'New table name' enter your table name as follows:
7a. Rename Poshmark Sales Report download to PoshmarkSales
7b. Rename Personal Excel File(s) to MySales[year(s)]
8. Select 'Next.'
9. On the 'Preview data' screen, do not make any changes. Select 'Next.'
10. On the 'Modify Columns' screen:
10a. Check the box in the column 'Allow Nulls' for all rows.
10b. Change 'Data Type' for 'Column Name' "Item" to 'varchar(MAX).
11. Select 'Next.'
12. Resolve any errors identified or select 'Close.'
13. Repeat steps until all files are imported.


### Clean Raw Data
1. Open SSMS.
2. Connect to applicable server.
3. Select 'New Query' from the ribbon.
4. Copy/Paste code from repository.
5. Execute.
6. Right-click anywhere on the query results and select 'Save Results As,' select your destination and 'Save.'

