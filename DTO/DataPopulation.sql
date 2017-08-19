INSERT INTO dbo.Category (category_name, active, date_created, date_modified)
VALUES	('Mexican', 1, GETUTCDATE(), GETUTCDATE()),
		('Chinese', 1, GETUTCDATE(), GETUTCDATE()),
		('Italian', 1, GETUTCDATE(), GETUTCDATE()),
		('Sushi', 1, GETUTCDATE(), GETUTCDATE()),
		('Steak', 1, GETUTCDATE(), GETUTCDATE()),
		('Pizza', 1, GETUTCDATE(), GETUTCDATE()),
		('International', 1, GETUTCDATE(), GETUTCDATE()),
		('Japanese', 1, GETUTCDATE(), GETUTCDATE()),
		('Indian', 1, GETUTCDATE(), GETUTCDATE()),
		('Thai', 1, GETUTCDATE(), GETUTCDATE())


INSERT INTO	dbo.SocialMedia (social_media_name, active, date_created, date_modified)
VALUES	( 'Facebook', 1, GETUTCDATE(), GETUTCDATE()),
		( 'Twitter', 1, GETUTCDATE(), GETUTCDATE()),
		( 'Instagram', 1, GETUTCDATE(), GETUTCDATE()),
		( 'Yelp', 1, GETUTCDATE(), GETUTCDATE()),
		( 'MySpace', 0, GETUTCDATE(), GETUTCDATE())


INSERT INTO dbo.Feature (feature_name, active, date_created, date_modified)
VALUES	('Take Out',1, GETUTCDATE(), GETUTCDATE()),
		('Deliever',1, GETUTCDATE(), GETUTCDATE()),
		('Reservations',1, GETUTCDATE(), GETUTCDATE()),
		('WiFi',1, GETUTCDATE(), GETUTCDATE()),
		('Apple Pay',1, GETUTCDATE(), GETUTCDATE()),
		('Google Waller',1, GETUTCDATE(), GETUTCDATE()),
		('Outdoor Seating',1, GETUTCDATE(), GETUTCDATE())

--CREATES USERS AND USERCONTACTINFO RECORD FOR USER
EXEC dbo.CreateUser 'LoginName1', 'Password1', 'FirstName1', 'LastName1', 'Recover1@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC dbo.CreateUser 'LoginName2', 'Password2', 'FirstName2', 'LastName2', 'Recover2@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC dbo.CreateUser 'LoginName3', 'Password3', 'FirstName3', 'LastName3', 'Recover3@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC dbo.CreateUser 'LoginName4', 'Password4', 'FirstName4', 'LastName4', 'Recover4@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC dbo.CreateUser 'LoginName5', 'Password5', 'FirstName5', 'LastName5', 'Recover5@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC dbo.CreateUser 'LoginName6', 'Password6', 'FirstName6', 'LastName6', 'Recover6@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC dbo.CreateUser 'LoginName7', 'Password7', 'FirstName7', 'LastName7', 'Recover7@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC dbo.CreateUser 'LoginName8', 'Password8', 'FirstName8', 'LastName8', 'Recover8@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC dbo.CreateUser 'LoginName9', 'Password9', 'FirstName9', 'LastName9', 'Recover9@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL


--**************************************************************************************************************************
--CREATE RESTAURANT 
--**************************************************************************************************************************
DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Nintendo Italian Restaurant', 'Detailed Description', 'Address Line 1', 'address2', 'Salem', 'FL', '12345', '(555) 555-1212', '(555) 555-3434', 'nin@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Instagram' FROM dbo.SocialMedia WHERE social_media_name = 'Instagram'	
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Reservations'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Outdoor Seating'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Italian'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Palace Eats', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Salem', 'GA', '12345', '(555) 555-1212', '(555) 555-3434', 'pe@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Instagram' FROM dbo.SocialMedia WHERE social_media_name = 'Instagram'	
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Reservations'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'WiFi'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Apple Pay'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Google Wallet'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Outdoor Seating'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Indian'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Jessica Burger', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Salem', 'IN', '12345', '(555) 555-1212', '(555) 555-3434', 'jj@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Instagram' FROM dbo.SocialMedia WHERE social_media_name = 'Instagram'	
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'American'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Manny/Lou Cafe', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Salem', 'IA', '12345', '(555) 555-1212', '(555) 555-3434', 'ml@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Instagram' FROM dbo.SocialMedia WHERE social_media_name = 'Instagram'	
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Outdoor Seating'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'American'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Casa Nayarit', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Bethel Park', 'PA', '15102', '(555) 555-1212', '(555) 555-3434', 'email1@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Instagram' FROM dbo.SocialMedia WHERE social_media_name = 'Instagram'	
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Reservations'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'WiFi'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Mexican'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Chipotle Mexican Grill', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Bethel Park', 'PA', '15102', '(555) 555-1212', '(555) 555-3434', 'email2@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Instagram' FROM dbo.SocialMedia WHERE social_media_name = 'Instagram'	
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Reservations'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Mexican'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Saga', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Bethel Park', 'PA', '15102', '(555) 555-1212', '(555) 555-3434', 'email3@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Instagram' FROM dbo.SocialMedia WHERE social_media_name = 'Instagram'	
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Reservations'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Outdoor Seating'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Japanese'	
	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Sushi'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Rice Inn', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Bethel Park', 'PA', '15102', '(555) 555-1212', '(555) 555-3434', 'email4@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Instagram' FROM dbo.SocialMedia WHERE social_media_name = 'Instagram'	
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Reservations'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Chinese'	
	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Japanese'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Pho Kim', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Bethel Park', 'PA', '15102', '(555) 555-1212', '(555) 555-3434', 'email5@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Instagram' FROM dbo.SocialMedia WHERE social_media_name = 'Instagram'	
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Delievery'
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Reservations'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Chinese'	
	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Japanese'	
	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Thai'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Asain Garden', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Bethel Park', 'PA', '15102', '(555) 555-1212', '(555) 555-3434', 'email6@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Instagram' FROM dbo.SocialMedia WHERE social_media_name = 'Instagram'	
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Reservations'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Apple Pay'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Google Wallet'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Outdoor Seating'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Chinese'	
	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Sushi'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Panda Express', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Bethel Park', 'PA', '15102', '(555) 555-1212', '(555) 555-3434', 'email7@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Chinese'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Panda Mandarin Garden', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Bethel Park', 'PA', '15102', '(555) 555-1212', '(555) 555-3434', 'email8@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Reservations'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Chinese'	
	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Sushi'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

DECLARE @restaurant_id INT, @socialmediadata AS KVPUpsertList, @featurelist AS KVPUpsertList, @categorylist AS KVPUpsertList
EXEC dbo.Restaurant_Create 'Panda Garden', 'Detailed Description', 'Address Line 1', 'Address Line 2', 'Bethel Park', 'PA', '15102', '(555) 555-1212', '(555) 555-3434', 'email9@gmail.com'
	SELECT @restaurant_id = @@IDENTITY
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Facebook' FROM dbo.SocialMedia WHERE social_media_name = 'Facebook'
	INSERT INTO @socialmediadata (Id, Value) SELECT id, '@sample/Twitter' FROM dbo.SocialMedia WHERE social_media_name = 'Twitter'
	EXEC dbo.Restaurant_SocialMediaUpsert @restaurant_id, @socialmediadata

	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Take Out'
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Reservations'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Apple Pay'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Google Wallet'	
	INSERT INTO @featurelist (Id) SELECT id FROM dbo.Feature WHERE feature_name = 'Outdoor Seating'	
	EXEC Restaurant_FeatureUpsert @restaurant_id, @featurelist

	INSERT INTO @categorylist (Id) SELECT id FROM dbo.Category WHERE category_name = 'Chinese'	
	EXEC Restaurant_CategoryUpsert @restaurant_id, @categorylist
GO

EXEC dbo.Review_Create  1, 1, 'Restaurant 1 Review', 4
EXEC dbo.Review_Create  1, 2, 'Restaurant 2 Review', 4
EXEC dbo.Review_Create  1, 3, 'Restaurant 3 Review', 4
EXEC dbo.Review_Create  1, 4, 'Restaurant 4 Review', 3
EXEC dbo.Review_Create  1, 5, 'Restaurant 5 Review', 3
EXEC dbo.Review_Create  1, 6, 'Restaurant 6 Review', 2
EXEC dbo.Review_Create  1, 7, 'Restaurant 7 Review', 1
EXEC dbo.Review_Create  2, 7, 'Restaurant 7 Review', 1
EXEC dbo.Review_Create  3, 7, 'Restaurant 7 Review', 2
EXEC dbo.Review_Create  4, 1, 'Restaurant 1 Review', 4
EXEC dbo.Review_Create  5, 3, 'Restaurant 3 Review', 4
EXEC dbo.Review_Create  6, 7, 'Restaurant 7 Review', 3
EXEC dbo.Review_Create  6, 5, 'Restaurant 5 Review', 5
EXEC dbo.Review_Create  6, 3, 'Restaurant 3 Review', 5
EXEC dbo.Review_Create  7, 1, 'Restaurant 1 Review', 3
EXEC dbo.Review_Create  7, 2, 'Restaurant 2 Review', 4