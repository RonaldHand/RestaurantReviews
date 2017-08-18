
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

		INSERT INTO dbo.ContactInformation (address_1, address_2, city, state, zip_code, phone_number, fax_number, email)
		VALUES (@address1, @address2, @city, @state, @zipcode, @phonenumber, @faxnumber, @email)
		
		SELECT @contact_id = SCOPE_IDENTITY()

		INSERT INTO dbo.[User] (login_name, password_hash, salt, first_name, last_name, recovery_email, contact_id)
		VALUES (@loginname, HASHBYTES('SHA2_512', @password+CAST(@salt AS NVARCHAR(36))), @salt, @firstname, @lastname,  @recoveryemail, @contact_id)


END
GO