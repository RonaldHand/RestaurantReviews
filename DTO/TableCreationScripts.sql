--***********************************************************************************
--	Restaurant Category  Definition: Chinese, Italian, Pizza, Sushi, Steak, etc
--***********************************************************************************
CREATE TABLE dbo.Category
(
	id				INT								IDENTITY(1,1)	PRIMARY KEY,
	category_name	NVARCHAR(50)					NOT NULL		UNIQUE,
	active			BIT								DEFAULT 1,
	date_created	DATETIME						DEFAULT  GETUTCDATE(),
	date_modified	DATETIME						DEFAULT  GETUTCDATE()
)
GO

--***********************************************************************************
--Social Media Definition: Twitter, Instagram, SnapChat, FaceBook, etc
--***********************************************************************************
CREATE TABLE SocialMedia
(
	id					INT								IDENTITY(1,1)	PRIMARY KEY,
	social_media_name	NVARCHAR(50)					NOT NULL		UNIQUE,
	active				BIT								DEFAULT 1,
	date_created		DATETIME						DEFAULT  GETUTCDATE(),
	date_modified		DATETIME						DEFAULT  GETUTCDATE()
)
GO

--***********************************************************************************
--Feature Definition: Wifi, Delivery, Take Out
--***********************************************************************************
CREATE TABLE dbo.Feature
(
	id					INT								IDENTITY(1,1)	PRIMARY KEY,
	feature_name		NVARCHAR(50)					NOT NULL		UNIQUE,
	active				BIT								DEFAULT 1,
	date_created		DATETIME						DEFAULT  GETUTCDATE(),
	date_modified		DATETIME						DEFAULT  GETUTCDATE()
)
GO

--***********************************************************************************
--Contact Information: Address and contact information for users and restraunts
--***********************************************************************************
CREATE TABLE ContactInformation
(
	id				INT								IDENTITY(1,1)	PRIMARY KEY,
	address_1		NVARCHAR(MAX),
	address_2		NVARCHAR(MAX),
	city			NVARCHAR(MAX),
	state			CHAR(2),
	zip_code		NVARCHAR(MAX),
	phone_number	NVARCHAR(MAX),
	fax_number		NVARCHAR(MAX),
	email			NVARCHAR(MAX),
)
GO

--***********************************************************************************
--User: For reviewers and restraunt administrators
--***********************************************************************************
CREATE TABLE dbo.[User]
(
	id						INT										IDENTITY(1,1)	PRIMARY KEY,
	login_name				NVARCHAR(250)				NOT NULL	UNIQUE,
	password_hash			BINARY(64)					NOT NULL,
	salt					UNIQUEIDENTIFIER			NOT NULL,
    first_name				NVARCHAR(40)				NOT NULL,
    last_name				NVARCHAR(40)				NOT NULL,
	avatar					IMAGE,
	recovery_email			NVARCHAR(MAX)				NOT NULL,
	contact_id				INT										FOREIGN KEY REFERENCES ContactInformation(id),
	failed_login_attempts	INT										DEFAULT 0,
	locked					BIT										DEFAULT 0,
	active					BIT										DEFAULT 1,
	date_created			DATETIME								DEFAULT  GETUTCDATE(),
	date_modified			DATETIME								DEFAULT  GETUTCDATE()
)
GO

--***********************************************************************************
--Restraunt Definition:
--Notes: 
--***********************************************************************************
CREATE TABLE dbo.Restaurant
(
	id							INT								IDENTITY(1,1)	PRIMARY KEY,
	restaurant_name				NVARCHAR(MAX)					NOT NULL,
	description					NVARCHAR(MAX)					NOT NULL,
	contact_information_id		INT								FOREIGN KEY REFERENCES ContactInformation(id),
	active						BIT								DEFAULT 1,
	date_created				DATETIME						DEFAULT  GETUTCDATE(),
	date_modified				DATETIME						DEFAULT  GETUTCDATE()
)
GO

--***********************************************************************************
--Relational Table defining the social media for a customer. Created as a relational
--table since social media apps come and go frequently. This will allow for the  
--dynamic addition social media without code changes.
--Notes: Should create unique constraint on restaurant and Media ID
--***********************************************************************************
CREATE TABLE  dbo.RestaurantSocialMedia
(
	id					INT								IDENTITY(1,1)	PRIMARY KEY,
	restaurant_id		INT				NOT NULL		FOREIGN KEY REFERENCES Restaurant(id),
	social_media_id		INT				NOT NULL		FOREIGN KEY REFERENCES SocialMedia(id),
	social_media_link	NVARCHAR(MAX)	NOT NULL,
	active				BIT								DEFAULT 1,
	date_created		DATETIME						DEFAULT  GETUTCDATE(),
	date_modified		DATETIME						DEFAULT  GETUTCDATE()
)
GO

--***********************************************************************************
--Relation table for restaurant features, allowing for the addition of new features
--over time as the work progresses without a schema change.
--Notes: Should create unique constraint on restaurant and Feature
--***********************************************************************************
CREATE TABLE  RestaurantFeature
(
	id					INT								IDENTITY(1,1)	PRIMARY KEY,
	restaurant_id		INT				NOT NULL		FOREIGN KEY REFERENCES Restaurant(id),
	feature_id			INT				NOT NULL		FOREIGN KEY REFERENCES Feature(id),
	active				BIT								DEFAULT 1,
	date_created		DATETIME						DEFAULT  GETUTCDATE(),
	date_modified		DATETIME						DEFAULT  GETUTCDATE()
)
GO

--***********************************************************************************
--Relation table for restaurant Category
--***********************************************************************************
CREATE TABLE  RestaurantCategory
(
	id					INT								IDENTITY(1,1)	PRIMARY KEY,
	restaurant_id		INT				NOT NULL		FOREIGN KEY REFERENCES Restaurant(id),
	category_id			INT				NOT NULL		FOREIGN KEY REFERENCES dbo.Category(id),
	active				BIT								DEFAULT 1,
	date_created		DATETIME						DEFAULT  GETUTCDATE(),
	date_modified		DATETIME						DEFAULT  GETUTCDATE()
)
GO


--***********************************************************************************
--User Reviews of Restaurants
--***********************************************************************************
CREATE TABLE dbo.Review
(
	id					INT									IDENTITY(1,1)	PRIMARY KEY,
	user_id				INT				NOT NULL			FOREIGN KEY REFERENCES dbo.[User](id),
	restaurant_id		INT				NOT NULL			FOREIGN KEY REFERENCES Restaurant(id),
	review_comment		NVARCHAR(MAX),
	up_votes			INT,
	reported_abuse 		INT,
	rating				INT,
	date_created		DATETIME						DEFAULT  GETUTCDATE(),
	date_modified		DATETIME						DEFAULT  GETUTCDATE()
)
GO

--***********************************************************************************
--Restaurant Hours of Operation
--Notes: Should create unique constraint on restaurant and DOW
--***********************************************************************************
CREATE TABLE dbo.HoursOfOperation
(
	id					INT									IDENTITY(1,1)	PRIMARY KEY,
	restaurant_id		INT				NOT NULL			FOREIGN KEY REFERENCES Restaurant(id),
	day_of_week			TINYINT			NOT NULL,
	time_opened			TIME			NOT NULL,
	time_closed			TIME			NOT NULL,
	date_created		DATETIME						DEFAULT  GETUTCDATE(),
	date_modified		DATETIME						DEFAULT  GETUTCDATE()
)