CREATE PROCEDURE dbo.ContactInformation_Insert
(
	@address1		NVARCHAR(MAX),
	@address2		NVARCHAR(MAX),
	@city			NVARCHAR(MAX),
	@state			CHAR(2),
	@zipcode		NVARCHAR(MAX),
	@phonenumber	NVARCHAR(MAX),
	@faxnumber		NVARCHAR(MAX),
	@email			NVARCHAR(MAX), 
	@contact_id		INT OUTPUT
)
AS
	INSERT INTO dbo.ContactInformation (address_1, address_2, city, state, zip_code, phone_number, fax_number, email)
	VALUES (@address1, @address2, @city, @state, @zipcode, @phonenumber, @faxnumber, @email)
		
	SELECT @contact_id = SCOPE_IDENTITY()
GO

CREATE PROCEDURE dbo.CreateUser
    @loginname		NVARCHAR(250), 
    @password		NVARCHAR(50),
    @firstname		NVARCHAR(40), 
    @lastname		NVARCHAR(40),
    @recoveryemail	NVARCHAR(MAX),
	@address1		NVARCHAR(MAX),
	@address2		NVARCHAR(MAX),
	@city			NVARCHAR(MAX),
	@state			CHAR(2),
	@zipcode		NVARCHAR(MAX),
	@phonenumber	NVARCHAR(MAX),
	@faxnumber		NVARCHAR(MAX),
	@email			NVARCHAR(MAX)	
AS

BEGIN
    SET NOCOUNT ON

		DECLARE @salt UNIQUEIDENTIFIER=NEWID()
		DECLARE @contact_id INT

		--CREATE ENTRY IN CONTACT INFORMATION AND RETURN CONTACT ID
		EXEC dbo.ContactInformation_Insert @address1, @address2, @city, @state, @zipcode, @phonenumber, @faxnumber, @email, @contact_id = @contact_id OUTPUT

		INSERT INTO dbo.ContactInformation (address_1, address_2, city, state, zip_code, phone_number, fax_number, email)
		VALUES (@address1, @address2, @city, @state, @zipcode, @phonenumber, @faxnumber, @email)
		
		SELECT @contact_id = SCOPE_IDENTITY()

		INSERT INTO dbo.[User] (login_name, password_hash, salt, first_name, last_name, recovery_email, contact_id)
		VALUES (@loginname, HASHBYTES('SHA2_512', @password+CAST(@salt AS NVARCHAR(36))), @salt, @firstname, @lastname,  @recoveryemail, @contact_id)


END
GO

CREATE PROCEDURE Restaurant_Create
(
	@name				NVARCHAR(MAX),
	@description		NVARCHAR(MAX),
	@address1			NVARCHAR(MAX),
	@address2			NVARCHAR(MAX),
	@city				NVARCHAR(MAX),
	@state				CHAR(2),
	@zipcode			NVARCHAR(MAX),
	@phonenumber		NVARCHAR(MAX),
	@faxnumber			NVARCHAR(MAX),
	@email				NVARCHAR(MAX)
)
AS
	BEGIN
		--CREATE ENTRY IN CONTACT INFORMATION AND RETURN CONTACT ID
		DECLARE @contact_id INT
		EXEC dbo.ContactInformation_Insert @address1, @address2, @city, @state, @zipcode, @phonenumber, @faxnumber, @email, @contact_id = @contact_id OUTPUT

		INSERT INTO dbo.Restaurant (restaurant_name, description, contact_information_id, active, date_created, date_modified )
		VALUES (@name, @description, @contact_id, 1, GETUTCDATE(), GETUTCDATE() )

	END
GO

CREATE PROCEDURE Restaurant_SocialMediaUpsert
(
	@restaurant_id		INT,
	@socialmediadata	AS KVPUpsertList	READONLY 
)
AS
	BEGIN
		MERGE dbo.RestaurantSocialMedia AS TARGET
		USING	(SELECT Id, Value, MarkForDelete FROM @socialmediadata) AS Source 
			ON	Source.id = Target.social_media_id 
			AND Target.restaurant_id = @restaurant_id
		WHEN NOT MATCHED BY TARGET AND Source.MarkForDelete = 0 THEN 
			INSERT (restaurant_id, social_media_id, social_media_link) VALUES (@restaurant_id, Source.Id,  Source.Value)
		WHEN MATCHED THEN
			UPDATE SET 
					TARGET.social_media_link = Source.Value,  
					TARGET.active = CASE Source.MarkForDelete WHEN 1 THEN 0 ELSE 1 END;
	END
GO

CREATE PROCEDURE Restaurant_FeatureUpsert
(
	@restaurant_id		INT,
	@features			AS KVPUpsertList	READONLY 
)
AS
	BEGIN
		MERGE dbo.RestaurantFeature AS TARGET
		USING	(SELECT Id, MarkForDelete FROM @features) AS Source 
			ON	Source.id = Target.feature_id 
			AND Target.restaurant_id = @restaurant_id
		WHEN NOT MATCHED BY TARGET AND Source.MarkForDelete = 0 THEN 
			INSERT (restaurant_id, feature_id) VALUES (@restaurant_id, Source.Id)
		WHEN MATCHED THEN
			UPDATE SET 
					TARGET.active = CASE Source.MarkForDelete WHEN 1 THEN 0 ELSE 1 END;
	END
GO

CREATE PROCEDURE Restaurant_CategoryUpsert
(
	@restaurant_id		INT,
	@categories			AS KVPUpsertList	READONLY 
)
AS
	BEGIN
		MERGE dbo.RestaurantCategory AS TARGET
		USING	(SELECT Id, MarkForDelete FROM @categories) AS Source 
			ON	Source.id = Target.category_id 
			AND Target.restaurant_id = @restaurant_id
		WHEN NOT MATCHED BY TARGET AND Source.MarkForDelete = 0 THEN 
			INSERT (restaurant_id, category_id) VALUES (@restaurant_id, Source.Id)
		WHEN MATCHED THEN
			UPDATE SET 
					TARGET.active = CASE Source.MarkForDelete WHEN 1 THEN 0 ELSE 1 END;
	END
GO

CREATE PROCEDURE Restaurant_Find
(
	@name VARCHAR(MAX), 
	@state CHAR(2), 
	@city VARCHAR(MAX), 
	@featurelist AS IdList  READONLY, 
	@categorylist AS IdList  READONLY
)
AS
BEGIN
	DECLARE @fl BIT = 0, @cl BIT = 0
	IF EXISTS (SELECT * FROM @featurelist)		SET @fl = 1
	IF EXISTS (SELECT * FROM @categorylist)		SET @cl = 1

	SELECT 
		A.id,
		A.restaurant_name,
		A.description
	FROM 
		dbo.Restaurant A
		INNER JOIN dbo.ContactInformation B
			ON B.id = A.contact_information_id
	WHERE
			B.state = ISNULL(@state, B.state)
		AND CASE WHEN @city IS NULL THEN 1 WHEN B.city LIKE '%'+@city+'%' THEN 1 ELSE 0  END = 1
		AND CASE WHEN @name IS NULL THEN 1 WHEN A.restaurant_name LIKE '%'+@name+'%' THEN 1 ELSE 0  END = 1
		AND CASE 
				WHEN @fl = 0  THEN 1 
				WHEN A.id IN (SELECT restaurant_id FROM dbo.RestaurantFeature WHERE feature_id IN (SELECT id FROM @featurelist)) THEN 1 
				ELSE 0 
			END = 1
		AND CASE 
				WHEN @cl = 0  THEN 1 
				WHEN A.id IN (SELECT restaurant_id FROM dbo.RestaurantCategory WHERE category_id IN (SELECT id FROM @categorylist)) THEN 1 
				ELSE 0 
			END = 1
		AND A.active = 1
END
GO

CREATE PROCEDURE Review_Create
(
	@userid			INT,
	@restaurant_id	INT,
	@review_comment	VARCHAR(MAX),
	@rating			INT
)
AS 

	INSERT INTO dbo.Review (user_id, restaurant_id, review_comment, rating)
	VALUES (@userid, @restaurant_id, @review_comment, @rating)
GO

CREATE PROCEDURE Review_Update
(
	@id				INT,
	@review_comment	VARCHAR(MAX),
	@rating			INT
)
AS 
	UPDATE dbo.Review SET review_comment = @review_comment, rating = @rating, date_modified =  GETUTCDATE()
	WHERE id =  @id
GO

CREATE PROCEDURE Review_Delete
(
	@id				INT
)
AS 
	DELETE dbo.Review WHERE id =  @id
GO

--GIVEN MORE TIME I WOULD LOG REPORT ABUSE BY REPORTING USER, TO ONLY ALLOW A SINGLE REPORT PER REVIEW
CREATE PROCEDURE Review_ReportAbuse
(
	@id INT
)
AS
	UPDATE dbo.Review SET reported_abuse =  reported_abuse + 1, date_modified =  GETUTCDATE() WHERE id = @id
GO

CREATE PROCEDURE Review_UpVote
(
	@id INT
)
AS
	UPDATE dbo.Review SET up_votes = up_votes + 1, date_modified =  GETUTCDATE() WHERE id = @id
GO    

CREATE PROCEDURE Review_GetByUser
(
	@userid INT
) AS
BEGIN
	SELECT A.id,
       A.review_comment,
       A.up_votes,
       A.rating,
       A.date_created		AS ReviewDate,
       B.login_name			AS ReviewedBy
	FROM 
		dbo.Review A 
		INNER JOIN [dbo].[User] B 
			ON B.id = A.user_id
	WHERE
		A.user_id = @userid
END
GO

CREATE PROCEDURE Review_GetByRestaurant
(
	@restaurantid INT
) AS
BEGIN
	SELECT A.id,
       A.review_comment,
       A.up_votes,
       A.rating,
       A.date_created		AS ReviewDate,
       B.login_name			AS ReviewedBy
	FROM 
		dbo.Review A 
		INNER JOIN [dbo].[User] B 
			ON B.id = A.user_id
	WHERE
		A.restaurant_id = @restaurantid
END
GO