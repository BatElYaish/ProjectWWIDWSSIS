
IF DB_ID (N'ProjectWWIDW') IS NULL
BEGIN
CREATE DATABASE ProjectWWIDW
COLLATE Latin1_General_100_CI_AS
END
GO
USE ProjectWWIDW
/* Procedures */
GO
CREATE  PROCEDURE [dbo].[GenerateDates] @MinDate date, @MaxDate date
AS
BEGIN

  WHILE @MinDate <= @MaxDate
  BEGIN
	INSERT INTO  [dbo].[DIMDate]
	VALUES(@MinDate,
	        DATEPART(YY,@MinDate),
			DATEPART(mm,@MinDate),
			DATEPART(QUARTER,  @MinDate),
			DATEPART(dd,@MinDate), 
			DATEPART(dw,@MinDate), 
			DATENAME(mm,@MinDate),
			DATENAME(dw,@MinDate))
	
	SET @MinDate = DATEADD(dd,1,@MinDate)
  END



END
GO

-- ---------------------- STAGING -------------------------------------------------
 CREATE TABLE [ProjectWWIDW].[dbo].[DIMDate](
	DateKey Date, 
	Year INT, 
	Month INT, 
	Quarter INT,
	DayNumber INT, 
	WeekDayNumber INT, 
	MonthName VARCHAR(20),
	WeekDayName VARCHAR(20)
	)
GO


CREATE TABLE [ProjectWWIDW].[dbo].[STGProducts] (
    ProductKey int PRIMARY KEY,
    ProductName nvarchar(100),
    ProductSubCategory varchar(50),
    ProductCategory varchar(50),
    SupplierKey int,
    LeadTimeDays int,
    QuantityPerOuter int,
	OuterSize decimal(28,6),
    TargetStockLevel int,
    UnitPackageName nvarchar(50),
    OuterPackageName nvarchar(50),
    Color nvarchar(50)
)
GO
CREATE TABLE [ProjectWWIDW].[dbo].[STGSuppliers] (
    SupplierKey int PRIMARY KEY,
    SupplierName nvarchar(100),
    SupplierCategory nvarchar(50),
    PaymentDays int,
    ExtraCosts decimal(28,6),
    Incoterms nvarchar(50),
    LeadTime int,
    Currency nvarchar(50),
    LocationKey int
)
GO

CREATE TABLE [ProjectWWIDW].[dbo].[STGLoctions] (
	LocationKey int PRIMARY KEY IDENTITY(1,1) ,
    CountryID int,
    CountryName nvarchar(60),
    Continent nvarchar(30),
    Region nvarchar(30),
    Subregion nvarchar(30),
    ISOCode nvarchar(3),
	StateProvinceID int,
    StateProvinceName nvarchar(50),
    SalesTerritory nvarchar(50)
)
GO

CREATE TABLE [ProjectWWIDW].[dbo].[STGCustomers](
	CustomerKey int PRIMARY KEY,
	CustomerName nvarchar(100) ,
	CustomerCategoryName nvarchar(50) ,
	LocationKey int ,
	AccountOpenedDate date
) 
GO

CREATE TABLE [ProjectWWIDW].[dbo].[STGEmployees] (
    EmployeeKey int PRIMARY KEY,
    EmployeeName nvarchar(50),
    IsSalesperson bit
)
GO

CREATE TABLE [ProjectWWIDW].[dbo].[STGPurchases] (
    PurchaseKey bigint PRIMARY KEY ,
    PurchaseOrderKey int,
    ProductKey int,
    OutersQuantity int,
    PricePerOuter numeric(18,2),
    ProductQuantity int,
    SupplierKey int,
    DateKey date,
    AmountExcludingTax numeric(18,2),
    IsOrderFinalized bit,
	LocationKey int,
    LastExtract date
)
GO
CREATE TABLE [ProjectWWIDW].[dbo].[STGSales] (
    SaleKey bigint PRIMARY KEY,
    DateKey date,
    ProductKey int,
    Quantity int,
    UnitPrice numeric(18,2),
    Profit numeric(18,2),
    InvoiceKey int,
    CustomerKey int,
    EmployeeKey int,
    DeliveryDate date,
    OrderDate date,
    EstimatedDeliveryDate date,
    LocationKey int,
	LastExtract date
)
GO
CREATE TABLE [ProjectWWIDW].[dbo].[STGProductTransactions] (
	ProductKey int ,
	CurrentInventory bigint,
	BinLocation nvarchar(50),
	BinCapacity bigint,
	LastCost decimal(28,3)
)
GO

---------------------------------------------------------------------------------------
CREATE TABLE [ProjectWWIDW].[dbo].[DIMProducts] (
    ProductKey int PRIMARY KEY,
    ProductName nvarchar(100),
    ProductSubCategory varchar(50),
    ProductCategory varchar(50),
    SupplierKey int,
    LeadTimeDays int,
    QuantityPerOuter int,
	OuterSize decimal(28,6),
    TargetStockLevel int,
    UnitPackageName nvarchar(50),
    OuterPackageName nvarchar(50),
    Color nvarchar(50),
	LastExtract date
)
GO
CREATE TABLE [ProjectWWIDW].[dbo].[DIMSuppliers] (
    SupplierKey int PRIMARY KEY,
    SupplierName nvarchar(100),
    SupplierCategory nvarchar(50),
    PaymentDays int,
    ExtraCosts decimal(28,6),
    Incoterms nvarchar(50),
    LeadTime int,
    Currency nvarchar(50),
    LocationKey int,
	LastExtract date
)
GO

CREATE TABLE [ProjectWWIDW].[dbo].[DIMLoctions] (
	LocationKey int PRIMARY KEY IDENTITY(1,1),
    CountryName nvarchar(60),
    Continent nvarchar(30),
    Region nvarchar(30),
    Subregion nvarchar(30),
    ISOCode nvarchar(3),
    StateProvinceName nvarchar(50),
    SalesTerritory nvarchar(50),
	LastExtract date
)
GO

CREATE TABLE [ProjectWWIDW].[dbo].[DIMCustomers](
	CustomerKey int PRIMARY KEY,
	CustomerName nvarchar(100) ,
	CustomerCategory nvarchar(50) ,
	LocationKey int ,
	AccountOpenedDate date,
	LastExtract date
) 
GO

CREATE TABLE [ProjectWWIDW].[dbo].[DIMEmployees] (
    EmployeeKey int PRIMARY KEY,
    EmployeeName nvarchar(50),
    IsSalesperson bit,
	LastExtract date
)
GO


CREATE TABLE [ProjectWWIDW].[dbo].[FACTProductTransactions] (
    ProdTransKey bigint PRIMARY KEY IDENTITY(1,1),
	ProductKey int ,
	CurrentInventory bigint,
	BinLocation nvarchar(50),
	BinCapacity bigint,
	LastCost decimal(28,3),
	LastExtract date,
	ValidFrom date,
	ValidTo date
)

GO
CREATE TABLE [ProjectWWIDW].[dbo].[FACTPurchases] (
    PurchaseKey bigint PRIMARY KEY ,
    PurchaseOrderKey int,
    ProductKey int,
    OutersQuantity int,
    PricePerOuter numeric(18,2),
    ProductQuantity int,
    SupplierKey int,
    DateKey date,
    AmountExcludingTax numeric(18,2),
    IsOrderFinalized bit,
	LocationKey int,
    LastExtract date
)
GO
CREATE TABLE [ProjectWWIDW].[dbo].[FACTSales] (
    SaleKey bigint PRIMARY KEY,
    DateKey date,
    ProductKey int,
    Quantity int,
    UnitPrice numeric(18,2),
    Profit numeric(18,2),
    InvoiceKey int,
    CustomerKey int,
    EmployeeKey int,
    DeliveryDate date,
    OrderDate date,
    EstimatedDeliveryDate date,
    LocationKey int,
	LastExtract date
)
GO


----------------------------------------------------------------------------------------
