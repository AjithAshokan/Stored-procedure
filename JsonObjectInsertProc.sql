USE [Janrian]
GO
/****** Object:  StoredProcedure [dbo].[USPPersonInfoUpdate]    Script Date: 6/6/2018 6:21:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[USPPersonInfoUpdate] 
	-- Add the parameters for the stored procedure here
	@ActionParam int,
	@JsonResult Nvarchar(MAX)
		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if @ActionParam = 1
	begin
    -- Insert statements for procedure here
	insert into [dbo].[PersonInfo] (FirstName, LastName, Email, Birthday, Password)
	select * from OPENJSON(@JsonResult) WITH (   
              FirstName varchar(50) '$.givenName',  
              LastName varchar(50) '$.lastName',  
			  Email varchar(50) '$.email', 
              Birthday varchar(70) '$.birthday'  ,
			  Password varchar(70) '$.password'
 ) 
	end
END
