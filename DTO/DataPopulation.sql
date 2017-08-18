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