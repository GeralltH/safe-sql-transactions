--Error catching variables
DECLARE @Expected INT = 1;
DECLARE @RowsAffected INT = 0;
DECLARE @Error VARCHAR(500);

BEGIN TRY
	BEGIN TRANSACTION

	USE [DATABASE]

	UPDATE [Users]
	SET ContactName = 'Gerallt Hayes', City= 'Cardiff'
	WHERE CustomerID = 1;	

	SET @RowsAffected += @@ROWCOUNT

	--Error check
	IF @RowsAffected = @Expected
		--success
		BEGIN
			COMMIT TRANSACTION	
			PRINT 'TRANSACTION completed'
		END	  
	ELSE
		--fail
		BEGIN
			RAISERROR('UPDATE FAILED; @Expected / @@Rowcount Mismatch',16,1)
		END      
END TRY

--Display error
BEGIN CATCH
	SET @Error = Error_Message()
	IF @@TRANCOUNT > 0 
		PRINT @Error
		PRINT 'TRANSACTION STATUS; Rolled Back'
		ROLLBACK TRANSACTION
END CATCH