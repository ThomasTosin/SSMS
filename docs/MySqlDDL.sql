Create database Myproject

use Myproject;
go


IF NOT EXISTS (SELECT * FROM sys.schemas WHERE NAME = 'stg')
BEGIN
	EXEC('CREATE SCHEMA stg AUTHORIZATION dbo;');
END;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE NAME = 'dim')
BEGIN
	EXEC('CREATE SCHEMA dim AUTHORIZATION dbo;');
END;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE NAME = 'fa')
BEGIN
	EXEC('CREATE SCHEMA fa AUTHORIZATION dbo;');
END;
GO

-----Creat
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'Country')
BEGIN
	CREATE TABLE dim.Country(
	IDCountry bigint NOT NULL,
	Country nvarchar(max) not NULL
	)
	;

	ALTER TABLE dim.Country
	ADD CONSTRAINT PK_IDCountry PRIMARY KEY(IDCountry);

END

--Custype
-----Creat
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'CusType')
BEGIN
	CREATE TABLE dim.CusType(
	ID_CusType bigint NOT NULL,
	Customer_Type nvarchar(max) not NULL
	)
	;

	ALTER TABLE dim.CusType
	ADD CONSTRAINT PK_ID_CusType PRIMARY KEY(ID_CusType);

END

--deptype
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'DepType')
BEGIN
	CREATE TABLE dim.DepType(
	ID_DepType bigint NOT NULL,
	Deposit_Type nvarchar(max) not NULL
	)
	;

	ALTER TABLE dim.DepType
	ADD CONSTRAINT PK_ID_DepType PRIMARY KEY(ID_DepType);

END

-- distchan
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'distchan')
BEGIN
	CREATE TABLE dim.distchan(
	ID_Distchan bigint NOT NULL,
	Dist_Channel nvarchar(max) not NULL
	)
	;

	ALTER TABLE dim.distchan
	ADD CONSTRAINT PK_ID_Distchan PRIMARY KEY(ID_Distchan);

END

-- hotel dim
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'Hotel_dimen')
BEGIN
	CREATE TABLE dim.Hotel_dimen(
	ID_Hotel bigint NOT NULL,
	Hotel nvarchar(max) not NULL
	)
	;

	ALTER TABLE dim.Hotel_dimen
	ADD CONSTRAINT PK_ID_Hotel PRIMARY KEY(ID_Hotel);

END

-- fact
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'fa' AND TABLE_NAME = 'Fact_Table')
BEGIN
    DROP TABLE fa.Fact_Table;
END

GO

	CREATE TABLE fa.Fact_Table(
	Booking_ID bigint Not NULL,
	ID_Hotel bigint NULL,
	Hotel nvarchar(max) NULL,
	Booking_Date datetime2(0) Null,
	Arrival_Date datetime2(0) Null,
	Lead_Time bigint null,
	Nights bigint null,
	Guests bigint null,
	ID_Distchan bigint null,
	Distribution_Channel nvarchar(max) null,
	Customer_Type nvarchar(max) null,
	ID_CusType bigint null,
	Country nvarchar(max) null,
	ID_DepType bigint null,
	Deposit_Type nvarchar(max) null,
	Avg_Daily_Rate float null,
	[Status] nvarchar(max) null,
	Status_Update datetime2(0) null,
	[Cancelled(0/1)] bigint null,
	Revenue float null,
	Revenue_Loss float null,
	IDCountry bigint null
	)
	;

-- primary and foreign keys

ALTER TABLE fa.Fact_Table
ADD CONSTRAINT PK_Booking_ID PRIMARY KEY(Booking_ID)
;

ALTER TABLE fa.Fact_Table
ADD CONSTRAINT FK_FatoCou
	FOREIGN KEY (IDCountry)              -- FROM the LOCAL TABLE
	 REFERENCES  dim.Country(IDCountry) -- TO the FOREIGN TABLE
;

ALTER TABLE fa.Fact_Table
ADD CONSTRAINT FK_FatoCT
	FOREIGN KEY (ID_CusType)              -- FROM the LOCAL TABLE
	 REFERENCES  dim.CusType(ID_CusType) -- TO the FOREIGN TABLE
;

ALTER TABLE fa.Fact_Table
ADD CONSTRAINT FK_FatoDT
	FOREIGN KEY (ID_DepType)              -- FROM the LOCAL TABLE
	 REFERENCES  dim.DepType(ID_DepType) -- TO the FOREIGN TABLE
;

ALTER TABLE fa.Fact_Table
ADD CONSTRAINT FK_FatoDC
	FOREIGN KEY (ID_Distchan)
	 REFERENCES dim.distchan(ID_Distchan)
;

ALTER TABLE fa.Fact_Table
ADD CONSTRAINT FK_FatoHD
	FOREIGN KEY (ID_Hotel)
	 REFERENCES dim.Hotel_dimen(ID_Hotel)
;
