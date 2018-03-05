USE [NuNetworkDb]
GO
/****** Object:  StoredProcedure [dbo].[USPEventView]    Script Date: 3/5/2018 8:47:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<>
-- Create date: <27/11/2017>
-- Description:	<Event View>
-- =============================================
CREATE PROCEDURE [dbo].[USPEventView]
	@CompanyId int

AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON;
		SELECT tblEvent.EventId, tblEvent.EventName,tblEvent.EventDescription,CONVERT(VARCHAR(10),tblEvent.StartDate,103)As StartDate,CONVERT(VARCHAR(10),tblEvent.EndDate,103)As EndDate ,tblEvent.Time,CONCAT(tblUserRegistration.FirstName , ' ', tblUserRegistration.LastName) AS CreatedBy FROM tblEvent 
		JOIN tblUserRegistration ON tblEvent.FK_UserId=tblUserRegistration.UserId 
		JOIN tblCompanyRegistration ON tblCompanyRegistration.CompanyId=tblUserRegistration.FK_CompanyCode
		WHERE tblUserRegistration.FK_CompanyCode=@CompanyId
		AND tblEvent.FK_EventStausId=1 AND tblEvent.StartDate > GETDATE() order by tblEvent.StartDate 
	END TRY
	BEGIN CATCH
		Declare @Error_No int=ERROR_NUMBER(),
		@Error_Pro varchar(150)=ERROR_PROCEDURE(),
		@Error_Line int=ERROR_LINE(),
		@Error_Message varchar(150)=ERROR_MESSAGE(),
		@Error_State int =ERROR_STATE()
		EXEC USPExceptionInsertion @Error_No,@Error_Pro,@Error_Line,@Error_Message,@Error_State,4 --calling procedure USPExceptionInsertion
	END CATCH

    
END
