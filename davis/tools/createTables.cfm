<!--- Script to Create all tables for Application.datasource --->

<cfquery dbtype="odbc" datasource="#application.datasource#" name="reset">
/* _ERRORS table is used to log all catch errors, useful for debugging UAT */
CREATE TABLE dbo._errors (
	catchID int NOT NULL IDENTITY(1,1),
	catchDateTime datetime NULL DEFAULT (getdate()),
	catchMessage text NULL DEFAULT (NULL),
	catchArguments text NULL DEFAULT (NULL),
	catchFixed bit NULL DEFAULT ('0'),
	catchService nvarchar(50) NOT NULL
);
ALTER TABLE dbo._errors ADD CONSTRAINT PK___errors__25BF8CE65A8A806C PRIMARY KEY (catchID);

/* USERS table is used to store platform admin users */
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

/* _PERMITS table is used to map users to functions */
CREATE TABLE dbo._permits (
	permitId int NOT NULL IDENTITY(1,1),
	userId int NOT NULL,
	permitName nvarchar(50) NOT NULL
);
ALTER TABLE dbo._permits ADD CONSTRAINT PK___permits__E3B28778AE087B6B PRIMARY KEY (permitId);
</cfquery>

Done!