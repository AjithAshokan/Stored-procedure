declare @JsonResult Nvarchar(MAX)
set @JsonResult='[{
  "favorites": {
    "teamNBA1": "Charlotte Hornets(CHA)"
  },
  "lastName": "mohandas1",
  "email": "monica123@sample.com",
  "birthday": "06-01-2000",
  "password": "1",
  "givenName": "Monica",
  "primaryAddress": {
    "country": "Brazil",
    "zip": "682007",
    "phone": "8126659898"
  },
  "opt": {
    "email": {
      "lastUpdate": "2018-06-06T06:28:06",
      "source": "5vnxy6rgdksdqwdhkvabb7p5pg97q8c5",
      "status": "true"
    }
  }
}]'
--select *

begin tran
update p
set p.FirstName=j.FirstName,
p.LastName=j.LastName,
p.Birthday=j.Birthday,
p.[Password] =j.[Password]
from dbo.personinfo p
 inner join OPENJSON(@JsonResult) WITH (   
              FirstName varchar(50) '$.givenName',  
              LastName varchar(50) '$.lastName',  
			  Email varchar(50) '$.email', 
              Birthday varchar(70) '$.birthday'  ,
			  Password varchar(70) '$.password') j on j.Email=p.Email 

			  select * from dbo.personinfo

			  rollback tran
