USE [master]
GO

/****** Object:  Database [LiveMessageTracking]    Script Date: 7/13/2016 10:46:38 AM ******/
DROP DATABASE [LiveMessageTracking]
GO

/****** Object:  Database [LiveMessageTracking]    Script Date: 7/13/2016 10:46:38 AM ******/
CREATE DATABASE [LiveMessageTracking] ON  PRIMARY 
( NAME = N'LiveMessageTracking', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\LiveMessageTracking.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LiveMessageTracking_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\LiveMessageTracking_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [LiveMessageTracking] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LiveMessageTracking].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [LiveMessageTracking] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET ARITHABORT OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [LiveMessageTracking] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [LiveMessageTracking] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET  ENABLE_BROKER 
GO

ALTER DATABASE [LiveMessageTracking] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [LiveMessageTracking] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET RECOVERY FULL 
GO

ALTER DATABASE [LiveMessageTracking] SET  MULTI_USER 
GO

ALTER DATABASE [LiveMessageTracking] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [LiveMessageTracking] SET DB_CHAINING OFF 
GO

ALTER DATABASE [LiveMessageTracking] SET  READ_WRITE 
GO


ALTER DATABASE LiveMessageTracking SET ENABLE_BROKER


USE [LiveMessageTracking]
GO

/****** Object:  Table [dbo].[DemandTrackingMessages]    Script Date: 7/14/2016 8:06:21 AM ******/
DROP TABLE [dbo].[DemandTrackingMessages]
GO

/****** Object:  Table [dbo].[DemandTrackingMessages]    Script Date: 7/14/2016 8:06:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DemandTracking_Messages](
	[MessageId] [int] IDENTITY(1,1) NOT NULL,
	[MessageDate] [datetime] NOT NULL,
	[MessageSource] [nchar](10) NOT NULL,
	[MessageStatus] [nchar](255) NOT NULL,
	[MessageDetails] [nvarchar](max) NULL,
	[MessageIsError] [bit] NOT NULL,
	[ServiceID] [nvarchar](128) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [dbo].[DemandTracking_Services](
	[ServiceID] [nvarchar](128) NOT NULL,
	[ServiceName] [nchar](20) NOT NULL,
	[ServiceSource] [nchar](10) NOT NULL,
	[ServiceStateID] [nvarchar](128) NOT NULL,
	[ServiceLastStartedDate] [datetime] NOT NULL,
	[ServiceLastStoppedDate] [datetime] NOT NULL,
	[ServiceTypeID] [nvarchar](128) NOT NULL,
) ON [PRIMARY]


GO

CREATE TABLE [dbo].[DemandTracking_ServiceTypes](
	[ServiceTypeID] [nvarchar](128) NOT NULL,
	[ServiceTypeName] [nchar](10) NOT NULL,
 CONSTRAINT [PK_DemandTracking_ServiceTypes] PRIMARY KEY CLUSTERED 
(
	[ServiceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO [dbo].[DemandTracking_ServiceTypes] ([ServiceTypeID] ,[ServiceTypeName]) VALUES ('78c7be2c-cbaf-4598-afa9-4a01b4cd37c1' ,'Server IP Check')
INSERT INTO [dbo].[DemandTracking_ServiceTypes] ([ServiceTypeID] ,[ServiceTypeName]) VALUES ('52d41310-82ad-4b30-9896-32f93328ebcd' ,'SCADA Meters 1')
INSERT INTO [dbo].[DemandTracking_ServiceTypes] ([ServiceTypeID] ,[ServiceTypeName]) VALUES ('bb8f78ad-16c4-4403-8cea-e4b674988b8d' ,'SCADA Meters 2')
INSERT INTO [dbo].[DemandTracking_ServiceTypes] ([ServiceTypeID] ,[ServiceTypeName]) VALUES ('79d54ef2-2780-4ff2-98a7-be0f69659b86' ,'SCADA Meters 3')
INSERT INTO [dbo].[DemandTracking_ServiceTypes] ([ServiceTypeID] ,[ServiceTypeName]) VALUES ('7fd1e481-2441-4c9c-8fb0-66bdb0a07dc8' ,'SCADA Meters 4')
GO


CREATE TABLE [dbo].[DemandTracking_ServiceStates](
	[ServiceStateID] [nvarchar](128) NOT NULL,
	[ServiceStateName] [nchar](10) NOT NULL
) ON [PRIMARY]

GO
INSERT [dbo].[DemandTracking_ServiceState] ([ServiceStateID], [ServiceStateName]) VALUES (N'b1a9b575-c70d-4f34-bf28-37aa62712d8a', N'Stopped')
INSERT [dbo].[DemandTracking_ServiceState] ([ServiceStateID], [ServiceStateName]) VALUES (N'dfc654f4-9880-498a-a43b-ca89ff703393', N'Started')
INSERT [dbo].[DemandTracking_ServiceState] ([ServiceStateID], [ServiceStateName]) VALUES (N'0477539a-5dae-4fe6-9f91-1ea345954be2', N'Waiting')
INSERT [dbo].[DemandTracking_ServiceState] ([ServiceStateID], [ServiceStateName]) VALUES (N'4939493a-5eds-4fe6-9f91-1ea345954be1', N'Manual')

GO

