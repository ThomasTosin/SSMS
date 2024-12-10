-- insert into dim.Country
INSERT INTO dim.Country(IDCountry,Country )
	SELECT sc.IDCountry
		  ,sc.Country
	FROM stg.Country sc
	WHERE NOT EXISTS (
    SELECT 1
    FROM dim.Country dc
    WHERE dc.IDCountry = sc.IDCountry
);

GO

-- insert into dim.custype
INSERT INTO dim.CusType(ID_CusType,Customer_Type )
	SELECT sct.ID_CusType
		  ,sct.Customer_Type
	FROM stg.CusType sct
	WHERE NOT EXISTS (
    SELECT 1
    FROM dim.CusType dct
    WHERE dct.ID_CusType = sct.ID_CusType
);


GO

-- insert
INSERT INTO dim.DepType(ID_DepType,Deposit_Type )
	SELECT sd.ID_DepType
		  ,sd.Deposit_Type
	FROM stg.DepType sd
	WHERE NOT EXISTS (
    SELECT 1
    FROM dim.DepType ddt
    WHERE ddt.ID_DepType = sd.ID_DepType
);

GO

-- insert
INSERT INTO dim.distchan(ID_Distchan,Dist_Channel )
	SELECT dc.ID_Distchan
		  ,dc.Dist_channel
	FROM stg.distchan dc
	WHERE NOT EXISTS (
    SELECT 1
    FROM dim.distchan ddc
    WHERE ddc.ID_Distchan = dc.ID_Distchan
);

GO

-- insert
INSERT INTO dim.Hotel_dimen(ID_Hotel,Hotel )
	SELECT hd.ID_Hotel
		  ,hd.Hotel
	FROM stg.Hotel_dimen hd
	WHERE NOT EXISTS (
    SELECT 1
    FROM dim.Hotel_dimen dhd
    WHERE dhd.ID_Hotel = hd.ID_Hotel
);

GO

-- insert into fact table
INSERT INTO fa.Fact_Table(Booking_ID,ID_Hotel,Hotel,Booking_Date,Arrival_Date,Lead_Time,Nights,Guests,
	ID_Distchan,Distribution_Channel,Customer_Type,ID_CusType,Country,ID_DepType,Deposit_Type,Avg_Daily_Rate,
	[Status],Status_Update,[Cancelled(0/1)],Revenue,Revenue_Loss,IDCountry)
	SELECT ft.Booking_ID,
		   ft.ID_Hotel,
		   ft.Hotel,
		   ft.Booking_Date,
		   ft.Arrival_Date,
		   ft.Lead_Time,
		   ft.Nights,
		   ft.Guests,
		   ft.ID_Distchan,
		   ft.Distribution_Channel,
		   ft.Customer_Type,
		   ft.ID_CusType,
		   ft.Country,
		   ft.ID_DepType,
		   ft.Deposit_Type,
		   ft.Avg_Daily_Rate,
		   ft.[Status],
		   ft.Status_Update,
		   ft.[Cancelled(0/1)],
		   ft.Revenue,
		   ft.Revenue_Loss,
		   ft.IDCountry
	FROM stg.Fact_Table ft
	WHERE NOT EXISTS (
    SELECT 1
    FROM fa.Fact_Table f
    WHERE f.Booking_ID = ft.Booking_ID
);

GO