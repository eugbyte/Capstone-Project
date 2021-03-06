USE [master]
GO
/****** Object:  Database [AD_Project]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE DATABASE [AD_Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AD_Project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AD_Project.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AD_Project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AD_Project_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AD_Project] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AD_Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AD_Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AD_Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AD_Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AD_Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AD_Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [AD_Project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AD_Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AD_Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AD_Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AD_Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AD_Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AD_Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AD_Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AD_Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AD_Project] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AD_Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AD_Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AD_Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AD_Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AD_Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AD_Project] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [AD_Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AD_Project] SET RECOVERY FULL 
GO
ALTER DATABASE [AD_Project] SET  MULTI_USER 
GO
ALTER DATABASE [AD_Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AD_Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AD_Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AD_Project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AD_Project] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'AD_Project', N'ON'
GO
ALTER DATABASE [AD_Project] SET QUERY_STORE = OFF
GO
USE [AD_Project]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdjustmentDetails]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdjustmentDetails](
	[AdjustmentVoucherId] [int] NOT NULL,
	[ItemCatalogueId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Cost] [float] NOT NULL,
	[Reason] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AdjustmentDetails] PRIMARY KEY CLUSTERED 
(
	[AdjustmentVoucherId] ASC,
	[ItemCatalogueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdjustmentStatus]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdjustmentStatus](
	[AdjustmentStatusId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AdjustmentStatus] PRIMARY KEY CLUSTERED 
(
	[AdjustmentStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdjustmentVouchers]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdjustmentVouchers](
	[AdjustmentVoucherId] [int] IDENTITY(1,1) NOT NULL,
	[RaiseDate] [datetime] NULL,
	[ApproveDate] [datetime] NULL,
	[AdjustmentStatusId] [int] NOT NULL,
	[AdjustmentDetailId] [int] NOT NULL,
	[ApprovedByEmployee_EmployeeId] [int] NULL,
	[RaisedByEmployee_EmployeeId] [int] NULL,
 CONSTRAINT [PK_dbo.AdjustmentVouchers] PRIMARY KEY CLUSTERED 
(
	[AdjustmentVoucherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssignRoles]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssignRoles](
	[TempRoleId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[AssignedBy_EmployeeId] [int] NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_dbo.AssignRoles] PRIMARY KEY CLUSTERED 
(
	[TempRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CollectionPoints]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CollectionPoints](
	[CollectionPointId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Location] [nvarchar](max) NULL,
	[CollectionTime] [datetime] NULL,
 CONSTRAINT [PK_dbo.CollectionPoints] PRIMARY KEY CLUSTERED 
(
	[CollectionPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[DepName] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Departments] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DisbursementDetails]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DisbursementDetails](
	[DisbursementDetailId] [int] IDENTITY(1,1) NOT NULL,
	[DisbursementId] [int] NOT NULL,
	[ItemCatalogueId] [int] NOT NULL,
	[DisburseQuantity] [int] NOT NULL,
	[DisbursementStatusId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.DisbursementDetails] PRIMARY KEY CLUSTERED 
(
	[DisbursementDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Disbursements]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Disbursements](
	[DisbursementId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[CollectionPointId] [int] NOT NULL,
	[RequestId] [int] NOT NULL,
	[DisburseDate] [datetime] NULL,
	[Employee_EmployeeId] [int] NULL,
 CONSTRAINT [PK_dbo.Disbursements] PRIMARY KEY CLUSTERED 
(
	[DisbursementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DisbursementStatus]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DisbursementStatus](
	[DisbursementStatusId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.DisbursementStatus] PRIMARY KEY CLUSTERED 
(
	[DisbursementStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[EmpPhone] [nvarchar](max) NULL,
	[EmpFax] [nvarchar](max) NULL,
	[Username] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
	[EmpEmail] [nvarchar](max) NULL,
	[RoleId] [int] NOT NULL,
	[DepartmentId] [int] NULL,
	[AssignRole_AssignRoleId] [int] NULL,
 CONSTRAINT [PK_dbo.Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemCatalogues]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemCatalogues](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[ItemDes] [nvarchar](max) NULL,
	[UnitOfMeasure] [nvarchar](max) NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.ItemCatalogues] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[OrderQuantity] [int] NOT NULL,
	[ExpDelDate] [datetime] NULL,
	[ActDelDate] [datetime] NULL,
	[ReceiveQuantity] [int] NOT NULL,
	[ItemCatalogue_ItemCatalogueId] [int] NULL,
 CONSTRAINT [PK_dbo.OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[SupplierId] [int] NOT NULL,
	[EmpId] [int] NOT NULL,
	[OrderDate] [datetime] NULL,
	[Employee_EmployeeId] [int] NULL,
	[OrderStatus_OrderStatusId] [int] NULL,
 CONSTRAINT [PK_dbo.Orders] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[OrderStatusId] [int] IDENTITY(1,1) NOT NULL,
	[OrderDes] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.OrderStatus] PRIMARY KEY CLUSTERED 
(
	[OrderStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequestDetails]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestDetails](
	[RequestDetailId] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [int] NOT NULL,
	[ItemCatalogueId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_dbo.RequestDetails] PRIMARY KEY CLUSTERED 
(
	[RequestDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Requests]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requests](
	[RequestId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[ApprByDate] [datetime] NULL,
	[RequestStatusId] [int] NOT NULL,
	[RequestComment] [nvarchar](max) NULL,
	[DepHeadComment] [nvarchar](max) NULL,
	[RequestDate] [datetime] NULL,
	[ApprByEmp_EmployeeId] [int] NULL,
	[CollectionPoint_CollectionPointId] [int] NULL,
	[RaisedByEmployee_EmployeeId] [int] NULL,
	[Disbursement_DisbursementId] [int] NULL,
 CONSTRAINT [PK_dbo.Requests] PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequestStatus]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestStatus](
	[RequestStatusId] [int] IDENTITY(1,1) NOT NULL,
	[RequestStatusDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.RequestStatus] PRIMARY KEY CLUSTERED 
(
	[RequestStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockCards]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockCards](
	[StockCardId] [int] IDENTITY(1,1) NOT NULL,
	[ItemCatalogueId] [int] NOT NULL,
	[ChangeDate] [datetime] NULL,
	[ChangeDescription] [nvarchar](max) NULL,
	[ChangeQuantity] [int] NOT NULL,
	[StockInfo_StockInfoId] [int] NULL,
 CONSTRAINT [PK_dbo.StockCards] PRIMARY KEY CLUSTERED 
(
	[StockCardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockInfoes]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockInfoes](
	[StockInfoId] [int] NOT NULL,
	[ItemCatalogueId] [int] NOT NULL,
	[ItemLocation] [nvarchar](max) NULL,
	[ReOrderLevel] [int] NOT NULL,
	[ReOrderQuantity] [int] NOT NULL,
	[StockQuantity] [int] NOT NULL,
 CONSTRAINT [PK_dbo.StockInfoes] PRIMARY KEY CLUSTERED 
(
	[StockInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SupplierCatalogues]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupplierCatalogues](
	[SupplierId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemPrice] [float] NOT NULL,
	[SupplierRank] [int] NOT NULL,
	[ItemCatalogue_ItemCatalogueId] [int] NULL,
 CONSTRAINT [PK_dbo.SupplierCatalogues] PRIMARY KEY CLUSTERED 
(
	[SupplierId] ASC,
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 2/13/2020 11:26:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierId] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [nvarchar](max) NULL,
	[SupplierContact] [nvarchar](max) NULL,
	[SupplierPhone] [nvarchar](max) NULL,
	[SupplierFax] [nvarchar](max) NULL,
	[SupplierAddress] [nvarchar](max) NULL,
	[SupplierEmail] [nvarchar](max) NULL,
	[SupplierGST] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (25, 1, -12, -24, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (25, 2, -3, -9, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (26, 1, -3, -6, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (26, 2, -1, -3, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (26, 4, -5, -12.5, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (27, 1, -3, -6, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (27, 5, -3, -7.5, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (28, 1, -9, -18, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (28, 2, -12, -36, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (29, 1, -30, -60, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (30, 1, 12, 24, N'assdg')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (30, 8, 12, 11, N'e')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (31, 1, 12, 24, N'Missing')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (32, 1, -23, -46, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (32, 4, -10, -25, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (33, 1, -10, -20, N'Missing from store')
INSERT [dbo].[AdjustmentDetails] ([AdjustmentVoucherId], [ItemCatalogueId], [Quantity], [Cost], [Reason]) VALUES (34, 1, -3, -6, N'Missing from store')
SET IDENTITY_INSERT [dbo].[AdjustmentStatus] ON 

INSERT [dbo].[AdjustmentStatus] ([AdjustmentStatusId], [Description]) VALUES (1, N'PENDING')
INSERT [dbo].[AdjustmentStatus] ([AdjustmentStatusId], [Description]) VALUES (2, N'APPROVED_MINOR')
INSERT [dbo].[AdjustmentStatus] ([AdjustmentStatusId], [Description]) VALUES (3, N'APPROVED_MAJOR')
INSERT [dbo].[AdjustmentStatus] ([AdjustmentStatusId], [Description]) VALUES (4, N'SUBMITTED')
SET IDENTITY_INSERT [dbo].[AdjustmentStatus] OFF
SET IDENTITY_INSERT [dbo].[AdjustmentVouchers] ON 

INSERT [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId], [RaiseDate], [ApproveDate], [AdjustmentStatusId], [AdjustmentDetailId], [ApprovedByEmployee_EmployeeId], [RaisedByEmployee_EmployeeId]) VALUES (25, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 4, 0, NULL, 15)
INSERT [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId], [RaiseDate], [ApproveDate], [AdjustmentStatusId], [AdjustmentDetailId], [ApprovedByEmployee_EmployeeId], [RaisedByEmployee_EmployeeId]) VALUES (26, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 4, 0, NULL, 15)
INSERT [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId], [RaiseDate], [ApproveDate], [AdjustmentStatusId], [AdjustmentDetailId], [ApprovedByEmployee_EmployeeId], [RaisedByEmployee_EmployeeId]) VALUES (27, NULL, NULL, 1, 0, NULL, 15)
INSERT [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId], [RaiseDate], [ApproveDate], [AdjustmentStatusId], [AdjustmentDetailId], [ApprovedByEmployee_EmployeeId], [RaisedByEmployee_EmployeeId]) VALUES (28, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 4, 0, NULL, 15)
INSERT [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId], [RaiseDate], [ApproveDate], [AdjustmentStatusId], [AdjustmentDetailId], [ApprovedByEmployee_EmployeeId], [RaisedByEmployee_EmployeeId]) VALUES (29, NULL, NULL, 1, 0, NULL, 15)
INSERT [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId], [RaiseDate], [ApproveDate], [AdjustmentStatusId], [AdjustmentDetailId], [ApprovedByEmployee_EmployeeId], [RaisedByEmployee_EmployeeId]) VALUES (30, CAST(N'2020-02-13T19:56:59.333' AS DateTime), CAST(N'2020-02-13T19:56:59.333' AS DateTime), 1, 0, NULL, NULL)
INSERT [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId], [RaiseDate], [ApproveDate], [AdjustmentStatusId], [AdjustmentDetailId], [ApprovedByEmployee_EmployeeId], [RaisedByEmployee_EmployeeId]) VALUES (31, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T19:59:32.253' AS DateTime), 4, 0, NULL, NULL)
INSERT [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId], [RaiseDate], [ApproveDate], [AdjustmentStatusId], [AdjustmentDetailId], [ApprovedByEmployee_EmployeeId], [RaisedByEmployee_EmployeeId]) VALUES (32, NULL, NULL, 1, 0, NULL, 15)
INSERT [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId], [RaiseDate], [ApproveDate], [AdjustmentStatusId], [AdjustmentDetailId], [ApprovedByEmployee_EmployeeId], [RaisedByEmployee_EmployeeId]) VALUES (33, NULL, NULL, 1, 0, NULL, 15)
INSERT [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId], [RaiseDate], [ApproveDate], [AdjustmentStatusId], [AdjustmentDetailId], [ApprovedByEmployee_EmployeeId], [RaisedByEmployee_EmployeeId]) VALUES (34, NULL, NULL, 1, 0, NULL, 15)
SET IDENTITY_INSERT [dbo].[AdjustmentVouchers] OFF
SET IDENTITY_INSERT [dbo].[AssignRoles] ON 

INSERT [dbo].[AssignRoles] ([TempRoleId], [EmployeeId], [StartDate], [EndDate], [AssignedBy_EmployeeId], [RoleId]) VALUES (1, 7, CAST(N'2020-02-01T00:00:00.000' AS DateTime), CAST(N'2020-02-05T00:00:00.000' AS DateTime), 5, NULL)
SET IDENTITY_INSERT [dbo].[AssignRoles] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (1, N'CLIP')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (2, N'ENVELOPE')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (3, N'ERASER')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (4, N'EXERCISE')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (5, N'FILE')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (6, N'PEN')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (7, N'PUNCHER')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (8, N'PAD')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (9, N'PAPER')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (10, N'RULER')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (11, N'SCISSORS')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (12, N'TAPE')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (13, N'SHARPENER')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (14, N'SHORTHAND')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (15, N'STAPLER')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (16, N'TACKS')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (17, N'TPARENCY')
INSERT [dbo].[Categories] ([CategoryId], [CategoryDescription]) VALUES (18, N'TRAY')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[CollectionPoints] ON 

INSERT [dbo].[CollectionPoints] ([CollectionPointId], [EmployeeId], [Location], [CollectionTime]) VALUES (1, 15, N'STATIONERY STORE - ADMINISTRATION BUILDING', CAST(N'2020-01-22T09:30:00.000' AS DateTime))
INSERT [dbo].[CollectionPoints] ([CollectionPointId], [EmployeeId], [Location], [CollectionTime]) VALUES (2, 15, N'MANAGEMENT SCHOOL', CAST(N'2020-01-22T11:00:00.000' AS DateTime))
INSERT [dbo].[CollectionPoints] ([CollectionPointId], [EmployeeId], [Location], [CollectionTime]) VALUES (3, 16, N'MEDICAL SCHOOL', CAST(N'2020-01-22T09:30:00.000' AS DateTime))
INSERT [dbo].[CollectionPoints] ([CollectionPointId], [EmployeeId], [Location], [CollectionTime]) VALUES (4, 16, N'ENGINEERING SCHOOL', CAST(N'2020-01-22T11:00:00.000' AS DateTime))
INSERT [dbo].[CollectionPoints] ([CollectionPointId], [EmployeeId], [Location], [CollectionTime]) VALUES (5, 17, N'SCIENCE SCHOOL', CAST(N'2020-01-22T09:30:00.000' AS DateTime))
INSERT [dbo].[CollectionPoints] ([CollectionPointId], [EmployeeId], [Location], [CollectionTime]) VALUES (6, 17, N'UNIVERSITY HOSPITAL', CAST(N'2020-01-22T11:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[CollectionPoints] OFF
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (1, N'English Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (2, N'Computer Science')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (3, N'Commerce Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (4, N'Registrar Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (5, N'Zoology Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (6, N'Stationery Inventory')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (12, N'English Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (14, N'English Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (16, N'English Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (18, N'English Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (20, N'English Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (21, N'English Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (22, N'English Dept')
INSERT [dbo].[Departments] ([DepartmentId], [DepName]) VALUES (23, N'English Dept')
SET IDENTITY_INSERT [dbo].[Departments] OFF
SET IDENTITY_INSERT [dbo].[DisbursementDetails] ON 

INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (3, 2, 1, 16, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (15, 14, 10, 7, 1)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (17, 16, 8, 5, 1)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (18, 17, 7, 7, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1025, 1027, 1, 7, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1026, 1028, 1, 12, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1027, 1029, 17, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1028, 1030, 17, 123, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1029, 1031, 17, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1030, 1032, 15, 100, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1031, 1033, 2, 100, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1032, 1034, 10, 5, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1033, 1035, 7, 12, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1034, 1036, 9, 7, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1035, 1037, 38, 7, 1)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1036, 1038, 7, 123, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1037, 1039, 1, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1038, 1040, 7, 120, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1039, 1041, 1, 12, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1040, 1042, 1, 13, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1041, 1043, 1, 9, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1042, 1044, 1, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1043, 1045, 1, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1044, 1046, 1, 8, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1045, 1047, 1, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1046, 1048, 1, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1047, 1049, 1, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1048, 1050, 1, 8, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1049, 1051, 1, 12, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1050, 1052, 7, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1051, 1053, 1, 12, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1052, 1054, 1, 38, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1053, 1055, 7, 12, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1054, 1056, 1, 5, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1055, 1057, 1, 40, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1056, 1058, 7, 12, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1057, 1059, 1, 5, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1058, 1060, 1, 30, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1059, 1061, 7, 20, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1060, 1062, 1, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1061, 1063, 1, 35, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1062, 1064, 7, 20, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1063, 1065, 1, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1064, 1066, 1, 35, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1065, 1067, 7, 20, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1066, 1068, 1, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1067, 1069, 1, 35, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1068, 1070, 1, 15, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1069, 1071, 15, 13, 2)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1070, 1072, 2, 12, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1071, 1073, 7, 20, 2)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1072, 1074, 1, 10, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1073, 1075, 15, 2, 3)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1074, 1076, 7, 123, 2)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1075, 1077, 7, 125, 2)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1076, 1078, 1, 100, 1)
INSERT [dbo].[DisbursementDetails] ([DisbursementDetailId], [DisbursementId], [ItemCatalogueId], [DisburseQuantity], [DisbursementStatusId]) VALUES (1077, 1079, 1, 12, 1)
SET IDENTITY_INSERT [dbo].[DisbursementDetails] OFF
SET IDENTITY_INSERT [dbo].[Disbursements] ON 

INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (2, 1, 5, 3, CAST(N'2019-11-12T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (14, 1, 5, 0, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (16, 1, 5, 0, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (17, 1, 2, 23, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1027, 1, 5, 15, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1028, 1, 5, 1017, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1029, 1, 5, 1016, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1030, 1, 1, 1018, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1031, 1, 5, 1020, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1032, 1, 5, 1052, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1033, 1, 5, 1053, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1034, 1, 5, 1054, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1035, 1, 3, 1055, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1036, 1, 3, 18, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1037, 2, 5, 1056, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1038, 2, 5, 1057, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1039, 1, 3, 1058, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1040, 2, 5, 1059, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1041, 1, 3, 1060, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1042, 2, 5, 1061, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1043, 1, 3, 1062, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1044, 2, 5, 1063, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1045, 1, 3, 1064, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1046, 1, 3, 1065, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1047, 2, 5, 1066, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1048, 1, 3, 1067, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1049, 2, 5, 1068, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1050, 1, 3, 1069, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1051, 2, 5, 1070, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1052, 1, 3, 1072, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1053, 1, 3, 1071, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1054, 2, 5, 1073, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1055, 1, 3, 1075, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1056, 1, 3, 1074, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1057, 2, 5, 1076, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1058, 1, 3, 1078, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1059, 1, 3, 1077, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1060, 2, 5, 1079, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1061, 1, 3, 1081, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1062, 1, 3, 1080, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1063, 2, 5, 1082, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1064, 1, 3, 1084, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1065, 1, 3, 1083, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1066, 2, 5, 1085, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1067, 1, 3, 1087, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1068, 1, 3, 1086, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1069, 2, 5, 1088, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1070, 1, 3, 1091, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1071, 1, 3, 1090, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1072, 1, 3, 1089, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1073, 1, 3, 1093, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1074, 1, 3, 1092, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1075, 1, 3, 19, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1076, 1, 3, 1094, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1077, 2, 5, 1095, NULL, 5)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1078, 1, 3, 1097, NULL, 1)
INSERT [dbo].[Disbursements] ([DisbursementId], [DepartmentId], [CollectionPointId], [RequestId], [DisburseDate], [Employee_EmployeeId]) VALUES (1079, 2, 5, 1098, NULL, 5)
SET IDENTITY_INSERT [dbo].[Disbursements] OFF
SET IDENTITY_INSERT [dbo].[DisbursementStatus] ON 

INSERT [dbo].[DisbursementStatus] ([DisbursementStatusId], [Description]) VALUES (1, N'PENDING')
INSERT [dbo].[DisbursementStatus] ([DisbursementStatusId], [Description]) VALUES (2, N'READY_FOR_COLLECTION')
INSERT [dbo].[DisbursementStatus] ([DisbursementStatusId], [Description]) VALUES (3, N'COLLECTED')
SET IDENTITY_INSERT [dbo].[DisbursementStatus] OFF
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (1, N'Ezra', N'Pound', N'67361001', N'67361100', N'head', N'head', N'ezrapound@logic.edu.sg', 1, 1, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (2, N'Pamela', N'Kow', N'67361002', N'67361100', N'pamelakow', N'english2', N'pamelakow@logic.edu.sg', 2, 1, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (3, N'Steven', N'Tan', N'67361003', N'67361100', N'employee', N'employee', N'steventan@logic.edu.sg', 4, 1, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (4, N'James', N'Lye', N'67361004', N'67361100', N'jameslye', N'english4', N'jameslye@logic.edu.sg', 4, 1, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (5, N'Kian Wee', N'Soh', N'67362001', N'67362100', N'kianweesoh', N'computer1', N'kianweesoh@logic.edu.sg', 1, 2, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (6, N'Kian Fatt', N'Wee', N'67362002', N'67362100', N'representative', N'representative', N'kianfattwee@logic.edu.sg', 2, 1, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (7, N'Jeremy', N'Su', N'67362003', N'67362100', N'jeremysu', N'computer3', N'jeremysu@logic.edu.sg', 4, 2, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (8, N'Jasmine', N'Tai', N'67362004', N'67362100', N'jasminetai', N'computer4', N'jasminetai@logic.edu.sg', 4, 2, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (9, N'Leow Bee', N'Chia', N'67363001', N'67363100', N'leowbeechia', N'commerce1', N'leowbeechia@logic.edu.sg', 1, 3, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (10, N'Azman', N'Mohd', N'67363001', N'67363100', N'azmanmohd', N'commerce2', N'azmanmohd@logic.edu.sg', 2, 3, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (11, N'Jana', N'D/O Jayaratnam', N'67363003', N'67363100', N'janajayaratnam', N'commerce3', N'janajayaratnam@logic.edu.sg', 4, 3, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (12, N'Terence', N'Tay', N'67363004', N'67363100', N'terencetay', N'commerce4', N'terencetay@logic.edu.sg', 4, 3, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (13, N'Peter', N'Gan', N'67366001', N'67366100', N'petergan', N'store1', N'petergan@logic.edu.sg', 5, 6, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (14, N'Annabelle', N'Lee', N'67366002', N'67366100', N'annabellelee', N'store2', N'annabellelee@logic.edu.sg', 6, 6, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (15, N'Keith', N'Teo', N'67366003', N'67366100', N'clerk', N'clerk', N'keithteo@logic.edu.sg', 7, 6, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (16, N'Ralph', N'Tay', N'67366004', N'67366100', N'ralphtay', N'store4', N'ralphtay@logic.edu.sg', 7, 6, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (17, N'Penelope', N'Quah', N'67366005', N'67366100', N'penelopequah', N'store5', N'penelopequah@logic.edu.sg', 7, 6, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (23, N'Ezra', N'Pound', N'67361001', N'67361100', N'ezrapound', N'english1', N'ezrapound@logic.edu.sg', 1, 12, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (25, N'Ezra', N'Pound', N'67361001', N'67361100', N'ezrapound', N'english1', N'ezrapound@logic.edu.sg', 1, 14, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (27, N'Ezra', N'Pound', N'67361001', N'67361100', N'ezrapound', N'english1', N'ezrapound@logic.edu.sg', 1, 16, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (29, N'Ezra', N'Pound', N'67361001', N'67361100', N'ezrapound', N'english1', N'ezrapound@logic.edu.sg', 1, 18, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (31, N'Ezra', N'Pound', N'67361001', N'67361100', N'ezrapound', N'english1', N'ezrapound@logic.edu.sg', 1, 20, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (32, N'Ezra', N'Pound', N'67361001', N'67361100', N'ezrapound', N'english1', N'ezrapound@logic.edu.sg', 1, 21, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (33, N'Ezra', N'Pound', N'67361001', N'67361100', N'ezrapound', N'english1', N'ezrapound@logic.edu.sg', 1, 22, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (34, N'Ezra', N'Pound', N'67361001', N'67361100', N'ezrapound', N'english1', N'ezrapound@logic.edu.sg', 1, 23, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (36, N'Keith', N'Teo', N'67366003', N'67366100', N'clerk', N'clerk', N'keithteo@logic.edu.sg', 9, 6, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (37, N'Keith', N'Teo', N'67366003', N'67366100', N'clerk', N'clerk', N'keithteo@logic.edu.sg', 10, 6, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [EmpPhone], [EmpFax], [Username], [Password], [EmpEmail], [RoleId], [DepartmentId], [AssignRole_AssignRoleId]) VALUES (38, N'Keith', N'Teo', N'67366003', N'67366100', N'clerk', N'clerk', N'keithteo@logic.edu.sg', 11, 6, NULL)
SET IDENTITY_INSERT [dbo].[Employees] OFF
SET IDENTITY_INSERT [dbo].[ItemCatalogues] ON 

INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (1, N'Clips Double 1"', N'Dozen', 1)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (2, N'Clips Double 2"', N'Dozen', 1)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (3, N'Clips Double 3/4"', N'Dozen', 1)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (4, N'Clips Paper Large', N'Box', 1)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (5, N'Clips Paper Medium', N'Box', 1)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (6, N'Clips Paper Small', N'Box', 1)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (7, N'Envelope Brown (3"x6")', N'Each', 2)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (8, N'Envelope Brown (3"x6") w/ Window', N'Each', 2)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (9, N'Envelope Brown (5"x7")', N'Each', 2)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (10, N'Envelope Brown (5"x7") w/ Window', N'Each', 2)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (11, N'Envelope White (3"x6")', N'Each', 2)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (12, N'Envelope White (3"x6") w/ Window', N'Each', 2)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (13, N'Envelope White (5"x7")', N'Each', 2)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (14, N'Envelope White (5"x7") w/ Window', N'Each', 2)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (15, N'Eraser (hard)', N'Each', 3)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (16, N'Eraser (soft)', N'Each', 3)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (17, N'Exercise Book (100 pg)', N'Each', 4)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (18, N'Exercise Book (120 pg)', N'Each', 4)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (19, N'Exercise Book A4 Hardcover (100 pg)', N'Each', 4)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (20, N'Exercise Book A4 Hardcover (120 pg)', N'Each', 4)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (21, N'Exercise Book A4 Hardcover (200 pg)', N'Each', 4)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (22, N'Exercise Book Hardcover (100 pg)', N'Each', 4)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (23, N'Exercise Book Hardcover (120 pg)', N'Each', 4)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (24, N'File Separator', N'Set', 5)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (25, N'File-Blue Plain', N'Each', 5)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (26, N'File-Blue with Logo', N'Each', 5)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (27, N'File-Brown w/o Logo', N'Each', 5)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (28, N'File-Brown with Logo', N'Each', 5)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (29, N'Folder Plastic Blue', N'Each', 5)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (30, N'Folder Plastic Clear', N'Each', 5)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (31, N'Folder Plastic Green', N'Each', 5)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (32, N'Folder Plastic Pink', N'Each', 5)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (33, N'Folder Plastic Yellow', N'Each', 5)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (34, N'Highlighter Blue', N'Box', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (35, N'Highlighter Green', N'Box', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (36, N'Highlighter Pink', N'Box', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (37, N'Highlighter Yellow', N'Box', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (38, N'Hole Puncher 2 holes', N'Each', 7)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (39, N'Hole Puncher 3 holes', N'Each', 7)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (40, N'Hole Puncher Adjustable', N'Each', 7)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (41, N'Pad Postit Memo 1"x2"', N'Packet', 8)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (42, N'Pad Postit Memo 1/2"x1"', N'Packet', 8)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (43, N'Pad Postit Memo 1/2"x2"', N'Packet', 8)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (44, N'Pad Postit Memo 2"x3"', N'Packet', 8)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (45, N'Pad Postit Memo 2"x4"', N'Packet', 8)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (46, N'Pad Postit Memo 2"x4"', N'Packet', 8)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (47, N'Pad Postit Memo 3/4"x2"', N'Packet', 8)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (48, N'Paper Photostat A3', N'Box', 9)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (49, N'Paper Photostat A4', N'Box', 9)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (50, N'Pen Ballpoint Black', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (51, N'Pen Ballpoint Blue', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (52, N'Pen Ballpoint Red', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (53, N'Pen Felt Tip Black', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (54, N'Pen Felt Tip Blue', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (55, N'Pen Felt Tip Red', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (56, N'Pen Transparency Permanent', N'Packet', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (57, N'Pen Transaparency Soluble', N'Packet', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (58, N'Pen Whiteboard Marker Black', N'Box', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (59, N'Pen Whiteboard Marker Blue', N'Box', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (60, N'Pen Whiteboard Marker Green', N'Box', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (61, N'Pen Whiteboard Marker Red', N'Box', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (62, N'Pencil 2B', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (63, N'Pencil 2B with Eraser End', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (65, N'Pencil 4H', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (66, N'Pencil B', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (67, N'Pencil B with Eraser End', N'Dozen', 6)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (68, N'Ruler 12"', N'Dozen', 10)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (69, N'Ruler 6"', N'Dozen', 10)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (70, N'Scissors', N'Each', 11)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (71, N'Scotch Tape', N'Each', 12)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (72, N'Scotch Tape Dispenser', N'Each', 12)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (73, N'Sharpener', N'Each', 13)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (74, N'Shorthand Book (100 pg)', N'Each', 14)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (75, N'Shorthand Book (120 pg)', N'Each', 14)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (76, N'Shorthand Book (80 pg)', N'Each', 14)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (77, N'Stapler No. 28', N'Each', 15)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (78, N'Stapler No. 36', N'Each', 15)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (79, N'Stapler No. 28', N'Box', 15)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (80, N'Stapler No. 36', N'Box', 15)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (81, N'Thumb Tacks Large', N'Box', 16)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (82, N'Thumb Tacks Medium', N'Box', 16)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (83, N'Thumb Tacks Small', N'Box', 16)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (84, N'Transparency Blue', N'Box', 17)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (85, N'Transparency Clear', N'Box', 17)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (86, N'Transparency Green', N'Box', 17)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (87, N'Transparency Red', N'Box', 17)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (88, N'Transparency Reverse Blue', N'Box', 17)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (89, N'Transparency Cover 3M', N'Box', 17)
INSERT [dbo].[ItemCatalogues] ([ItemId], [ItemDes], [UnitOfMeasure], [CategoryId]) VALUES (90, N'Trays In/Out', N'Set', 18)
SET IDENTITY_INSERT [dbo].[ItemCatalogues] OFF
INSERT [dbo].[OrderDetails] ([OrderId], [ItemId], [OrderQuantity], [ExpDelDate], [ActDelDate], [ReceiveQuantity], [ItemCatalogue_ItemCatalogueId]) VALUES (1012, 7, 360, CAST(N'2020-03-11T00:00:00.000' AS DateTime), CAST(N'2020-02-11T17:07:31.153' AS DateTime), 360, 7)
INSERT [dbo].[OrderDetails] ([OrderId], [ItemId], [OrderQuantity], [ExpDelDate], [ActDelDate], [ReceiveQuantity], [ItemCatalogue_ItemCatalogueId]) VALUES (1012, 10, 400, CAST(N'2020-04-11T00:00:00.000' AS DateTime), CAST(N'2020-02-11T16:06:06.677' AS DateTime), 380, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ItemId], [OrderQuantity], [ExpDelDate], [ActDelDate], [ReceiveQuantity], [ItemCatalogue_ItemCatalogueId]) VALUES (1014, 1, 30, NULL, CAST(N'2020-02-13T02:59:45.427' AS DateTime), 30, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ItemId], [OrderQuantity], [ExpDelDate], [ActDelDate], [ReceiveQuantity], [ItemCatalogue_ItemCatalogueId]) VALUES (1017, 14, 400, NULL, CAST(N'2020-02-13T02:59:46.920' AS DateTime), 400, 14)
INSERT [dbo].[OrderDetails] ([OrderId], [ItemId], [OrderQuantity], [ExpDelDate], [ActDelDate], [ReceiveQuantity], [ItemCatalogue_ItemCatalogueId]) VALUES (1023, 8, 400, CAST(N'2020-02-12T00:00:00.000' AS DateTime), CAST(N'2020-02-13T03:21:03.110' AS DateTime), 400, 8)
INSERT [dbo].[OrderDetails] ([OrderId], [ItemId], [OrderQuantity], [ExpDelDate], [ActDelDate], [ReceiveQuantity], [ItemCatalogue_ItemCatalogueId]) VALUES (1023, 15, 20, CAST(N'2020-02-12T00:00:00.000' AS DateTime), CAST(N'2020-02-13T03:06:49.150' AS DateTime), 20, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ItemId], [OrderQuantity], [ExpDelDate], [ActDelDate], [ReceiveQuantity], [ItemCatalogue_ItemCatalogueId]) VALUES (1024, 1, 30, NULL, CAST(N'2020-02-13T19:51:36.573' AS DateTime), 30, 1)
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderId], [SupplierId], [EmpId], [OrderDate], [Employee_EmployeeId], [OrderStatus_OrderStatusId]) VALUES (1012, 1, 15, NULL, NULL, 4)
INSERT [dbo].[Orders] ([OrderId], [SupplierId], [EmpId], [OrderDate], [Employee_EmployeeId], [OrderStatus_OrderStatusId]) VALUES (1014, 2, 15, NULL, NULL, 4)
INSERT [dbo].[Orders] ([OrderId], [SupplierId], [EmpId], [OrderDate], [Employee_EmployeeId], [OrderStatus_OrderStatusId]) VALUES (1017, 4, 15, NULL, NULL, 4)
INSERT [dbo].[Orders] ([OrderId], [SupplierId], [EmpId], [OrderDate], [Employee_EmployeeId], [OrderStatus_OrderStatusId]) VALUES (1023, 3, 15, NULL, NULL, 4)
INSERT [dbo].[Orders] ([OrderId], [SupplierId], [EmpId], [OrderDate], [Employee_EmployeeId], [OrderStatus_OrderStatusId]) VALUES (1024, 1, 15, NULL, NULL, 4)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([OrderStatusId], [OrderDes]) VALUES (1, N'DRAFT')
INSERT [dbo].[OrderStatus] ([OrderStatusId], [OrderDes]) VALUES (2, N'ENQUIRING')
INSERT [dbo].[OrderStatus] ([OrderStatusId], [OrderDes]) VALUES (3, N'ORDERED')
INSERT [dbo].[OrderStatus] ([OrderStatusId], [OrderDes]) VALUES (4, N'DELIVERED')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
SET IDENTITY_INSERT [dbo].[RequestDetails] ON 

INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1, 1, 1, 17)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (2, 3, 1, 20)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (3, 9, 9, 7)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (4, 10, 1, 7)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (5, 11, 1, 7)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (6, 12, 1, 7)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (8, 14, 8, 71)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (9, 15, 1, 5)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (10, 16, 1, 17)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (11, 17, 1, 2)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (12, 18, 9, 7)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (13, 19, 15, 2)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (14, 20, 10, 7)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (16, 22, 8, 5)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (17, 23, 7, 7)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1008, 1014, 1, 7)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1009, 1015, 90, 6)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1010, 1016, 17, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1011, 1017, 1, 12)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1012, 1018, 17, 123)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1013, 1019, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1014, 1020, 17, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1016, 1023, 74, 30)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1017, 1024, 74, 70)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1018, 1025, 74, 60)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1019, 1026, 75, 100)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1020, 1027, 75, 100)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1021, 1028, 75, 120)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1024, 1030, 76, 50)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1025, 1034, 76, 100)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1027, 1037, 1, 100)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1028, 1039, 1, 125)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1029, 1042, 2, 100)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1030, 1043, 2, 150)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1031, 1044, 3, 180)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1032, 1045, 3, 210)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1034, 1046, 4, 130)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1035, 1047, 4, 180)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1036, 1048, 5, 200)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1037, 1049, 5, 210)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1038, 1050, 6, 220)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1039, 1051, 6, 230)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1040, 1052, 15, 100)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1041, 1053, 2, 100)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1042, 1054, 10, 7)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1043, 1055, 7, 12)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1044, 1056, 38, 7)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1045, 1057, 7, 123)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1046, 1058, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1047, 1059, 7, 123)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1048, 1060, 1, 12)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1049, 1061, 1, 13)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1050, 1062, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1051, 1063, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1052, 1064, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1053, 1065, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1054, 1066, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1055, 1067, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1056, 1068, 1, 12)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1057, 1069, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1058, 1070, 1, 12)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1059, 1071, 1, 12)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1060, 1072, 7, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1061, 1073, 1, 40)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1062, 1074, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1063, 1075, 7, 12)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1064, 1076, 1, 40)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1065, 1077, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1066, 1078, 7, 12)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1067, 1079, 1, 30)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1068, 1080, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1069, 1081, 7, 20)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1070, 1082, 1, 40)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1071, 1083, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1072, 1084, 7, 20)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1073, 1085, 1, 40)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1074, 1086, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1075, 1087, 7, 20)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1076, 1088, 1, 40)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1077, 1089, 2, 12)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1078, 1090, 15, 13)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1079, 1091, 1, 15)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1080, 1092, 1, 10)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1081, 1093, 7, 20)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1082, 1094, 7, 123)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1083, 1095, 7, 125)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1084, 1096, 7, 12)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1085, 1097, 1, 100)
INSERT [dbo].[RequestDetails] ([RequestDetailId], [RequestId], [ItemCatalogueId], [Quantity]) VALUES (1086, 1098, 1, 12)
SET IDENTITY_INSERT [dbo].[RequestDetails] OFF
SET IDENTITY_INSERT [dbo].[Requests] ON 

INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1, 1, CAST(N'2019-10-28T00:00:00.000' AS DateTime), 1, NULL, NULL, CAST(N'2020-01-28T00:00:00.000' AS DateTime), 1, 3, 1, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (3, 2, CAST(N'2019-11-09T00:00:00.000' AS DateTime), 3, N'WELCOME EVENT', N'PRIORITY', CAST(N'2019-11-08T00:00:00.000' AS DateTime), 5, 5, 7, 2)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (9, 12, NULL, 1, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 2, 23, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (10, 1, NULL, 3, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 25, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (11, 1, NULL, 3, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 27, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (12, 1, NULL, 1, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 29, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (14, 22, NULL, 1, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 2, 33, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (15, 1, NULL, 3, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 1, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (16, 1, NULL, 1, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 1, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (17, 1, NULL, 1, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 1, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (18, 1, NULL, 3, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 1, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (19, 1, NULL, 3, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 1, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (20, 1, NULL, 1, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 1, 14)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (22, 1, NULL, 1, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 1, 16)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (23, 1, NULL, 6, NULL, NULL, CAST(N'2020-01-27T00:00:00.000' AS DateTime), NULL, 3, 1, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1014, 1, NULL, 1, NULL, NULL, CAST(N'2020-01-28T00:00:00.000' AS DateTime), NULL, 3, 1, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1015, 1, NULL, 3, NULL, NULL, CAST(N'2020-01-28T00:00:00.000' AS DateTime), NULL, 3, 1, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1016, 1, NULL, 3, NULL, NULL, CAST(N'2020-01-29T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1017, 1, NULL, 3, NULL, NULL, CAST(N'2020-01-29T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1018, 1, NULL, 6, NULL, NULL, CAST(N'2020-01-29T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1019, 1, NULL, 1, NULL, NULL, CAST(N'2020-02-02T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1020, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-02T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1023, 2, CAST(N'2019-02-10T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-01-20T00:00:00.000' AS DateTime), NULL, 5, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1024, 2, CAST(N'2019-02-11T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-01-20T00:00:00.000' AS DateTime), NULL, 5, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1025, 3, CAST(N'2019-02-10T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-01-23T00:00:00.000' AS DateTime), NULL, 2, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1026, 4, CAST(N'2019-02-12T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-01-25T00:00:00.000' AS DateTime), NULL, 3, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1027, 5, CAST(N'2019-02-14T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-01-28T00:00:00.000' AS DateTime), NULL, 3, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1028, 5, CAST(N'2019-02-19T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-03T00:00:00.000' AS DateTime), NULL, 3, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1030, 6, CAST(N'2019-02-18T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-04T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1034, 6, CAST(N'2019-02-20T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-03T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1037, 1, CAST(N'2019-02-10T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-03T00:00:00.000' AS DateTime), NULL, 3, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1039, 2, CAST(N'2019-02-11T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-06T00:00:00.000' AS DateTime), NULL, 5, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1042, 3, CAST(N'2019-02-11T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-07T00:00:00.000' AS DateTime), NULL, 4, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1043, 4, CAST(N'2019-02-11T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-10T00:00:00.000' AS DateTime), NULL, 4, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1044, 5, CAST(N'2019-02-12T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-09T00:00:00.000' AS DateTime), NULL, 4, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1045, 6, CAST(N'2019-02-13T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-07T00:00:00.000' AS DateTime), NULL, 3, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1046, 1, CAST(N'2019-02-22T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-03T00:00:00.000' AS DateTime), NULL, 3, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1047, 2, CAST(N'2019-02-23T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-03T00:00:00.000' AS DateTime), NULL, 5, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1048, 3, CAST(N'2019-02-24T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-12T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1049, 4, CAST(N'2019-02-20T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-08T00:00:00.000' AS DateTime), NULL, 2, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1050, 5, CAST(N'2019-02-24T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-03T00:00:00.000' AS DateTime), NULL, 3, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1051, 6, CAST(N'2019-02-25T00:00:00.000' AS DateTime), 6, NULL, NULL, CAST(N'2019-02-03T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1052, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-10T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1053, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-10T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1054, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1055, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1056, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1057, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1058, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1059, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1060, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1061, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1062, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1063, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1064, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1065, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1066, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1067, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1068, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1069, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1070, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1071, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1072, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1073, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1074, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1075, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1076, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1077, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1078, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1079, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1080, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1081, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1082, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1083, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1084, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1085, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1086, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1087, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1088, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1089, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1090, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1091, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1092, 1, NULL, 6, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1093, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1094, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1095, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1096, 1, NULL, 1, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1097, 1, NULL, 3, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 3, 3, NULL)
INSERT [dbo].[Requests] ([RequestId], [DepartmentId], [ApprByDate], [RequestStatusId], [RequestComment], [DepHeadComment], [RequestDate], [ApprByEmp_EmployeeId], [CollectionPoint_CollectionPointId], [RaisedByEmployee_EmployeeId], [Disbursement_DisbursementId]) VALUES (1098, 2, NULL, 3, NULL, NULL, CAST(N'2020-02-13T00:00:00.000' AS DateTime), NULL, 5, 7, NULL)
SET IDENTITY_INSERT [dbo].[Requests] OFF
SET IDENTITY_INSERT [dbo].[RequestStatus] ON 

INSERT [dbo].[RequestStatus] ([RequestStatusId], [RequestStatusDescription]) VALUES (1, N'PENDING')
INSERT [dbo].[RequestStatus] ([RequestStatusId], [RequestStatusDescription]) VALUES (2, N'REJECTED')
INSERT [dbo].[RequestStatus] ([RequestStatusId], [RequestStatusDescription]) VALUES (3, N'APPROVED')
INSERT [dbo].[RequestStatus] ([RequestStatusId], [RequestStatusDescription]) VALUES (6, N'DELIVERED')
SET IDENTITY_INSERT [dbo].[RequestStatus] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleDescription]) VALUES (1, N'DEPARTMENT_HEAD')
INSERT [dbo].[Roles] ([RoleId], [RoleDescription]) VALUES (2, N'DEPARTMENT_REP')
INSERT [dbo].[Roles] ([RoleId], [RoleDescription]) VALUES (3, N'DEPARTMENT_HEAD_TEMP')
INSERT [dbo].[Roles] ([RoleId], [RoleDescription]) VALUES (4, N'EMPLOYEE')
INSERT [dbo].[Roles] ([RoleId], [RoleDescription]) VALUES (5, N'STORE_MANAGER')
INSERT [dbo].[Roles] ([RoleId], [RoleDescription]) VALUES (6, N'STATIONERY_STORE_SUPERVISOR')
INSERT [dbo].[Roles] ([RoleId], [RoleDescription]) VALUES (7, N'STORE_CLERK')
INSERT [dbo].[Roles] ([RoleId], [RoleDescription]) VALUES (9, N'STORE_CLERK')
INSERT [dbo].[Roles] ([RoleId], [RoleDescription]) VALUES (10, N'STORE_CLERK')
INSERT [dbo].[Roles] ([RoleId], [RoleDescription]) VALUES (11, N'STORE_CLERK')
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[StockCards] ON 

INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (2, 1, CAST(N'2019-10-25T00:00:00.000' AS DateTime), N'Supplier - ALPHA', 80, 2)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (3, 1, CAST(N'2019-10-30T00:00:00.000' AS DateTime), N'English Department', -10, 2)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (4, 1, CAST(N'2019-10-31T00:00:00.000' AS DateTime), N'Stocktake Adjustment', -5, 2)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (5, 1, CAST(N'2019-11-11T00:00:00.000' AS DateTime), N'Computer Science Department', -20, 2)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (6, 1, CAST(N'2019-11-15T00:00:00.000' AS DateTime), N'Supplier- ALPHA', 30, 2)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (7, 10, CAST(N'2020-01-29T13:23:38.250' AS DateTime), N'Received stock', 400, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (8, 21, CAST(N'2020-01-29T23:41:40.360' AS DateTime), N'Received stock', 50, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (9, 6, CAST(N'2020-01-29T23:41:41.480' AS DateTime), N'Received stock', 30, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (10, 7, CAST(N'2020-01-30T22:53:10.393' AS DateTime), N'Supplier - ALPHA Office Supplies', 400, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (11, 9, CAST(N'2020-02-11T16:05:55.610' AS DateTime), N'Supplier - Cheap Stationer', 400, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (12, 10, CAST(N'2020-02-11T16:06:06.677' AS DateTime), N'Supplier - ALPHA Office Supplies', 380, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (13, 7, CAST(N'2020-02-11T17:07:31.310' AS DateTime), N'Supplier - ALPHA Office Supplies', 360, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (14, 15, CAST(N'2020-02-12T10:51:08.940' AS DateTime), N'Supplier - BANES Shop', 20, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (15, 16, CAST(N'2020-02-13T00:13:42.927' AS DateTime), N'Supplier - BANES Shop', 18, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (16, 8, CAST(N'2020-02-13T00:14:04.333' AS DateTime), N'Supplier - BANES Shop', 400, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (17, 1, CAST(N'2020-02-13T02:59:45.430' AS DateTime), N'Supplier - Cheap Stationer', 30, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (18, 14, CAST(N'2020-02-13T02:59:46.920' AS DateTime), N'Supplier - OMEGA Stationery Supplier', 400, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (19, 15, CAST(N'2020-02-13T03:06:49.153' AS DateTime), N'Supplier - BANES Shop', 20, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (20, 8, CAST(N'2020-02-13T03:21:03.113' AS DateTime), N'Supplier - BANES Shop', 400, NULL)
INSERT [dbo].[StockCards] ([StockCardId], [ItemCatalogueId], [ChangeDate], [ChangeDescription], [ChangeQuantity], [StockInfo_StockInfoId]) VALUES (21, 1, CAST(N'2020-02-13T19:51:36.577' AS DateTime), N'Supplier - ALPHA Office Supplies', 30, NULL)
SET IDENTITY_INSERT [dbo].[StockCards] OFF
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (2, 1, N'A1', 50, 30, 10)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (3, 2, N'A1', 50, 30, 63)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (4, 3, N'A1', 50, 30, 70)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (5, 4, N'A1', 50, 30, 65)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (6, 5, N'A1', 50, 30, 60)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (7, 6, N'A1', 50, 30, 70)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (8, 7, N'A10', 600, 400, 710)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (9, 8, N'A10', 600, 400, 900)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (10, 9, N'A10', 600, 400, 750)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (11, 10, N'A10', 600, 400, 668)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (12, 11, N'A10', 600, 400, 700)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (13, 12, N'A10', 600, 400, 800)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (14, 13, N'A10', 600, 400, 800)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (15, 14, N'A10', 600, 400, 900)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (16, 15, N'A2', 50, 20, 53)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (17, 16, N'A2', 50, 20, 63)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (18, 17, N'A11', 100, 50, 89)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (19, 18, N'A11', 100, 50, 130)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (20, 19, N'A11', 100, 50, 120)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (21, 20, N'A11', 100, 50, 115)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (22, 21, N'A11', 100, 50, 150)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (23, 22, N'A11', 100, 50, 140)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (24, 23, N'A11', 100, 50, 140)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (25, 24, N'A12', 100, 50, 140)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (26, 25, N'A12', 200, 100, 250)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (27, 26, N'A12', 200, 100, 250)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (28, 27, N'A12', 200, 150, 300)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (29, 28, N'A12', 200, 150, 300)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (30, 29, N'A12', 200, 150, 300)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (31, 30, N'A12', 200, 150, 300)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (32, 31, N'A12', 200, 150, 300)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (33, 32, N'A12', 200, 150, 300)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (34, 33, N'A12', 200, 150, 300)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (35, 74, N'A7', 200, 100, 220)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (36, 75, N'A7', 300, 200, 327)
INSERT [dbo].[StockInfoes] ([StockInfoId], [ItemCatalogueId], [ItemLocation], [ReOrderLevel], [ReOrderQuantity], [StockQuantity]) VALUES (37, 76, N'A7', 250, 250, 300)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 1, 2, 1, 1)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 2, 3, 1, 2)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 3, 1.5, 1, 3)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 4, 2.8, 2, 4)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 5, 2.8, 2, 5)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 6, 2.5, 1, 6)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 7, 0.2, 1, 7)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 8, 1, 2, 8)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 10, 1.5, 1, 10)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 11, 1.4, 3, 11)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 12, 0.2, 1, 12)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 13, 0.3, 1, 13)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 14, 0.5, 3, 14)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 15, 0.55, 3, 15)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 16, 0.5, 2, 16)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 17, 0.25, 2, 17)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 19, 1.5, 1, 19)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 20, 1.6, 1, 20)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 21, 2, 1, 21)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 22, 2, 1, 22)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 23, 2.7, 3, 23)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 24, 1, 1, 24)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 74, 5.5, 1, 74)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 75, 6, 1, 75)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (1, 76, 6.2, 1, 76)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 1, 2.2, 2, 1)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 3, 2.2, 3, 3)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 4, 2.5, 1, 4)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 5, 3, 3, 5)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 6, 3, 2, 6)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 8, 1.2, 3, 8)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 9, 1.2, 2, 9)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 10, 1.5, 3, 10)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 11, 1.3, 2, 11)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 12, 0.25, 2, 12)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 14, 0.5, 2, 14)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 15, 0.55, 2, 15)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 16, 0.55, 3, 16)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 18, 0.25, 1, 18)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 23, 2.5, 1, 23)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 24, 1.1, 2, 24)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 25, 2.5, 1, 25)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 75, 6.2, 2, 75)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (2, 76, 6.5, 2, 76)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 1, 2.5, 3, 1)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 2, 3.3, 2, 2)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 7, 0.25, 2, 7)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 8, 0.98, 1, 8)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 9, 1, 1, 9)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 10, 1.5, 2, 10)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 11, 1.2, 1, 11)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 13, 0.35, 2, 13)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 15, 0.5, 1, 15)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 16, 0.48, 1, 16)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 17, 0.22, 1, 17)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 18, 0.24, 2, 18)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 19, 1.7, 3, 19)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 20, 1.8, 3, 20)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 21, 2.3, 3, 21)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 22, 2.3, 3, 22)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 24, 1.1, 3, 24)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 25, 2.5, 2, 25)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 74, 5.8, 2, 74)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (3, 75, 6.5, 3, 75)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 2, 3.6, 3, 2)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 3, 1.8, 2, 3)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 4, 3, 3, 4)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 5, 2.5, 1, 5)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 6, 3.2, 3, 6)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 7, 0.25, 3, 7)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 9, 1.3, 3, 9)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 12, 0.3, 3, 12)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 13, 0.4, 3, 13)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 14, 0.45, 1, 14)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 17, 0.3, 3, 17)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 18, 0.3, 3, 18)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 19, 1.6, 2, 19)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 20, 1.7, 2, 20)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 21, 2.2, 2, 21)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 22, 2.2, 2, 22)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 23, 2.6, 2, 23)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 25, 2.6, 3, 25)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 74, 6, 3, 74)
INSERT [dbo].[SupplierCatalogues] ([SupplierId], [ItemId], [ItemPrice], [SupplierRank], [ItemCatalogue_ItemCatalogueId]) VALUES (4, 76, 6.8, 3, 76)
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([SupplierId], [SupplierName], [SupplierContact], [SupplierPhone], [SupplierFax], [SupplierAddress], [SupplierEmail], [SupplierGST]) VALUES (1, N'ALPHA Office Supplies', N'Ms Irene Tan', N'4619928', N'4612238', N'Blk 1128, Ang Mo Kio Industrial Park #02-1108 Ang Mo Kio Street 62, Singapore 622262', N'irene.tan@alpha.com.sg', N'MR-8500440-2')
INSERT [dbo].[Suppliers] ([SupplierId], [SupplierName], [SupplierContact], [SupplierPhone], [SupplierFax], [SupplierAddress], [SupplierEmail], [SupplierGST]) VALUES (2, N'Cheap Stationer', N'Mr Soh Kway Koh', N'3543234', N'4742434', N'Blk 34, Clementi Road #07-02 Ban Ban Soh Building, Singapore 110525', N'kwaykoh.soh@cheapstationer.com.sg', N'')
INSERT [dbo].[Suppliers] ([SupplierId], [SupplierName], [SupplierContact], [SupplierPhone], [SupplierFax], [SupplierAddress], [SupplierEmail], [SupplierGST]) VALUES (3, N'BANES Shop', N'Mr Loh Ah Pek', N'4781234', N'4792434', N'Blk 124, Alexandra Road #03-04 Banes Building, Singapore 550315', N'ahpek.low@banes.com.sg', N'MR-8200420-2')
INSERT [dbo].[Suppliers] ([SupplierId], [SupplierName], [SupplierContact], [SupplierPhone], [SupplierFax], [SupplierAddress], [SupplierEmail], [SupplierGST]) VALUES (4, N'OMEGA Stationery Supplier', N'Mr Ronnie Ho', N'7671233', N'7671234', N'Blk 11, Hillview Avenue #03-04, Singapore 679036', N'ronnie.ho@omega.com.sg', N'MR-8555330-1')
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
/****** Object:  Index [IX_AdjustmentVoucherId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_AdjustmentVoucherId] ON [dbo].[AdjustmentDetails]
(
	[AdjustmentVoucherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemCatalogueId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_ItemCatalogueId] ON [dbo].[AdjustmentDetails]
(
	[ItemCatalogueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AdjustmentStatusId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_AdjustmentStatusId] ON [dbo].[AdjustmentVouchers]
(
	[AdjustmentStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ApprovedByEmployee_EmployeeId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_ApprovedByEmployee_EmployeeId] ON [dbo].[AdjustmentVouchers]
(
	[ApprovedByEmployee_EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RaisedByEmployee_EmployeeId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_RaisedByEmployee_EmployeeId] ON [dbo].[AdjustmentVouchers]
(
	[RaisedByEmployee_EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AssignedBy_EmployeeId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_AssignedBy_EmployeeId] ON [dbo].[AssignRoles]
(
	[AssignedBy_EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_EmployeeId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeId] ON [dbo].[AssignRoles]
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AssignRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_EmployeeId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeId] ON [dbo].[CollectionPoints]
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DisbursementId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_DisbursementId] ON [dbo].[DisbursementDetails]
(
	[DisbursementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DisbursementStatusId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_DisbursementStatusId] ON [dbo].[DisbursementDetails]
(
	[DisbursementStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemCatalogueId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_ItemCatalogueId] ON [dbo].[DisbursementDetails]
(
	[ItemCatalogueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CollectionPointId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_CollectionPointId] ON [dbo].[Disbursements]
(
	[CollectionPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DepartmentId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_DepartmentId] ON [dbo].[Disbursements]
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Employee_EmployeeId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Employee_EmployeeId] ON [dbo].[Disbursements]
(
	[Employee_EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AssignRole_AssignRoleId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_AssignRole_AssignRoleId] ON [dbo].[Employees]
(
	[AssignRole_AssignRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DepartmentId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_DepartmentId] ON [dbo].[Employees]
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[Employees]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CategoryId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_CategoryId] ON [dbo].[ItemCatalogues]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemCatalogue_ItemCatalogueId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_ItemCatalogue_ItemCatalogueId] ON [dbo].[OrderDetails]
(
	[ItemCatalogue_ItemCatalogueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderId] ON [dbo].[OrderDetails]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Employee_EmployeeId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Employee_EmployeeId] ON [dbo].[Orders]
(
	[Employee_EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderStatus_OrderStatusId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderStatus_OrderStatusId] ON [dbo].[Orders]
(
	[OrderStatus_OrderStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SupplierId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_SupplierId] ON [dbo].[Orders]
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemCatalogueId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_ItemCatalogueId] ON [dbo].[RequestDetails]
(
	[ItemCatalogueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RequestId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_RequestId] ON [dbo].[RequestDetails]
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ApprByEmp_EmployeeId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_ApprByEmp_EmployeeId] ON [dbo].[Requests]
(
	[ApprByEmp_EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CollectionPoint_CollectionPointId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_CollectionPoint_CollectionPointId] ON [dbo].[Requests]
(
	[CollectionPoint_CollectionPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DepartmentId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_DepartmentId] ON [dbo].[Requests]
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Disbursement_DisbursementId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Disbursement_DisbursementId] ON [dbo].[Requests]
(
	[Disbursement_DisbursementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RaisedByEmployee_EmployeeId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_RaisedByEmployee_EmployeeId] ON [dbo].[Requests]
(
	[RaisedByEmployee_EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RequestStatusId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_RequestStatusId] ON [dbo].[Requests]
(
	[RequestStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemCatalogueId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_ItemCatalogueId] ON [dbo].[StockCards]
(
	[ItemCatalogueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_StockInfo_StockInfoId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_StockInfo_StockInfoId] ON [dbo].[StockCards]
(
	[StockInfo_StockInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_StockInfoId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_StockInfoId] ON [dbo].[StockInfoes]
(
	[StockInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemCatalogue_ItemCatalogueId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_ItemCatalogue_ItemCatalogueId] ON [dbo].[SupplierCatalogues]
(
	[ItemCatalogue_ItemCatalogueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SupplierId]    Script Date: 2/13/2020 11:26:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_SupplierId] ON [dbo].[SupplierCatalogues]
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdjustmentDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AdjustmentDetails_dbo.AdjustmentVouchers_AdjustmentVoucherId] FOREIGN KEY([AdjustmentVoucherId])
REFERENCES [dbo].[AdjustmentVouchers] ([AdjustmentVoucherId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdjustmentDetails] CHECK CONSTRAINT [FK_dbo.AdjustmentDetails_dbo.AdjustmentVouchers_AdjustmentVoucherId]
GO
ALTER TABLE [dbo].[AdjustmentDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AdjustmentDetails_dbo.ItemCatalogues_ItemCatalogueId] FOREIGN KEY([ItemCatalogueId])
REFERENCES [dbo].[ItemCatalogues] ([ItemId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdjustmentDetails] CHECK CONSTRAINT [FK_dbo.AdjustmentDetails_dbo.ItemCatalogues_ItemCatalogueId]
GO
ALTER TABLE [dbo].[AdjustmentVouchers]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AdjustmentVouchers_dbo.AdjustmentStatus_AdjustmentStatusId] FOREIGN KEY([AdjustmentStatusId])
REFERENCES [dbo].[AdjustmentStatus] ([AdjustmentStatusId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdjustmentVouchers] CHECK CONSTRAINT [FK_dbo.AdjustmentVouchers_dbo.AdjustmentStatus_AdjustmentStatusId]
GO
ALTER TABLE [dbo].[AdjustmentVouchers]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AdjustmentVouchers_dbo.Employees_ApprovedByEmployee_EmployeeId] FOREIGN KEY([ApprovedByEmployee_EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[AdjustmentVouchers] CHECK CONSTRAINT [FK_dbo.AdjustmentVouchers_dbo.Employees_ApprovedByEmployee_EmployeeId]
GO
ALTER TABLE [dbo].[AdjustmentVouchers]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AdjustmentVouchers_dbo.Employees_RaisedByEmployee_EmployeeId] FOREIGN KEY([RaisedByEmployee_EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[AdjustmentVouchers] CHECK CONSTRAINT [FK_dbo.AdjustmentVouchers_dbo.Employees_RaisedByEmployee_EmployeeId]
GO
ALTER TABLE [dbo].[AssignRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AssignRoles_dbo.Employees_AssignedBy_EmployeeId] FOREIGN KEY([AssignedBy_EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[AssignRoles] CHECK CONSTRAINT [FK_dbo.AssignRoles_dbo.Employees_AssignedBy_EmployeeId]
GO
ALTER TABLE [dbo].[AssignRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AssignRoles_dbo.Employees_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AssignRoles] CHECK CONSTRAINT [FK_dbo.AssignRoles_dbo.Employees_EmployeeId]
GO
ALTER TABLE [dbo].[AssignRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AssignRoles_dbo.Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[AssignRoles] CHECK CONSTRAINT [FK_dbo.AssignRoles_dbo.Roles_RoleId]
GO
ALTER TABLE [dbo].[CollectionPoints]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CollectionPoints_dbo.Employees_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CollectionPoints] CHECK CONSTRAINT [FK_dbo.CollectionPoints_dbo.Employees_EmployeeId]
GO
ALTER TABLE [dbo].[DisbursementDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DisbursementDetails_dbo.Disbursements_DisbursementId] FOREIGN KEY([DisbursementId])
REFERENCES [dbo].[Disbursements] ([DisbursementId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DisbursementDetails] CHECK CONSTRAINT [FK_dbo.DisbursementDetails_dbo.Disbursements_DisbursementId]
GO
ALTER TABLE [dbo].[DisbursementDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DisbursementDetails_dbo.DisbursementStatus_DisbursementStatusId] FOREIGN KEY([DisbursementStatusId])
REFERENCES [dbo].[DisbursementStatus] ([DisbursementStatusId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DisbursementDetails] CHECK CONSTRAINT [FK_dbo.DisbursementDetails_dbo.DisbursementStatus_DisbursementStatusId]
GO
ALTER TABLE [dbo].[DisbursementDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DisbursementDetails_dbo.ItemCatalogues_ItemCatalogueId] FOREIGN KEY([ItemCatalogueId])
REFERENCES [dbo].[ItemCatalogues] ([ItemId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DisbursementDetails] CHECK CONSTRAINT [FK_dbo.DisbursementDetails_dbo.ItemCatalogues_ItemCatalogueId]
GO
ALTER TABLE [dbo].[Disbursements]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Disbursements_dbo.CollectionPoints_CollectionPointId] FOREIGN KEY([CollectionPointId])
REFERENCES [dbo].[CollectionPoints] ([CollectionPointId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Disbursements] CHECK CONSTRAINT [FK_dbo.Disbursements_dbo.CollectionPoints_CollectionPointId]
GO
ALTER TABLE [dbo].[Disbursements]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Disbursements_dbo.Departments_DepartmentId] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Disbursements] CHECK CONSTRAINT [FK_dbo.Disbursements_dbo.Departments_DepartmentId]
GO
ALTER TABLE [dbo].[Disbursements]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Disbursements_dbo.Employees_Employee_EmployeeId] FOREIGN KEY([Employee_EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Disbursements] CHECK CONSTRAINT [FK_dbo.Disbursements_dbo.Employees_Employee_EmployeeId]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Employees_dbo.AssignRoles_AssignRole_AssignRoleId] FOREIGN KEY([AssignRole_AssignRoleId])
REFERENCES [dbo].[AssignRoles] ([TempRoleId])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_dbo.Employees_dbo.AssignRoles_AssignRole_AssignRoleId]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Employees_dbo.Departments_DepartmentId] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_dbo.Employees_dbo.Departments_DepartmentId]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Employees_dbo.Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_dbo.Employees_dbo.Roles_RoleId]
GO
ALTER TABLE [dbo].[ItemCatalogues]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ItemCatalogues_dbo.Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ItemCatalogues] CHECK CONSTRAINT [FK_dbo.ItemCatalogues_dbo.Categories_CategoryId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.OrderDetails_dbo.ItemCatalogues_ItemCatalogue_ItemCatalogueId] FOREIGN KEY([ItemCatalogue_ItemCatalogueId])
REFERENCES [dbo].[ItemCatalogues] ([ItemId])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_dbo.OrderDetails_dbo.ItemCatalogues_ItemCatalogue_ItemCatalogueId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.OrderDetails_dbo.Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_dbo.OrderDetails_dbo.Orders_OrderId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Orders_dbo.Employees_Employee_EmployeeId] FOREIGN KEY([Employee_EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_dbo.Orders_dbo.Employees_Employee_EmployeeId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Orders_dbo.OrderStatus_OrderStatus_OrderStatusId] FOREIGN KEY([OrderStatus_OrderStatusId])
REFERENCES [dbo].[OrderStatus] ([OrderStatusId])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_dbo.Orders_dbo.OrderStatus_OrderStatus_OrderStatusId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Orders_dbo.Suppliers_SupplierId] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Suppliers] ([SupplierId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_dbo.Orders_dbo.Suppliers_SupplierId]
GO
ALTER TABLE [dbo].[RequestDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.RequestDetails_dbo.ItemCatalogues_ItemCatalogueId] FOREIGN KEY([ItemCatalogueId])
REFERENCES [dbo].[ItemCatalogues] ([ItemId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RequestDetails] CHECK CONSTRAINT [FK_dbo.RequestDetails_dbo.ItemCatalogues_ItemCatalogueId]
GO
ALTER TABLE [dbo].[RequestDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.RequestDetails_dbo.Requests_RequestId] FOREIGN KEY([RequestId])
REFERENCES [dbo].[Requests] ([RequestId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RequestDetails] CHECK CONSTRAINT [FK_dbo.RequestDetails_dbo.Requests_RequestId]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Requests_dbo.CollectionPoints_CollectionPoint_CollectionPointId] FOREIGN KEY([CollectionPoint_CollectionPointId])
REFERENCES [dbo].[CollectionPoints] ([CollectionPointId])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_dbo.Requests_dbo.CollectionPoints_CollectionPoint_CollectionPointId]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Requests_dbo.Departments_DepartmentId] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_dbo.Requests_dbo.Departments_DepartmentId]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Requests_dbo.Disbursements_Disbursement_DisbursementId] FOREIGN KEY([Disbursement_DisbursementId])
REFERENCES [dbo].[Disbursements] ([DisbursementId])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_dbo.Requests_dbo.Disbursements_Disbursement_DisbursementId]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Requests_dbo.Employees_ApprByEmp_EmployeeId] FOREIGN KEY([ApprByEmp_EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_dbo.Requests_dbo.Employees_ApprByEmp_EmployeeId]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Requests_dbo.Employees_RaisedByEmployee_EmployeeId] FOREIGN KEY([RaisedByEmployee_EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_dbo.Requests_dbo.Employees_RaisedByEmployee_EmployeeId]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Requests_dbo.RequestStatus_RequestStatusId] FOREIGN KEY([RequestStatusId])
REFERENCES [dbo].[RequestStatus] ([RequestStatusId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_dbo.Requests_dbo.RequestStatus_RequestStatusId]
GO
ALTER TABLE [dbo].[StockCards]  WITH CHECK ADD  CONSTRAINT [FK_dbo.StockCards_dbo.ItemCatalogues_ItemCatalogueId] FOREIGN KEY([ItemCatalogueId])
REFERENCES [dbo].[ItemCatalogues] ([ItemId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StockCards] CHECK CONSTRAINT [FK_dbo.StockCards_dbo.ItemCatalogues_ItemCatalogueId]
GO
ALTER TABLE [dbo].[StockCards]  WITH CHECK ADD  CONSTRAINT [FK_dbo.StockCards_dbo.StockInfoes_StockInfo_StockInfoId] FOREIGN KEY([StockInfo_StockInfoId])
REFERENCES [dbo].[StockInfoes] ([StockInfoId])
GO
ALTER TABLE [dbo].[StockCards] CHECK CONSTRAINT [FK_dbo.StockCards_dbo.StockInfoes_StockInfo_StockInfoId]
GO
ALTER TABLE [dbo].[StockInfoes]  WITH CHECK ADD  CONSTRAINT [FK_dbo.StockInfoes_dbo.ItemCatalogues_StockInfoId] FOREIGN KEY([StockInfoId])
REFERENCES [dbo].[ItemCatalogues] ([ItemId])
GO
ALTER TABLE [dbo].[StockInfoes] CHECK CONSTRAINT [FK_dbo.StockInfoes_dbo.ItemCatalogues_StockInfoId]
GO
ALTER TABLE [dbo].[SupplierCatalogues]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SupplierCatalogues_dbo.ItemCatalogues_ItemCatalogue_ItemCatalogueId] FOREIGN KEY([ItemCatalogue_ItemCatalogueId])
REFERENCES [dbo].[ItemCatalogues] ([ItemId])
GO
ALTER TABLE [dbo].[SupplierCatalogues] CHECK CONSTRAINT [FK_dbo.SupplierCatalogues_dbo.ItemCatalogues_ItemCatalogue_ItemCatalogueId]
GO
ALTER TABLE [dbo].[SupplierCatalogues]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SupplierCatalogues_dbo.Suppliers_SupplierId] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Suppliers] ([SupplierId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SupplierCatalogues] CHECK CONSTRAINT [FK_dbo.SupplierCatalogues_dbo.Suppliers_SupplierId]
GO
USE [master]
GO
ALTER DATABASE [AD_Project] SET  READ_WRITE 
GO
