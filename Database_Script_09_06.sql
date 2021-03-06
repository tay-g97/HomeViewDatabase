USE [master]
GO
/****** Object:  Database [HomeView]    Script Date: 09/06/2022 10:54:22 ******/
CREATE DATABASE [HomeView]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HomeView', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HomeView.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HomeView_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HomeView_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [HomeView] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HomeView].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HomeView] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HomeView] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HomeView] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HomeView] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HomeView] SET ARITHABORT OFF 
GO
ALTER DATABASE [HomeView] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HomeView] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HomeView] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HomeView] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HomeView] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HomeView] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HomeView] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HomeView] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HomeView] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HomeView] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HomeView] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HomeView] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HomeView] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HomeView] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HomeView] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HomeView] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HomeView] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HomeView] SET RECOVERY FULL 
GO
ALTER DATABASE [HomeView] SET  MULTI_USER 
GO
ALTER DATABASE [HomeView] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HomeView] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HomeView] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HomeView] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HomeView] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HomeView] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HomeView', N'ON'
GO
ALTER DATABASE [HomeView] SET QUERY_STORE = OFF
GO
USE [HomeView]
GO
/****** Object:  Schema [aggregate]    Script Date: 09/06/2022 10:54:23 ******/
CREATE SCHEMA [aggregate]
GO
/****** Object:  UserDefinedTableType [dbo].[AccountType]    Script Date: 09/06/2022 10:54:23 ******/
CREATE TYPE [dbo].[AccountType] AS TABLE(
	[Username] [varchar](20) NOT NULL,
	[NormalizedUsername] [varchar](20) NOT NULL,
	[Firstname] [varchar](15) NOT NULL,
	[Lastname] [varchar](15) NOT NULL,
	[Dateofbirth] [varchar](10) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
	[Addressline1] [varchar](30) NOT NULL,
	[Addressline2] [varchar](30) NULL,
	[Addressline3] [varchar](30) NULL,
	[Town] [varchar](20) NULL,
	[City] [varchar](20) NULL,
	[Postcode] [varchar](10) NOT NULL,
	[Accounttype] [varchar](6) NOT NULL,
	[Email] [varchar](30) NOT NULL,
	[NormalizedEmail] [varchar](30) NOT NULL,
	[Phone] [varchar](15) NULL,
	[MarketingEmail] [bit] NOT NULL DEFAULT (CONVERT([bit],(0))),
	[MarketingPhone] [bit] NOT NULL DEFAULT (CONVERT([bit],(0))),
	[ProfilepictureId] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[MessageType]    Script Date: 09/06/2022 10:54:23 ******/
CREATE TYPE [dbo].[MessageType] AS TABLE(
	[MessageId] [int] NOT NULL,
	[Message] [varchar](max) NOT NULL,
	[Messagetype] [varchar](max) NOT NULL,
	[Reply] [bit] NOT NULL DEFAULT (CONVERT([bit],(0))),
	[RepliedId] [int] NULL,
	[PropertyId] [int] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[PhotoType]    Script Date: 09/06/2022 10:54:23 ******/
CREATE TYPE [dbo].[PhotoType] AS TABLE(
	[PublicId] [varchar](50) NOT NULL,
	[ImageUrl] [varchar](250) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ProfilephotoType]    Script Date: 09/06/2022 10:54:23 ******/
CREATE TYPE [dbo].[ProfilephotoType] AS TABLE(
	[PublicId] [varchar](50) NOT NULL,
	[ImageUrl] [varchar](250) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[PropertyType]    Script Date: 09/06/2022 10:54:23 ******/
CREATE TYPE [dbo].[PropertyType] AS TABLE(
	[PropertyId] [int] NOT NULL,
	[Propertyname] [varchar](50) NOT NULL,
	[Guideprice] [decimal](19, 4) NOT NULL,
	[Propertytype] [varchar](max) NOT NULL,
	[Description] [varchar](max) NULL,
	[Bedrooms] [int] NOT NULL,
	[Bathrooms] [int] NOT NULL,
	[Icons] [varchar](max) NULL,
	[Addressline1] [varchar](30) NOT NULL,
	[Addressline2] [varchar](30) NULL,
	[Addressline3] [varchar](30) NULL,
	[Town] [varchar](20) NULL,
	[City] [varchar](20) NULL,
	[Postcode] [varchar](10) NOT NULL
)
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photo](
	[PhotoId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PublicId] [varchar](50) NOT NULL,
	[ImageURL] [varchar](250) NOT NULL,
	[Thumbnail] [bit] NOT NULL,
	[PropertyId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PhotoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](20) NOT NULL,
	[NormalizedUsername] [varchar](20) NOT NULL,
	[Firstname] [varchar](15) NOT NULL,
	[Lastname] [varchar](15) NOT NULL,
	[Dateofbirth] [varchar](10) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
	[Addressline1] [varchar](30) NOT NULL,
	[Addressline2] [varchar](30) NULL,
	[Addressline3] [varchar](30) NULL,
	[Town] [varchar](20) NULL,
	[City] [varchar](20) NULL,
	[Postcode] [varchar](10) NOT NULL,
	[Accounttype] [varchar](6) NOT NULL,
	[Email] [varchar](30) NOT NULL,
	[NormalizedEmail] [varchar](30) NOT NULL,
	[Phone] [varchar](15) NULL,
	[MarketingEmail] [bit] NOT NULL,
	[MarketingPhone] [bit] NOT NULL,
	[ProfilepictureId] [int] NULL,
 CONSTRAINT [PK__User__1788CC4CDD50FF5F] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Property]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Property](
	[PropertyId] [int] IDENTITY(1,1) NOT NULL,
	[Propertyname] [varchar](50) NOT NULL,
	[Guideprice] [decimal](19, 4) NOT NULL,
	[Propertytype] [varchar](max) NOT NULL,
	[Description] [varchar](max) NULL,
	[Bedrooms] [int] NOT NULL,
	[Bathrooms] [int] NOT NULL,
	[Icons] [varchar](max) NULL,
	[Addressline1] [varchar](30) NOT NULL,
	[Addressline2] [varchar](30) NULL,
	[Addressline3] [varchar](30) NULL,
	[Town] [varchar](20) NULL,
	[City] [varchar](20) NULL,
	[Postcode] [varchar](10) NOT NULL,
	[PublishDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Property] PRIMARY KEY CLUSTERED 
(
	[PropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [aggregate].[Property]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [aggregate].[Property]
AS
	SELECT
		t1.[PropertyId]
		,t1.[Propertyname]
		,t1.[Guideprice]
		,t1.[Propertytype]
		,t1.[Description]
		,t1.[Bedrooms]
		,t1.[Bathrooms]
		,t1.[Icons]
		,t1.[Addressline1]
		,t1.[Addressline2]
		,t1.[Addressline3]
		,t1.[Town]
		,t1.[City]
		,t1.[Postcode]
		,t1.[PublishDate]
		,t1.[UserId]
		,t2.[Username]
		,t3.[PhotoId]
		,t3.[ImageURL]
		,t3.[PublicId]
	FROM
		[dbo].[Property] t1
	INNER JOIN
		[dbo].[User] t2 ON t1.UserId = t2.UserId
	LEFT JOIN
		[dbo].[Photo] t3 ON t1.PropertyId = t3.PropertyId AND t3.Thumbnail = CONVERT(BIT, 1)
GO
/****** Object:  Table [dbo].[Message]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[MessageId] [int] IDENTITY(1,1) NOT NULL,
	[Message] [varchar](max) NOT NULL,
	[Messagetype] [varchar](max) NOT NULL,
	[Datetimesent] [datetime] NOT NULL,
	[Reply] [bit] NOT NULL,
	[RepliedId] [int] NULL,
	[PropertyId] [int] NOT NULL,
	[SenderId] [int] NOT NULL,
	[ReceiverId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profilephoto]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profilephoto](
	[PhotoId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PublicId] [varchar](50) NOT NULL,
	[ImageURL] [varchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PhotoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_User_NormalizedEmail]    Script Date: 09/06/2022 10:54:23 ******/
CREATE NONCLUSTERED INDEX [IX_User_NormalizedEmail] ON [dbo].[User]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_User_NormalizedUsername]    Script Date: 09/06/2022 10:54:23 ******/
CREATE NONCLUSTERED INDEX [IX_User_NormalizedUsername] ON [dbo].[User]
(
	[NormalizedUsername] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Message] ADD  DEFAULT (getdate()) FOR [Datetimesent]
GO
ALTER TABLE [dbo].[Message] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Reply]
GO
ALTER TABLE [dbo].[Photo] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Thumbnail]
GO
ALTER TABLE [dbo].[Property] ADD  DEFAULT (getdate()) FOR [PublishDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__User__MarketingE__24927208]  DEFAULT (CONVERT([bit],(0))) FOR [MarketingEmail]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__User__MarketingP__25869641]  DEFAULT (CONVERT([bit],(0))) FOR [MarketingPhone]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD FOREIGN KEY([ReceiverId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD FOREIGN KEY([SenderId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Property] FOREIGN KEY([PropertyId])
REFERENCES [dbo].[Property] ([PropertyId])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Property]
GO
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD FOREIGN KEY([PropertyId])
REFERENCES [dbo].[Property] ([PropertyId])
GO
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Profilephoto]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Property]  WITH CHECK ADD  CONSTRAINT [FK_Property_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Property] CHECK CONSTRAINT [FK_Property_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Profilephoto] FOREIGN KEY([ProfilepictureId])
REFERENCES [dbo].[Profilephoto] ([PhotoId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Profilephoto]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_User]
GO
/****** Object:  StoredProcedure [dbo].[Account_GetById]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_GetById]
	@UserId INT
AS
	SELECT
		t1.[UserId]
		,t1.[Username]
		,t1.[NormalizedUsername]
		,t1.[Firstname]
		,t1.[Lastname]
		,t1.[Dateofbirth]
		,t1.[PasswordHash]
		,t1.[Addressline1]
		,t1.[Addressline2]
		,t1.[Addressline3]
		,t1.[Town]
		,t1.[City]
		,t1.[Postcode]
		,t1.[Accounttype]
		,t1.[Email]
		,t1.[NormalizedEmail]
		,t1.[Phone]
		,t1.[MarketingEmail]
		,t1.[MarketingPhone]
		,t1.[ProfilepictureId]
	FROM
		[dbo].[User] t1
	WHERE
		t1.[UserId] = @UserId
GO
/****** Object:  StoredProcedure [dbo].[Account_GetByUsername]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_GetByUsername]
	@NormalizedUsername VARCHAR(20)
AS
	SELECT
		t1.[UserId]
		,t1.[Username]
		,t1.[NormalizedUsername]
		,t1.[Firstname]
		,t1.[Lastname]
		,t1.[Dateofbirth]
		,t1.[PasswordHash]
		,t1.[Addressline1]
		,t1.[Addressline2]
		,t1.[Addressline3]
		,t1.[Town]
		,t1.[City]
		,t1.[Postcode]
		,t1.[Accounttype]
		,t1.[Email]
		,t1.[NormalizedEmail]
		,t1.[Phone]
		,t1.[MarketingEmail]
		,t1.[MarketingPhone]
		,t1.[ProfilepictureId]
	FROM
		[dbo].[User] t1
	WHERE
		t1.[NormalizedUsername] = @NormalizedUsername
GO
/****** Object:  StoredProcedure [dbo].[Account_GetUsernameById]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_GetUsernameById]
	@UserId INT
AS
	SELECT
		t1.[Username]
	FROM
		[dbo].[User] t1
	WHERE
		t1.[UserId] = @UserId
GO
/****** Object:  StoredProcedure [dbo].[Account_Insert]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_Insert]
	@Account AccountType READONLY
AS

	INSERT INTO [dbo].[User]
		([Username]
		,[NormalizedUsername]
		,[Firstname]
		,[Lastname]
		,[Dateofbirth]
		,[PasswordHash]
		,[Addressline1]
		,[Addressline2]
		,[Addressline3]
		,[Town]
		,[City]
		,[Postcode]
		,[Accounttype]
		,[Email]
		,[NormalizedEmail]
		,[Phone]
		,[MarketingEmail]
		,[MarketingPhone]
		,[ProfilepictureId])
	SELECT
		[Username]
		,[NormalizedUsername]
		,[Firstname]
		,[Lastname]
		,[Dateofbirth]
		,[PasswordHash]
		,[Addressline1]
		,[Addressline2]
		,[Addressline3]
		,[Town]
		,[City]
		,[Postcode]
		,[Accounttype]
		,[Email]
		,[NormalizedEmail]
		,[Phone]
		,[MarketingEmail]
		,[MarketingPhone]
		,[ProfilepictureId]

	FROM
		@Account

	SELECT CAST(SCOPE_IDENTITY() AS INT);
GO
/****** Object:  StoredProcedure [dbo].[Account_UpdatePicture]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_UpdatePicture]
	@UserId INT,
	@PhotoId INT
AS
	UPDATE [dbo].[User]
		SET
			[ProfilepictureId] = @PhotoId
		WHERE 
			[User].UserId = @UserId
GO
/****** Object:  StoredProcedure [dbo].[Message_Delete]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Message_Delete]
	@MessageId INT
AS
	DELETE FROM [dbo].[Message] WHERE [MessageId] = @MessageId
GO
/****** Object:  StoredProcedure [dbo].[Message_Get]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Message_Get]
	@MessageId INT
AS
	SELECT 
		t1.[MessageId]
		,t1.[Message]
		,t1.[Messagetype]
		,t1.[Datetimesent]
		,t1.[Reply]
		,t1.[RepliedId]
		,t1.[PropertyId]
		,t1.[SenderId]
		,t1.[ReceiverId]
	FROM 
		[dbo].[Message] t1
	WHERE
		t1.[MessageId] = @MessageId
GO
/****** Object:  StoredProcedure [dbo].[Message_GetAllById]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Message_GetAllById]
	@UserId INT
AS
	SELECT 
		t1.[MessageId]
		,t1.[Message]
		,t1.[Messagetype]
		,t1.[Datetimesent]
		,t1.[Reply]
		,t1.[RepliedId]
		,t1.[PropertyId]
		,t1.[SenderId]
		,t1.[ReceiverId]
	FROM 
		[dbo].[Message] t1
	WHERE
		t1.[ReceiverId] = @UserId
GO
/****** Object:  StoredProcedure [dbo].[Message_Insert]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Message_Insert]
	@Message MessageType READONLY,
	@UserId INT,
	@ReceiverId INT
AS
	INSERT INTO [dbo].[Message]
		([Message]
		,[Messagetype]
		,[Reply]
		,[RepliedId]
		,[PropertyId]
		,[SenderId]
		,[ReceiverId])
	SELECT 
		[Message]
		,[Messagetype]
		,[Reply]
		,[RepliedId]
		,[PropertyId]
		,@UserId [SenderId]
		,@ReceiverId [ReceiverId]
	FROM @Message

	SELECT CAST(SCOPE_IDENTITY() AS INT);

GO
/****** Object:  StoredProcedure [dbo].[Message_Update]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Message_Update]
	@MessageId INT,
	@ReplyId INT
AS
	UPDATE [dbo].[Message]
		SET
			[Reply] = CONVERT(BIT, 1),
			[RepliedId] = @ReplyId
		WHERE 
			[Message].MessageId = @MessageId
GO
/****** Object:  StoredProcedure [dbo].[Photo_Delete]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Photo_Delete]
	@PhotoId INT
AS
	DELETE FROM [dbo].[Photo] WHERE [PhotoId] = @PhotoId
GO
/****** Object:  StoredProcedure [dbo].[Photo_Get]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Photo_Get]
	@PhotoId INT
AS
	SELECT 
		t1.[PhotoId]
		,t1.[UserId]
		,t1.[PublicId]
		,t1.[ImageURL]
		,t1.[Thumbnail]
		,t1.[PropertyId]
	FROM 
		[dbo].[Photo] t1
	WHERE 
		t1.[PhotoId] = @PhotoId

	
GO
/****** Object:  StoredProcedure [dbo].[Photo_GetByPropertyId]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Photo_GetByPropertyId]
	@PropertyId INT
AS
	SELECT 
		t1.[PhotoId]
		,t1.[UserId]
		,t1.[PublicId]
		,t1.[ImageURL]
		,t1.[Thumbnail]
		,t1.[PropertyId]
	FROM 
		[dbo].[Photo] t1
	WHERE 
		t1.[PropertyId] = @PropertyId
GO
/****** Object:  StoredProcedure [dbo].[Photo_Insert]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Photo_Insert]
	@Photo PhotoType READONLY,
	@UserId INT,
	@PropertyId INT,
	@Thumbnail BIT
AS
	INSERT INTO [dbo].[Photo]
		([UserId]
		,[PublicId]
		,[ImageUrl]
		,[Thumbnail]
		,[PropertyId])
	SELECT
		@UserId [UserId],
		[PublicId],
		[ImageUrl],
		@Thumbnail [Thumbnail],
		@PropertyId [PropertyId]
	FROM
		@Photo

	SELECT CAST(SCOPE_IDENTITY() AS INT);
GO
/****** Object:  StoredProcedure [dbo].[Profilephoto_Delete]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Profilephoto_Delete]
	@PhotoId INT
AS
	DELETE FROM [dbo].[Profilephoto] WHERE [PhotoId] = @PhotoId
GO
/****** Object:  StoredProcedure [dbo].[Profilephoto_Get]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Profilephoto_Get]
	@PhotoId INT
AS
	SELECT 
		t1.[PhotoId]
		,t1.[UserId]
		,t1.[PublicId]
		,t1.[ImageURL]
	FROM 
		[dbo].[Profilephoto] t1
	WHERE 
		t1.[PhotoId] = @PhotoId
GO
/****** Object:  StoredProcedure [dbo].[Profilephoto_GetById]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Profilephoto_GetById]
	@UserId INT
AS
	SELECT 
		t1.[PhotoId]
		,t1.[UserId]
		,t1.[PublicId]
		,t1.[ImageURL]
	FROM 
		[dbo].[Profilephoto] t1
	WHERE 
		t1.[UserId] = @UserId
GO
/****** Object:  StoredProcedure [dbo].[Profilephoto_Insert]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Profilephoto_Insert]
	@Profilephoto ProfilephotoType READONLY,
	@UserId INT
AS
	INSERT INTO [dbo].[Profilephoto]
		([UserId]
		,[PublicId]
		,[ImageUrl])
	SELECT
		@UserId [UserId],
		[PublicId],
		[ImageUrl]
	FROM
		@Profilephoto

	SELECT CAST(SCOPE_IDENTITY() AS INT);
GO
/****** Object:  StoredProcedure [dbo].[Property_Delete]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Property_Delete]
	@PropertyId INT
AS
	DELETE FROM [dbo].[Property] WHERE [PropertyId] = @PropertyId
GO
/****** Object:  StoredProcedure [dbo].[Property_Get]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Property_Get]
	@PropertyId INT
AS
	SELECT 
		[PropertyId]
		,[Propertyname]
		,[Guideprice]
		,[Propertytype]
		,[Description]
		,[Bedrooms]
		,[Bathrooms]
		,[Icons]
		,[Addressline1]
		,[Addressline2]
		,[Addressline3]
		,[Town]
		,[City]
		,[Postcode]
		,[PublishDate]
		,[UserId]
		,[Username]
		,[PhotoId]
		,[ImageUrl]
		,[PublicId]
	FROM 
		[aggregate].[Property] t1
	WHERE
		t1.[PropertyId] = @PropertyId
GO
/****** Object:  StoredProcedure [dbo].[Property_GetAllById]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Property_GetAllById]
	@UserId INT
AS
	SELECT 
		[PropertyId]
		,[Propertyname]
		,[Guideprice]
		,[Propertytype]
		,[Description]
		,[Bedrooms]
		,[Bathrooms]
		,[Icons]
		,[Addressline1]
		,[Addressline2]
		,[Addressline3]
		,[Town]
		,[City]
		,[Postcode]
		,[PublishDate]
		,[UserId]
		,[Username]
		,[PhotoId]
		,[ImageUrl]
		,[PublicId]
	FROM 
		[aggregate].[Property] t1
	WHERE
		t1.[UserId] = @UserId
GO
/****** Object:  StoredProcedure [dbo].[Property_Insert]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Property_Insert]
	@Property PropertyType READONLY,
	@UserId INT
AS
	INSERT INTO [dbo].[Property]
		([Propertyname]
		,[Guideprice]
		,[Propertytype]
		,[Description]
		,[Bedrooms]
		,[Bathrooms]
		,[Icons]
		,[Addressline1]
		,[Addressline2]
		,[Addressline3]
		,[Town]
		,[City]
		,[Postcode]
		,[UserId])
	SELECT 
		[Propertyname]
		,[Guideprice]
		,[Propertytype]
		,[Description]
		,[Bedrooms]
		,[Bathrooms]
		,[Icons]
		,[Addressline1]
		,[Addressline2]
		,[Addressline3]
		,[Town]
		,[City]
		,[Postcode]
		,@UserId [UserId]
	FROM 
		@Property
		
	SELECT CAST(SCOPE_IDENTITY() AS INT);
GO
/****** Object:  StoredProcedure [dbo].[Property_Search]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Property_Search]
	@Location VARCHAR(150) NULL,
	@PropertyType VARCHAR(30) NULL,
	@Keywords VARCHAR(150) NULL,
	@MinPrice INT NULL,
	@MaxPrice INT NULL,
	@MinBeds INT NULL,
	@MaxBeds INT NULL
AS

	SELECT * FROM Property 

	WHERE  PropertyType = 
	(CASE
		WHEN @PropertyType IS NULL THEN PropertyType
		WHEN @PropertyType IS NOT NULL THEN @PropertyType
	END)
	AND
	GuidePrice >= @MinPrice AND GuidePrice <= @MaxPrice
	AND
	Bedrooms >= @MinBeds AND Bedrooms <= @MaxBeds
	AND
	[Description] LIKE 
	(CASE
		WHEN @Keywords IS NULL THEN [Description]
		WHEN @Keywords IS NOT NULL THEN '%'+@Keywords+'%'
	END)
	AND
	((Propertyname LIKE CASE
		WHEN @Location IS NULL THEN Propertyname
		WHEN @Location IS NOT NULL THEN '%'+@Location+'%'
	END)
	OR
	City LIKE (CASE
		WHEN @Location IS NULL THEN City
		WHEN @Location IS NOT NULL THEN '%'+@Location+'%'
	END)
	OR
	Town LIKE (CASE
		WHEN @Location IS NULL THEN Town
		WHEN @Location IS NOT NULL THEN '%'+@Location+'%'
	END)
	OR
	Postcode LIKE (CASE
		WHEN @Location IS NULL THEN Postcode
		WHEN @Location IS NOT NULL THEN '%'+@Location+'%'
	END))

	
GO
/****** Object:  StoredProcedure [dbo].[Property_Update]    Script Date: 09/06/2022 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Property_Update]
	@Property PropertyType READONLY,
	@PropertyId INT,
	@UserId INT
AS
	UPDATE [dbo].[Property]
		SET
			[Propertyname] = t1.[Propertyname]
			,[Guideprice] = t1.[Guideprice]
			,[Propertytype] = t1.Propertytype
			,[Description] = t1.[Description]
			,[Bedrooms] = t1.[Bedrooms]
			,[Bathrooms] = t1.[Bathrooms]
			,[Icons] = t1.[Icons]
			,[Addressline1] = t1.[Addressline1]
			,[Addressline2] = t1.[Addressline2]
			,[Addressline3] = t1.[Addressline3]
			,[Town] = t1.[Town]
			,[City] = t1.[City]
			,[Postcode] = t1.[Postcode]
			,[UserId] = @UserId
		FROM
			@Property t1
		WHERE 
			Property.PropertyId = @PropertyId
GO
USE [master]
GO
ALTER DATABASE [HomeView] SET  READ_WRITE 
GO
