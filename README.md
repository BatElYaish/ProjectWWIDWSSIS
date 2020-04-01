# ProjectWWIDWSSIS \n
Project WWI DW with SSIS\n
Hi All,\n
This is a project based on the Wide World Importers sample databases for Microsoft SQL by Microsoft. 
  (Information on the sample database can be found here -> 
    https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-ver15)

Coming from a background of importing, purchasing and management I wanted to create my own version of a data warehouse for this database.
There are somethings that I add with csv files that I created to answer the type of questions that I find interesting. 
For example, I wanted to know the countries from where the company imports its goods, 
but I found out, after thoroughly canvasing the WWI database, that there is no info of that kind…

For the SSIS solution to work you need to follow these steps:
1.	Restore the Wide World Importers sample databases 
    (Download can be found Here -> 
      https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-oltp-install-configure?view=sql-server-ver15)
2.	Run the SQL script - SQLScript.sql
3.	Change the parameter v_FilesPath in the solution to where you saved the files up to the Sources folder. 
    For example: ‘C:\ProjectWWIDW\Sources\’ . 
    Or you can download the folder straight to your C drive…
4.	Run the ‘Master’ package or each of the packages by order.

Have a great day!
BatEl Yaish.
