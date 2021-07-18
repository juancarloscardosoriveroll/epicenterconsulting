<!--- Script to Create all tables for Application.datasource --->
<!---
<cfquery dbtype="odbc" datasource="#application.datasource#" name="reset">
CREATE TABLE dbo._catalogs (
	itemId int NOT NULL IDENTITY(1,1),
	catType nvarchar(25) NOT NULL,
	itemName nvarchar(50) NOT NULL,
	itemDesc nvarchar(500) NULL DEFAULT (NULL),
	ownerID int NULL DEFAULT (1),
	catActive bit NULL DEFAULT (1),
	catDate datetime NULL DEFAULT (getdate())
);
ALTER TABLE dbo._catalogs ADD CONSTRAINT PK___catalog__17B6DD06D91D03A3 PRIMARY KEY (itemId);


CREATE TABLE dbo._contacts (
	cID int NOT NULL IDENTITY(1,1),
	cCoName nvarchar(50) NULL DEFAULT (NULL),
	cFirstName nvarchar(25) NULL DEFAULT (NULL),
	cLastName nvarchar(25) NULL DEFAULT (NULL),
	zipcode char(5) NULL DEFAULT (NULL),
	cStreetNum nvarchar(50) NULL DEFAULT (NULL),
	cPhoneMain nvarchar(20) NULL DEFAULT (NULL),
	cPhone800 nvarchar(20) NULL DEFAULT (NULL),
	cEmail nvarchar(50) NULL DEFAULT (NULL),
	cWebSite nvarchar(100) NULL DEFAULT (NULL),
	cRegDate datetime NULL DEFAULT (getdate()),
	cLastDate datetime NULL DEFAULT (getdate()),
	isMarina bit NULL DEFAULT (0),
	isLead int NULL DEFAULT (0),
	isOEM bit NULL DEFAULT (0),
	isMFG bit NULL DEFAULT (0),
	isOMIM bit NULL DEFAULT (0),
	isSalC bit NULL DEFAULT (0),
	refType int NULL DEFAULT (0)
);
ALTER TABLE dbo._contacts ADD CONSTRAINT PK___contact__D830D457DCE5E9DF PRIMARY KEY (cID);

CREATE TABLE dbo._contacts_data (
	dataID int NOT NULL IDENTITY(1,1),
	cId int NOT NULL,
	cField nvarchar(25) NULL DEFAULT (NULL),
	cValue nvarchar(1000) NULL DEFAULT (NULL)
);

ALTER TABLE dbo._contacts_data ADD CONSTRAINT PK___contact__923E36854609D54A PRIMARY KEY (dataID);
CREATE TABLE dbo._errors (
	catchID int NOT NULL IDENTITY(1,1),
	catchDateTime datetime NULL DEFAULT (getdate()),
	catchMessage text NULL DEFAULT (NULL),
	catchArguments text NULL DEFAULT (NULL),
	catchFixed bit NULL DEFAULT ('0'),
	catchService nvarchar(50) NOT NULL
);
ALTER TABLE dbo._errors ADD CONSTRAINT PK___errors__25BF8CE65A8A806C PRIMARY KEY (catchID);

CREATE TABLE dbo._users (
	userId int NOT NULL IDENTITY(1,1),
	userActive bit NULL DEFAULT ('1'),
	userFirstName nvarchar(50) NOT NULL,
	userLastName nvarchar(50) NOT NULL,
	userEmail nvarchar(75) NOT NULL,
	userPass nvarchar(75) NOT NULL,
	userPhone nvarchar(15) NULL DEFAULT (NULL),
	userRegDate datetime NULL DEFAULT (getdate()),
	accessToken nvarchar(75) NULL DEFAULT (NULL)
);
ALTER TABLE dbo._users ADD CONSTRAINT PK___users__CB9A1CFF5585186F PRIMARY KEY (userId);

CREATE TABLE dbo._users_permits (
	permitId int NOT NULL IDENTITY(1,1),
	userId int NOT NULL,
	permitName nvarchar(50) NOT NULL
);

ALTER TABLE dbo._users_permits ADD CONSTRAINT PK___permits__E3B28778AE087B6B PRIMARY KEY (permitId);
</cfquery>

Done!
--->