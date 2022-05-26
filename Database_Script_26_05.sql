USE [master]
GO
/****** Object:  Database [HomeView]    Script Date: 26/05/2022 20:53:02 ******/
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
/****** Object:  Schema [aggregate]    Script Date: 26/05/2022 20:53:02 ******/
CREATE SCHEMA [aggregate]
GO
/****** Object:  UserDefinedTableType [dbo].[AccountType]    Script Date: 26/05/2022 20:53:02 ******/
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
/****** Object:  UserDefinedTableType [dbo].[PhotoType]    Script Date: 26/05/2022 20:53:02 ******/
CREATE TYPE [dbo].[PhotoType] AS TABLE(
	[PublicId] [varchar](50) NOT NULL,
	[ImageUrl] [varchar](250) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[PropertyType]    Script Date: 26/05/2022 20:53:02 ******/
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
	[Postcode] [varchar](10) NOT NULL,
	[Photo1Id] [int] NULL,
	[Photo2Id] [int] NULL,
	[Photo3Id] [int] NULL,
	[Photo4Id] [int] NULL,
	[Photo5Id] [int] NULL
)
GO
/****** Object:  Table [dbo].[Property]    Script Date: 26/05/2022 20:53:02 ******/
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
	[Photo1Id] [int] NULL,
	[Photo2Id] [int] NULL,
	[Photo3Id] [int] NULL,
	[Photo4Id] [int] NULL,
	[Photo5Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 26/05/2022 20:53:02 ******/
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
/****** Object:  View [aggregate].[Property]    Script Date: 26/05/2022 20:53:02 ******/
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
		,t1.[Photo1Id]
		,t1.[Photo2Id]
		,t1.[Photo3Id]
		,t1.[Photo4Id]
		,t1.[Photo5Id]
	FROM
		[dbo].[Property] t1
	INNER JOIN
		[dbo].[User] t2 ON t1.UserId = t2.UserId
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 26/05/2022 20:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photo](
	[PhotoId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PublicId] [varchar](50) NOT NULL,
	[ImageURL] [varchar](250) NOT NULL,
 CONSTRAINT [PK__Photo__21B7B5E227AA6909] PRIMARY KEY CLUSTERED 
(
	[PhotoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_User_NormalizedEmail]    Script Date: 26/05/2022 20:53:02 ******/
CREATE NONCLUSTERED INDEX [IX_User_NormalizedEmail] ON [dbo].[User]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_User_NormalizedUsername]    Script Date: 26/05/2022 20:53:02 ******/
CREATE NONCLUSTERED INDEX [IX_User_NormalizedUsername] ON [dbo].[User]
(
	[NormalizedUsername] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Property] ADD  DEFAULT (getdate()) FOR [PublishDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__User__MarketingE__24927208]  DEFAULT (CONVERT([bit],(0))) FOR [MarketingEmail]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__User__MarketingP__25869641]  DEFAULT (CONVERT([bit],(0))) FOR [MarketingPhone]
GO
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD  CONSTRAINT [FK__Photo__UserId__34C8D9D1] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Photo] CHECK CONSTRAINT [FK__Photo__UserId__34C8D9D1]
GO
ALTER TABLE [dbo].[Property]  WITH CHECK ADD  CONSTRAINT [FK__Property__UserId__31EC6D26] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Property] CHECK CONSTRAINT [FK__Property__UserId__31EC6D26]
GO
ALTER TABLE [dbo].[Property]  WITH CHECK ADD  CONSTRAINT [FK_Property_Photo1] FOREIGN KEY([Photo1Id])
REFERENCES [dbo].[Photo] ([PhotoId])
GO
ALTER TABLE [dbo].[Property] CHECK CONSTRAINT [FK_Property_Photo1]
GO
ALTER TABLE [dbo].[Property]  WITH CHECK ADD  CONSTRAINT [FK_Property_Photo5] FOREIGN KEY([Photo5Id])
REFERENCES [dbo].[Photo] ([PhotoId])
GO
ALTER TABLE [dbo].[Property] CHECK CONSTRAINT [FK_Property_Photo5]
GO
ALTER TABLE [dbo].[Property]  WITH CHECK ADD  CONSTRAINT [FK_Property_Property2] FOREIGN KEY([Photo2Id])
REFERENCES [dbo].[Photo] ([PhotoId])
GO
ALTER TABLE [dbo].[Property] CHECK CONSTRAINT [FK_Property_Property2]
GO
ALTER TABLE [dbo].[Property]  WITH CHECK ADD  CONSTRAINT [FK_Property_Property3] FOREIGN KEY([Photo3Id])
REFERENCES [dbo].[Photo] ([PhotoId])
GO
ALTER TABLE [dbo].[Property] CHECK CONSTRAINT [FK_Property_Property3]
GO
ALTER TABLE [dbo].[Property]  WITH CHECK ADD  CONSTRAINT [FK_Property_Property4] FOREIGN KEY([Photo4Id])
REFERENCES [dbo].[Photo] ([PhotoId])
GO
ALTER TABLE [dbo].[Property] CHECK CONSTRAINT [FK_Property_Property4]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Photo] FOREIGN KEY([ProfilepictureId])
REFERENCES [dbo].[Photo] ([PhotoId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Photo]
GO
/****** Object:  StoredProcedure [dbo].[Account_GetByUsername]    Script Date: 26/05/2022 20:53:02 ******/
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
/****** Object:  StoredProcedure [dbo].[Account_Insert]    Script Date: 26/05/2022 20:53:02 ******/
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
/****** Object:  StoredProcedure [dbo].[Photo_Get]    Script Date: 26/05/2022 20:53:02 ******/
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
	FROM 
		[dbo].[Photo] t1
	WHERE 
		t1.[PhotoId] = @PhotoId

	
GO
/****** Object:  StoredProcedure [dbo].[Photo_Insert]    Script Date: 26/05/2022 20:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Photo_Insert]
	@Photo PhotoType READONLY,
	@UserId INT
AS
	INSERT INTO [dbo].[Photo]
		([UserId]
		,[PublicId]
		,[ImageUrl])
	SELECT
		@UserId,
		[PublicId],
		[ImageUrl]
	FROM
		@Photo

	SELECT CAST(SCOPE_IDENTITY() AS INT);
GO
/****** Object:  StoredProcedure [dbo].[Property_Get]    Script Date: 26/05/2022 20:53:02 ******/
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
		,[Photo1Id]
		,[Photo2Id]
		,[Photo3Id]
		,[Photo4Id]
		,[Photo5Id]
	FROM 
		[aggregate].[Property] t1
	WHERE
		t1.[PropertyId] = @PropertyId

GO
/****** Object:  StoredProcedure [dbo].[Property_Insert]    Script Date: 26/05/2022 20:53:02 ******/
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
		,[UserId]
		,[Photo1Id]
		,[Photo2Id]
		,[Photo3Id]
		,[Photo4Id]
		,[Photo5Id])
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
		,[Photo1Id]
		,[Photo2Id]
		,[Photo3Id]
		,[Photo4Id]
		,[Photo5Id]
	FROM 
		@Property
		
	SELECT CAST(SCOPE_IDENTITY() AS INT);

GO
USE [master]
GO
ALTER DATABASE [HomeView] SET  READ_WRITE 
GO
