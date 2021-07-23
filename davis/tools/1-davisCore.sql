-- Database export via SQLPro (https://www.sqlprostudio.com/allapps.html)
-- Exported by juancarloscardosoriveroll at 22-07-2021 21:16.
-- WARNING: This file may contain descructive statements such as DROPs.
-- Please ensure that you are running the script at the proper location.


-- BEGIN TABLE dbo._catalogs
IF OBJECT_ID('dbo._catalogs', 'U') IS NOT NULL
DROP TABLE dbo._catalogs;
GO

CREATE TABLE dbo._catalogs (
	itemId int NOT NULL IDENTITY(1,1),
	catType nvarchar(25) NOT NULL,
	itemName nvarchar(50) NOT NULL,
	itemDesc nvarchar(500) NULL DEFAULT (NULL),
	ownerID int NULL DEFAULT (1),
	catActive bit NULL DEFAULT (1),
	catDate datetime NULL DEFAULT (getdate())
);
GO

ALTER TABLE dbo._catalogs ADD CONSTRAINT PK___catalog__17B6DD06D91D03A3 PRIMARY KEY (itemId);
GO

-- Table dbo._catalogs contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo._catalogs


-- END TABLE dbo._catalogs

-- BEGIN TABLE dbo._contacts
IF OBJECT_ID('dbo._contacts', 'U') IS NOT NULL
DROP TABLE dbo._contacts;
GO

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
	refType int NULL DEFAULT (0),
	cIsValid bit NULL DEFAULT ('1'),
	cOwnerId int NULL DEFAULT ('1')
);
GO

ALTER TABLE dbo._contacts ADD CONSTRAINT PK___contact__D830D457DCE5E9DF PRIMARY KEY (cID);
GO

-- Table dbo._contacts contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo._contacts


-- END TABLE dbo._contacts

-- BEGIN TABLE dbo._contacts_data
IF OBJECT_ID('dbo._contacts_data', 'U') IS NOT NULL
DROP TABLE dbo._contacts_data;
GO

CREATE TABLE dbo._contacts_data (
	dataID int NOT NULL IDENTITY(1,1),
	cId int NOT NULL,
	cField nvarchar(25) NULL DEFAULT (NULL),
	cValue nvarchar(1000) NULL DEFAULT (NULL)
);
GO

ALTER TABLE dbo._contacts_data ADD CONSTRAINT PK___contact__923E36854609D54A PRIMARY KEY (dataID);
GO

-- Table dbo._contacts_data contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo._contacts_data


-- END TABLE dbo._contacts_data

-- BEGIN TABLE dbo._errors
IF OBJECT_ID('dbo._errors', 'U') IS NOT NULL
DROP TABLE dbo._errors;
GO

CREATE TABLE dbo._errors (
	catchID int NOT NULL IDENTITY(1,1),
	catchDateTime datetime NULL DEFAULT (getdate()),
	catchMessage text NULL DEFAULT (NULL),
	catchArguments text NULL DEFAULT (NULL),
	catchFixed bit NULL DEFAULT ('0'),
	catchService nvarchar(50) NOT NULL
);
GO

ALTER TABLE dbo._errors ADD CONSTRAINT PK___errors__25BF8CE65A8A806C PRIMARY KEY (catchID);
GO

-- Table dbo._errors contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo._errors


-- END TABLE dbo._errors

-- BEGIN TABLE dbo._users
IF OBJECT_ID('dbo._users', 'U') IS NOT NULL
DROP TABLE dbo._users;
GO

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
GO

ALTER TABLE dbo._users ADD CONSTRAINT PK___users__CB9A1CFF5585186F PRIMARY KEY (userId);
GO

-- Inserting 1 row into dbo._users
-- Insert batch #1
INSERT INTO dbo._users (userId, userActive, userFirstName, userLastName, userEmail, userPass, userPhone, userRegDate, accessToken) VALUES
(1, 1, 'Davis', '&Co', 'info@daviscoltd.com', '0E382076EBF46BC5BA91AB2C5B2BBAF7733C2005', '1-800-223-8816', '2021-07-22 21:05:41.010', NULL);

-- END TABLE dbo._users

-- BEGIN TABLE dbo._users_permits
IF OBJECT_ID('dbo._users_permits', 'U') IS NOT NULL
DROP TABLE dbo._users_permits;
GO

CREATE TABLE dbo._users_permits (
	permitId int NOT NULL IDENTITY(1,1),
	userId int NOT NULL,
	permitName nvarchar(50) NOT NULL
);
GO

ALTER TABLE dbo._users_permits ADD CONSTRAINT PK___permits__E3B28778AE087B6B PRIMARY KEY (permitId);
GO

-- Inserting 12 rows into dbo._users_permits
-- Insert batch #1
INSERT INTO dbo._users_permits (permitId, userId, permitName) VALUES
(1, 1, 'users.register'),
(2, 1, 'users.userlist.view'),
(3, 1, 'users.active'),
(4, 1, 'catalogs.itemnew'),
(5, 1, 'catalogs.itemedit'),
(6, 1, 'catalogs.active'),
(7, 1, 'users.edit'),
(8, 1, 'users.password'),
(9, 1, 'contacts.new'),
(10, 1, 'contacts.edit'),
(11, 1, 'contacts.active'),
(12, 1, 'contacts.metadelete');

-- END TABLE dbo._users_permits

