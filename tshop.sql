USE [master]
GO
/****** Object:  Database [TshopDB]    Script Date: 6/15/2022 8:26:43 AM ******/
CREATE DATABASE [TshopDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TshopDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TshopDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TshopDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TshopDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [TshopDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TshopDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TshopDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TshopDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TshopDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TshopDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TshopDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TshopDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TshopDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TshopDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TshopDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TshopDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TshopDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TshopDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TshopDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TshopDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TshopDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TshopDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TshopDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TshopDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TshopDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TshopDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TshopDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TshopDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TshopDB] SET RECOVERY FULL 
GO
ALTER DATABASE [TshopDB] SET  MULTI_USER 
GO
ALTER DATABASE [TshopDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TshopDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TshopDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TshopDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TshopDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TshopDB', N'ON'
GO
ALTER DATABASE [TshopDB] SET QUERY_STORE = OFF
GO
ALTER AUTHORIZATION ON DATABASE::[TshopDB] TO [sa]
GO
USE [TshopDB]
GO
/****** Object:  Table [dbo].[accounts]    Script Date: 6/15/2022 8:26:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[accounts](
	[username] [varchar](32) NOT NULL,
	[password] [varchar](60) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[accounts] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[cart_items]    Script Date: 6/15/2022 8:26:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart_items](
	[cart_item_id] [bigint] IDENTITY(1,1) NOT NULL,
	[customer_id] [bigint] NOT NULL,
	[product_id] [bigint] NOT NULL,
	[quantity] [int] NOT NULL,
	[selected] [bit] NOT NULL,
	[unit_price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[cart_items] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[categories]    Script Date: 6/15/2022 8:26:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[category_id] [bigint] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[categories] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[customers]    Script Date: 6/15/2022 8:26:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[customer_id] [bigint] IDENTITY(1,1) NOT NULL,
	[address] [nvarchar](500) NULL,
	[email] [nvarchar](49) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[password] [varchar](62) NOT NULL,
	[phone] [varchar](20) NOT NULL,
	[registered_date] [date] NULL,
	[status] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[customers] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[order_details]    Script Date: 6/15/2022 8:26:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_details](
	[order_detail_id] [bigint] IDENTITY(1,1) NOT NULL,
	[quantity] [int] NOT NULL,
	[unit_price] [float] NOT NULL,
	[order_id] [bigint] NULL,
	[product_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[order_details] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[orders]    Script Date: 6/15/2022 8:26:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[order_id] [bigint] IDENTITY(1,1) NOT NULL,
	[amount] [float] NOT NULL,
	[order_date] [date] NULL,
	[status] [smallint] NOT NULL,
	[customer_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[orders] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[products]    Script Date: 6/15/2022 8:26:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[product_id] [bigint] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[discount] [float] NOT NULL,
	[enter_date] [date] NULL,
	[image] [varchar](900) NULL,
	[name] [nvarchar](900) NOT NULL,
	[quantity] [int] NOT NULL,
	[status] [smallint] NOT NULL,
	[unit_price] [float] NOT NULL,
	[category_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[products] TO  SCHEMA OWNER 
GO
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'tanlnps16096', N'$2a$10$EFfA/CjL4bGSSdS3hhuh8uymSZH48ohff5nz.SpaR1JVU3784I8.a')
GO
SET IDENTITY_INSERT [dbo].[cart_items] ON 

INSERT [dbo].[cart_items] ([cart_item_id], [customer_id], [product_id], [quantity], [selected], [unit_price]) VALUES (15, 7, 6, 1, 0, 31)
INSERT [dbo].[cart_items] ([cart_item_id], [customer_id], [product_id], [quantity], [selected], [unit_price]) VALUES (16, 7, 10, 2, 0, 13)
SET IDENTITY_INSERT [dbo].[cart_items] OFF
GO
SET IDENTITY_INSERT [dbo].[categories] ON 

INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (4, N'Fresh Meat')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (6, N'Vegetables')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (7, N'Fruit & Nut Gifts')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (8, N'Fresh Berries')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (9, N'Ocean Foods')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (10, N'Butter & Eggs')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (11, N'Fastfood')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (12, N'Fresh Onion')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (13, N'Papayaya & Crisps')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (14, N'Oatmeal')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (15, N'Fresh Bananas')
INSERT [dbo].[categories] ([category_id], [category_name]) VALUES (18, N'123123123')
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
SET IDENTITY_INSERT [dbo].[customers] ON 

INSERT [dbo].[customers] ([customer_id], [address], [email], [name], [password], [phone], [registered_date], [status]) VALUES (7, N'1232', N'brislam2002@gmail.com', N'Lâm Nhựt Tân', N'$2a$10$38hnOzsk02sJYHy01Vn5DeEA0PhY6aEDWMtSD5XhfS.LJF2WGLjYC', N'0394494818', CAST(N'2022-06-14' AS Date), 0)
SET IDENTITY_INSERT [dbo].[customers] OFF
GO
SET IDENTITY_INSERT [dbo].[order_details] ON 

INSERT [dbo].[order_details] ([order_detail_id], [quantity], [unit_price], [order_id], [product_id]) VALUES (1, 12, 436, 1, 12)
INSERT [dbo].[order_details] ([order_detail_id], [quantity], [unit_price], [order_id], [product_id]) VALUES (2, 3, 13, 2, 10)
SET IDENTITY_INSERT [dbo].[order_details] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([order_id], [amount], [order_date], [status], [customer_id]) VALUES (1, 5232, CAST(N'2022-06-15' AS Date), 0, 7)
INSERT [dbo].[orders] ([order_id], [amount], [order_date], [status], [customer_id]) VALUES (2, 39, CAST(N'2022-06-15' AS Date), 0, 7)
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (1, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'p8245cd3c-b76a-41b0-89f9-b97047297a56.jpg', N'Mango', 20, 0, 12, 4)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (2, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'p25270137-5ab6-427d-9b59-0f82e7a1af1f.jpg', N'Meatt', 20, 1, 32, 4)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (3, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'p89053ebd-b78c-4750-b95b-85ebffa23a20.jpg', N'Banana', 20, 2, 4, 15)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (4, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'p349aa71b-312b-4d29-bf53-3d5332a3609d.jpg', N'Guava fruit', 43, 0, 13, 7)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (5, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'p09182e94-9289-4b85-9713-3a18d3a36942.jpg', N'Grape', 54, 0, 45, 7)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (6, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'pce65e93d-e1c0-4de2-bf3e-d268553f95f5.jpg', N'Hamberger', 45, 2, 31, 11)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (7, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'p3d407635-7828-4216-b988-6023e4c2cb50.jpg', N'Watermelon', 234, 0, 43, 7)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (8, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'pf5c99ce5-b3ca-4374-9f03-ee8ad8cd2da2.jpg', N'Apple', 235, 0, 13, 7)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (9, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'pcffa07a5-6c2b-42ea-9298-dc6bd23f87e1.jpg', N'Sliwki', 231, 0, 65, 7)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (10, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'p4ab29a3a-59c9-4a10-83e3-836fd3a8ca1e.jpg', N'Fried chicken', 56, 2, 13, 11)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (11, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'pc77f094a-877e-4a2c-8b82-acaf6e6fb060.jpg', N'Tropicana', 673, 1, 23, 7)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (12, N'ngon bo re', 0, CAST(N'2022-06-14' AS Date), N'p7c6ea2ef-acee-491d-9d8a-0284140091f5.jpg', N'Alllll', 123, 1, 436, 6)
INSERT [dbo].[products] ([product_id], [description], [discount], [enter_date], [image], [name], [quantity], [status], [unit_price], [category_id]) VALUES (13, N'ngon bo re', 20, CAST(N'2022-06-15' AS Date), N'p2ff2fba5-6a15-4f65-b339-890992f31b01.jpg', N'Mango 2', 5442, 0, 30, 7)
SET IDENTITY_INSERT [dbo].[products] OFF
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD  CONSTRAINT [FK4q98utpd73imf4yhttm3w0eax] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
GO
ALTER TABLE [dbo].[order_details] CHECK CONSTRAINT [FK4q98utpd73imf4yhttm3w0eax]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD  CONSTRAINT [FKjyu2qbqt8gnvno9oe9j2s2ldk] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([order_id])
GO
ALTER TABLE [dbo].[order_details] CHECK CONSTRAINT [FKjyu2qbqt8gnvno9oe9j2s2ldk]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FKpxtb8awmi0dk6smoh2vp1litg] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([customer_id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FKpxtb8awmi0dk6smoh2vp1litg]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FKog2rp4qthbtt2lfyhfo32lsw9] FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([category_id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FKog2rp4qthbtt2lfyhfo32lsw9]
GO
USE [master]
GO
ALTER DATABASE [TshopDB] SET  READ_WRITE 
GO
