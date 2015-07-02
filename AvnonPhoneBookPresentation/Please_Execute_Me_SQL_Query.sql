drop database DB_Avnon_Consulting

CREATE DATABASE DB_Avnon_Consulting

CREATE TABLE tb_USER
(
	UserID UNIQUEIDENTIFIER PRIMARY KEY,
	Username VARCHAR (100) NOT NULL,
	User_Password VARCHAR(20) NOT NULL
)

CREATE TABLE tb_Photo
(
	PhotoId UNIQUEIDENTIFIER PRIMARY KEY,
	PhotoUrl VARCHAR (MAX) NOT NULL,
)

-- CREATING TABLE DEPARTMENT
CREATE TABLE tb_DEPARTMENT
(
	Dpt_ID UNIQUEIDENTIFIER PRIMARY KEY,
	Dpt_Name VARCHAR (100) NOT NULL,
)

-- CREATING TABLE CONTACT
CREATE TABLE tb_CONTACT
(
	ContactId UNIQUEIDENTIFIER PRIMARY KEY,
	ContactName VARCHAR (100) ,
	Telephone VARCHAR(30) NOT NULL,
	Email_Address VARCHAR(100) ,
	ContactTag VARCHAR(10) NOT NULL,
	UserID UNIQUEIDENTIFIER FOREIGN KEY REFERENCES tb_USER (UserID),
	Dpt_ID UNIQUEIDENTIFIER FOREIGN KEY REFERENCES tb_DEPARTMENT (Dpt_ID),
	ContactLocation VARCHAR(100),
	ContactPhotoId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES tb_Photo (PhotoId)
)

--CREATING TABLE MESSAGES
CREATE TABLE tb_MESSAGE
(
	MessageID UNIQUEIDENTIFIER PRIMARY KEY,
	MsgSender UNIQUEIDENTIFIER FOREIGN KEY REFERENCES tb_CONTACT (ContactID),
	MsgReceiver UNIQUEIDENTIFIER FOREIGN KEY REFERENCES tb_CONTACT (ContactID),
	MsgCOntent VARCHAR(1000),
	DateSent DATETIME DEFAULT(CURRENT_TIMESTAMP)
)

--CREATING PHONEBOOK TABLE WHICH IS A COMPOSITE TABLE THAT WILL HOLD BOTH PRIMARY KEY OF CONTACT AND USER AS PK, AND FOREIGN KEYS
CREATE TABLE tb_PHONEBOOK
(
	UserId UNIQUEIDENTIFIER REFERENCES tb_USER(UserId),
	ContactId UNIQUEIDENTIFIER REFERENCES tb_Contact(ContactId),
	PRIMARY KEY (UserId,ContactId)
)
GO


-- Seed Data For Table Department.
INSERT INTO tb_DEPARTMENT values ('95F137B5-F580-41B1-BC6B-0A5A0492BA3E','Finance')
INSERT INTO tb_DEPARTMENT values ('3A21DC07-0129-4710-893B-F21BBD144478','Management')
INSERT INTO tb_DEPARTMENT values ('2C9A5D2F-5F47-4BD6-8C8C-1D7356858795','Human Resources')
GO

-- Seed Data For Table User.
UPDATE tb_CONTACT
SET
ContactName = 'Admin'
select * from tb_CONTACT
where USERID = '5F45B55F-4851-4BC9-AF27-76757F5B1C09'
GO

select * from tb_CONTACT
Where ContactId = '680668AC-81AF-412A-80C9-69D384B75DEC'

select * from tb_CONTACT

INSERT INTO tb_USER values ('0A2E329B-947A-4850-AB1C-4D8D1FEE125A','Jude','123456')
INSERT INTO tb_USER values ('4A18A50E-2AC6-43CB-B7A6-47FBAE3B742A','Lehan','123456')
INSERT INTO tb_USER values ('8EA77267-39DF-4585-A349-F00671974145','Ross','123456')
INSERT INTO tb_USER values ('AF465874-9F04-4A6E-9F26-F5A26783A7FD','Harding','123456')
INSERT INTO tb_USER values ('8C9082AD-E021-423C-BC02-B3F892AD254C','Wesley','123456')
INSERT INTO tb_USER values ('3A88C175-C7C4-4452-912D-C9E0A2BA865D','Robbie','123456')
INSERT INTO tb_USER values ('74867447-0C0B-41A1-BCC1-ABBB2E5DBDC7','Niven','123456')
INSERT INTO tb_USER values ('122D3FF0-D0B0-4FFC-A3C5-CE26269A3EA2','Seth','123456')
INSERT INTO tb_USER values ('FEFC8A67-5114-45C6-8F8D-1430B105E9C0','Alvin','123456')
INSERT INTO tb_USER values ('5F45B55F-4851-4BC9-AF27-76757F5B1C09','Admin','123456')
GO

-- Seed Data For Table Contacts.
INSERT INTO tb_CONTACT values ('0A2E329B-947A-4850-AB1C-4D8D1FEE125A','Jude','0793352641','jude@derivo.com','A12','0A2E329B-947A-4850-AB1C-4D8D1FEE125A','95F137B5-F580-41B1-BC6B-0A5A0492BA3E','Durban',null)
INSERT INTO tb_CONTACT values ('4A18A50E-2AC6-43CB-B7A6-47FBAE3B742A','Lehan','0793352642','babsjude@derivo.com','B12','4A18A50E-2AC6-43CB-B7A6-47FBAE3B742A','95F137B5-F580-41B1-BC6B-0A5A0492BA3E','Pretoria',null)
INSERT INTO tb_CONTACT values ('8EA77267-39DF-4585-A349-F00671974145','Ross','0793352643','Rossjude@derivo.com','A13','8EA77267-39DF-4585-A349-F00671974145','95F137B5-F580-41B1-BC6B-0A5A0492BA3E','Durban',null)
INSERT INTO tb_CONTACT values ('AF465874-9F04-4A6E-9F26-F5A26783A7FD','Harding','0793352644','Hardingjude@derivo.com','C15','AF465874-9F04-4A6E-9F26-F5A26783A7FD','3A21DC07-0129-4710-893B-F21BBD144478','Durban',null)
INSERT INTO tb_CONTACT values ('8C9082AD-E021-423C-BC02-B3F892AD254C','Wesley','0793352645','Wesleyjude@derivo.com','S85','8C9082AD-E021-423C-BC02-B3F892AD254C','3A21DC07-0129-4710-893B-F21BBD144478','Durban',null)
INSERT INTO tb_CONTACT values ('3A88C175-C7C4-4452-912D-C9E0A2BA865D','Robbie','0793352646','Robbiejude@derivo.com','W78','3A88C175-C7C4-4452-912D-C9E0A2BA865D','3A21DC07-0129-4710-893B-F21BBD144478','Joburg',null)
INSERT INTO tb_CONTACT values ('122D3FF0-D0B0-4FFC-A3C5-CE26269A3EA2','Seth','0793352648','Sethjude@derivo.com','F56','122D3FF0-D0B0-4FFC-A3C5-CE26269A3EA2','2C9A5D2F-5F47-4BD6-8C8C-1D7356858795','Pretoria',null)
INSERT INTO tb_CONTACT values ('FEFC8A67-5114-45C6-8F8D-1430B105E9C0','Alvin','0793352649','Alvinjude@derivo.com','F89','FEFC8A67-5114-45C6-8F8D-1430B105E9C0','2C9A5D2F-5F47-4BD6-8C8C-1D7356858795','Pretoria',null)
INSERT INTO tb_CONTACT values ('C7B07AF6-D377-455A-BAED-2152E177BCC3','Admin','0892323564','naomikiab@gmail.com','Q49','5F45B55F-4851-4BC9-AF27-76757F5B1C09','95F137B5-F580-41B1-BC6B-0A5A0492BA3E','Cape Town',null)
GO
-- End Seed Data


-- CREATING STORED PROCEDURES TO RETRIEVE ALL CONTACTS
CREATE PROCEDURE SP_GET_ALL_CONTACTS @userId UNIQUEIDENTIFIER
AS 
Select * from tb_CONTACT
WHERE UserID <> @userId
GO

-- CREATING STORED PROCEDURES TO RETRIEVE CONTACT BY LOCATION
CREATE PROCEDURE SP_GET_ALL_CONTACTS_BY_LOCATION @location varchar(100)
AS
SELECT * FROM tb_CONTACT
WHERE tb_CONTACT.ContactLocation like @location
GO

-- CREATE STORED PROCEDURE TO RETRIEVE CONTACT BY DEPT
CREATE PROCEDURE SP_GET_CONTACTS_BY_DEPT @department VARCHAR(100)
AS
SELECT * FROM tb_CONTACT cont 
JOIN tb_DEPARTMENT dept
ON cont.Dpt_ID = dept.Dpt_ID
WHERE dept.Dpt_Name like @department
GO

--CREATING STORED PROCEDURE TO INSERT DATA INTO TABLE CONTACT
CREATE PROCEDURE SP_ADD_NEW_CONTACT_TO_PHONEBOOK
 @UserId UNIQUEIDENTIFIER , 
 @ContactId UNIQUEIDENTIFIER
 AS
 INSERT INTO tb_PHONEBOOK VALUES (
  @UserId,
 @ContactId
 )
 GO

 --CREATING STORED PROCEDURE TO RETRIEVE DATA FOR A USER PHONEBOOK
 CREATE PROCEDURE SP_GET_PHONEBOOK_CONTACTS @userId VARCHAR(100)
 AS
 SELECT * FROM tb_PHONEBOOK
 WHERE UserId = @userId
 GO

--CREATING STORED PROCEDURE TO INSERT DATA INTO TABLE CONTACT
CREATE PROCEDURE SP_ADD_NEW_CONTACT
 @contactId UNIQUEIDENTIFIER , 
 @contactName VARCHAR(100) ,
 @telephone VARCHAR(30),
 @email_Address VARCHAR(100) ,
 @contactTag VARCHAR(10),
 @userID UNIQUEIDENTIFIER,
 @dpt_ID UNIQUEIDENTIFIER,
 @contactLocation VARCHAR(100),
 @contactPhotoId UNIQUEIDENTIFIER
 AS
 INSERT INTO tb_CONTACT VALUES (
 @contactId, 
 @contactName,
 @telephone,
 @email_Address,
 @contactTag,
 @userID,
 @dpt_ID,
 @contactLocation,
 @contactPhotoId 
 )

 
 --EXECUTING PROCEDURE DUMMY DATA
EXEC SP_ADD_NEW_CONTACT 
@contactId ='74867447-0C0B-41A1-BCC1-ABBB2E5DBDC7',
@contactName = 'Niven',
@telephone = '0793352647',
@email_Address ='Nivenjude@derivo.com',
@contactTag = 'Q45',
@userID = '74867447-0C0B-41A1-BCC1-ABBB2E5DBDC7',
@dpt_ID = '95F137B5-F580-41B1-BC6B-0A5A0492BA3E',
@contactLocation = 'Durban',
@contactPhotoId = null


-- Testing Retreiveing phonebook contact for user Admin
exec SP_GET_PHONEBOOK_CONTACTS '5F45B55F-4851-4BC9-AF27-76757F5B1C09'
GO

--Trying adding Niven AND rOBBIE as new contact to Admin PhoneBook
exec SP_ADD_NEW_CONTACT_TO_PHONEBOOK '5F45B55F-4851-4BC9-AF27-76757F5B1C09','74867447-0C0B-41A1-BCC1-ABBB2E5DBDC7'
exec SP_ADD_NEW_CONTACT_TO_PHONEBOOK '5F45B55F-4851-4BC9-AF27-76757F5B1C09','3A88C175-C7C4-4452-912D-C9E0A2BA865D'


