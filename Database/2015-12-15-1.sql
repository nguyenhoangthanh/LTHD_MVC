USE [master]
GO
/****** Object:  Database [LTHD_WebLaptop]    Script Date: 12/15/2015 10:27:25 PM ******/
CREATE DATABASE [LTHD_WebLaptop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LTHD_WebLaptop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\LTHD_WebLaptop.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LTHD_WebLaptop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\LTHD_WebLaptop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LTHD_WebLaptop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LTHD_WebLaptop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET ARITHABORT OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LTHD_WebLaptop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LTHD_WebLaptop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LTHD_WebLaptop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LTHD_WebLaptop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LTHD_WebLaptop] SET  MULTI_USER 
GO
ALTER DATABASE [LTHD_WebLaptop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LTHD_WebLaptop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LTHD_WebLaptop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LTHD_WebLaptop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [LTHD_WebLaptop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LTHD_WebLaptop] SET QUERY_STORE = OFF
GO
USE [LTHD_WebLaptop]
GO
/****** Object:  Table [dbo].[CT_DonDH]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_DonDH](
	[Id_DonDH] [int] NOT NULL,
	[Id_SP] [int] NOT NULL,
	[DonGia] [float] NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK_CT_DonDH] PRIMARY KEY CLUSTERED 
(
	[Id_DonDH] ASC,
	[Id_SP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DonDH]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonDH](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NgayDat] [date] NOT NULL,
	[NgayGiao] [date] NOT NULL,
	[TongTien] [float] NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](50) NOT NULL,
	[DienThoai] [nchar](11) NOT NULL,
	[GhiChu] [nvarchar](50) NULL,
	[Id_TinhTrang] [int] NOT NULL,
	[Id_NguoiDung] [int] NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_DonDH] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MatKhau] [nvarchar](max) NOT NULL,
	[Id_Quyen] [int] NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](50) NOT NULL,
	[DienThoai] [nchar](11) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[KichHoat] [int] NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_NguoiDung] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenNhaCC] [nvarchar](50) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhieuNhap]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuNhap](
	[Id_PhieuNhap] [int] IDENTITY(1,1) NOT NULL,
	[NgayNhap] [datetime] NOT NULL,
	[Id_SP] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK_PhieuNhap] PRIMARY KEY CLUSTERED 
(
	[Id_PhieuNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Quyen]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quyen](
	[Id] [int] NOT NULL,
	[TenQuyen] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Quyen] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenSP] [nvarchar](1024) NOT NULL,
	[Id_NCC] [int] NOT NULL,
	[HDD] [nvarchar](1024) NOT NULL,
	[RAM] [nvarchar](1024) NOT NULL,
	[CPU] [nvarchar](1024) NOT NULL,
	[DonGia] [float] NOT NULL,
	[HinhAnh] [nvarchar](1024) NOT NULL,
	[BaoHanh] [nvarchar](1024) NOT NULL,
	[LuotXem] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_SanPham] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TinhTrangDonDH]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhTrangDonDH](
	[Id] [int] NOT NULL,
	[TinhTrang] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TinhTrangDonDH] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TonKho]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TonKho](
	[NgayThang] [date] NOT NULL,
	[Id_SP] [int] NOT NULL,
	[SoLuongTon] [int] NOT NULL,
 CONSTRAINT [PK_TonKho] PRIMARY KEY CLUSTERED 
(
	[NgayThang] ASC,
	[Id_SP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (4, 3, 14000000, 3)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (5, 2, 10000000, 1)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (5, 3, 14000000, 1)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (6, 2, 10000000, 1)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (6, 3, 14000000, 2)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (6, 4, 13500000, 3)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (7, 2, 10000000, 1)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (7, 3, 14000000, 1)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (8, 3, 14000000, 1)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (9, 3, 14000000, 1)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (9, 5, 14000000, 1)
INSERT [dbo].[CT_DonDH] ([Id_DonDH], [Id_SP], [DonGia], [SoLuong]) VALUES (10, 1, 12500000, 4)
SET IDENTITY_INSERT [dbo].[DonDH] ON 

INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (4, CAST(N'2014-11-09' AS Date), CAST(N'2014-11-14' AS Date), 42000000, N'dadsds', N'dadsada', N'01234567892', N'Gọi trước khi giao hàng', 0, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (5, CAST(N'2014-11-09' AS Date), CAST(N'2014-11-14' AS Date), 24000000, N'b', N'bbbb', N'43243243222', N'fsdfsdf', 2, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (6, CAST(N'2014-11-10' AS Date), CAST(N'2014-11-15' AS Date), 78500000, N'Phan Thanh Minh', N'123 Nguyễn Du', N'01231231232', N'Giao hàng buổi trưa', 1, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (7, CAST(N'2014-11-10' AS Date), CAST(N'2014-11-17' AS Date), 24000000, N'asdasdasasd', N'adasdasdas', N'23321312314', N'dasdasdasdas', 0, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (8, CAST(N'2014-12-10' AS Date), CAST(N'2014-12-11' AS Date), 14000000, N'aaaa', N'bbbb', N'01212411412', N'rewrewrewr', 1, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (9, CAST(N'2014-12-11' AS Date), CAST(N'2014-11-18' AS Date), 28000000, N'Lê Thanh Bình', N'123 Nguyễn Du', N'01231231237', N'rewrewrewr', 2, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (10, CAST(N'2014-11-13' AS Date), CAST(N'2014-11-13' AS Date), 50000000, N'Nguyễn Minh Anh', N'23 Lê Lai', N'01223314656', N'Giao hàng gọi trước', 0, 17, 1)
SET IDENTITY_INSERT [dbo].[DonDH] OFF
SET IDENTITY_INSERT [dbo].[NguoiDung] ON 

INSERT [dbo].[NguoiDung] ([Id], [MatKhau], [Id_Quyen], [HoTen], [DiaChi], [DienThoai], [Email], [KichHoat], [TrangThai]) VALUES (14, N'123456', 2, N'Nguyễn Thị Quỳnh', N'Nguyễn Trãi', N'01135453215', N'nguyenthiquynh.1112@gmail.com', 1, 1)
INSERT [dbo].[NguoiDung] ([Id], [MatKhau], [Id_Quyen], [HoTen], [DiaChi], [DienThoai], [Email], [KichHoat], [TrangThai]) VALUES (15, N'123456', 1, N'Văn Quốc Phát', N'123 Nguyễn Trãi', N'01234561231', N'dtphong@gmail.com', 1, 1)
INSERT [dbo].[NguoiDung] ([Id], [MatKhau], [Id_Quyen], [HoTen], [DiaChi], [DienThoai], [Email], [KichHoat], [TrangThai]) VALUES (28, N'1234', 0, N'sfsdf', N'sdfsd', N'221        ', N'21221', 1, 0)
INSERT [dbo].[NguoiDung] ([Id], [MatKhau], [Id_Quyen], [HoTen], [DiaChi], [DienThoai], [Email], [KichHoat], [TrangThai]) VALUES (29, N'1thanh', 1, N'Nguyễn Hoàng Thanh', N'502 Huỳnh Tấn Phát', N'01284236882', N'thanh@gmail.com', 1, 1)
SET IDENTITY_INSERT [dbo].[NguoiDung] OFF
SET IDENTITY_INSERT [dbo].[NhaCungCap] ON 

INSERT [dbo].[NhaCungCap] ([Id], [TenNhaCC], [TrangThai]) VALUES (1, N'HP', 0)
INSERT [dbo].[NhaCungCap] ([Id], [TenNhaCC], [TrangThai]) VALUES (2, N'Dell', 1)
INSERT [dbo].[NhaCungCap] ([Id], [TenNhaCC], [TrangThai]) VALUES (4, N'Samsung', 0)
INSERT [dbo].[NhaCungCap] ([Id], [TenNhaCC], [TrangThai]) VALUES (6, N'Acer', 0)
INSERT [dbo].[NhaCungCap] ([Id], [TenNhaCC], [TrangThai]) VALUES (8, N'Motorola', 1)
INSERT [dbo].[NhaCungCap] ([Id], [TenNhaCC], [TrangThai]) VALUES (9, N'yyyyy', 0)
INSERT [dbo].[NhaCungCap] ([Id], [TenNhaCC], [TrangThai]) VALUES (10, N'qazzz', 1)
INSERT [dbo].[NhaCungCap] ([Id], [TenNhaCC], [TrangThai]) VALUES (11, N'thanh', 1)
INSERT [dbo].[NhaCungCap] ([Id], [TenNhaCC], [TrangThai]) VALUES (12, N'toshibae', 1)
SET IDENTITY_INSERT [dbo].[NhaCungCap] OFF
SET IDENTITY_INSERT [dbo].[PhieuNhap] ON 

INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (1, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 2, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (4, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 2, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (5, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 3, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (6, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 4, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (7, CAST(N'2014-12-11T00:00:00.000' AS DateTime), 5, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (8, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 6, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (9, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 7, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (10, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 8, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (11, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 9, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (12, CAST(N'2014-12-11T00:00:00.000' AS DateTime), 10, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (13, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 20, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (14, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 21, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (15, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 22, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (16, CAST(N'2014-12-11T00:00:00.000' AS DateTime), 23, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (17, CAST(N'2014-11-18T00:00:00.000' AS DateTime), 1, 15)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (18, CAST(N'2014-11-12T00:00:00.000' AS DateTime), 1, 5)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (19, CAST(N'2015-12-17T00:00:00.000' AS DateTime), 35, 20)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (20, CAST(N'2015-11-12T00:00:00.000' AS DateTime), 5, 100)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (21, CAST(N'2015-12-11T00:00:00.000' AS DateTime), 24, 100)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (22, CAST(N'2015-12-15T00:00:00.000' AS DateTime), 35, 100)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (23, CAST(N'2015-12-15T00:00:00.000' AS DateTime), 27, 22)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (24, CAST(N'2015-12-15T00:00:00.000' AS DateTime), 1024, 12)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (25, CAST(N'2015-12-15T00:00:00.000' AS DateTime), 1024, 15)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (26, CAST(N'2015-12-15T21:47:22.607' AS DateTime), 1025, 66)
SET IDENTITY_INSERT [dbo].[PhieuNhap] OFF
INSERT [dbo].[Quyen] ([Id], [TenQuyen]) VALUES (0, N'User      ')
INSERT [dbo].[Quyen] ([Id], [TenQuyen]) VALUES (1, N'Admin     ')
INSERT [dbo].[Quyen] ([Id], [TenQuyen]) VALUES (2, N'SuperAdmin')
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (1, N'Acer 01', 6, N'4', N'4', N'Intel Core I7', 12500000, N'acer_01.jpg         ', N'12 tháng', 11, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (2, N'Acer 02', 6, N'500GB', N'4GB', N'Intel Core I3', 10000000, N'acer_02.jpg         ', N'12 tháng', 23, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (3, N'HP 01', 1, N'500GB', N'4GB', N'Intel Core I5', 14000000, N'hp_01.jpg           ', N'12 tháng', 5, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (4, N'HP 02', 1, N'500GB', N'2GB', N'Intel Core I3', 13500000, N'hp_02.jpg           ', N'12 tháng', 4, 0, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (5, N'Dell 01', 2, N'500GB', N'4GB', N'Intel Core I5', 14000000, N'dell_01.jpg         ', N'12 tháng', 5, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (6, N'Dell 02', 2, N'500GB', N'4GB', N'Intel Core I3', 15000000, N'dell_02.jpg         ', N'12 tháng', 2, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (7, N'Dell 03', 2, N'500GB', N'2GB', N'Intel Core I5', 14500000, N'dell_03.jpg         ', N'12 tháng', 1, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (8, N'Samsung 01', 4, N'500GB', N'4GB', N'Intel Core I3', 14000000, N'ss_01.jpg           ', N'12 tháng', 2, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (9, N'Samsung 02', 4, N'500GB', N'2GB', N'Intel Core I5', 10000000, N'ss_02.jpg           ', N'12 tháng', 4, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (10, N'Samsung 03', 4, N'500GB', N'4GB', N'Intel Core I3', 15500000, N'ss_03.jpg           ', N'12 tháng', 6, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (20, N'Dell 04', 2, N'500GB', N'4GB', N'Intel Core I3', 14500000, N'dell_04.jpg         ', N'12 tháng', 7, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (21, N'HP 03', 1, N'500GB', N'4GB', N'Intel Core I5', 15000000, N'hp_03.jpg           ', N'12 tháng', 8, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (22, N'Acer 03', 6, N'500GB', N'4GB', N'Intel Core I5', 16000000, N'acer_03.jpg         ', N'12 tháng', 4, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (23, N'Dell 05', 2, N'500GB', N'4GB', N'Intel Core I3', 13500000, N'dell_05.jpg         ', N'12 tháng', 9, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (24, N'Apple_01', 8, N'500GB', N'4GB', N'Intel Core I3', 16000000, N'Apple_01.jpg', N'6 tháng', 0, 21, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (25, N'Apple_02', 8, N'500GB', N'4GB', N'Intel Core I3', 18000000, N'Apple_02.jpg', N'22 tháng', 0, 222, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (26, N'Apple_15', 8, N'500GB', N'4GB', N'Intel Core I3', 16000000, N'Apple_15.jpg', N'4 tháng', 0, 4, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (27, N'Apple_03', 8, N'500GB', N'4GB', N'Intel Core I7', 16000000, N'Apple_03.jpg', N'13 tháng', 0, 25, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (28, N'Hp_12', 1, N'500GB', N'8GB', N'Intel Core I3', 17000000, N'Hp_12.jpg', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (29, N'Apple_04', 8, N'500GB', N'8GB', N'Intel Core I3', 19000000, N'Apple_04.jpg', N'5 tháng', 0, 5, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (30, N'Hp_13', 1, N'500GB', N'8GB', N'Intel Core I5', 22000000, N'Hp_13.jpg', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (31, N'Hp_15', 1, N'500GB', N'8GB', N'Intel Core I7', 24000000, N'Hp_15.jpg', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (32, N'Hp_16', 1, N'500GB', N'8GB', N'Intel Core I7', 19000000, N'Hp_16.jpg', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (33, N'Apple_06', 8, N'500GB', N'8GB', N'Intel Core I3', 16000000, N'Apple_06.jpg', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (34, N'Apple_07', 8, N'500GB', N'8GB', N'Intel Core I5', 19000000, N'Apple_07.jpg', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (35, N'Apple_08', 8, N'500GB', N'8GB', N'Intel Core I7', 22000000, N'Apple_08.jpg', N'12 tháng', 0, 1333, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (36, N'Apple_10', 8, N'500GB', N'8GB', N'Intel Core I7', 23000000, N'Apple_10.jpg', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (44, N'Asus_01', 10, N'500GB', N'8GB', N'Intel CoreI5', 17000000, N'Asus_01.jpg', N'5 tháng', 0, 9, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (50, N'Asus_02', 10, N'500GB', N'6GB', N'Intel CoreI7', 180000000, N'Asus_02.jpg', N'12 tháng', 0, 9, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (52, N'Asus_03', 10, N'500GB', N'8GB', N'Intel CoreI7', 20000000, N'Asus_03.jpg', N'12 tháng', 0, 10, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (55, N'Asus_04', 10, N'500GB', N'4GB', N'Intel CoreI3', 10000000, N'Asus_04.jpg', N'24 tháng', 0, 7, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (57, N'Asus_05', 10, N'500GB', N'2GB', N'Intel CoreI3', 8000000, N'Asus_05.jpg', N'12 tháng', 0, 12, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (58, N'Asus_08', 10, N'500GB', N'4GB', N'Intel CoreI5', 13000000, N'Asus_08.jpg', N'12 tháng', 0, 9, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (1024, N'HP Stream 11-d033TU (N4F93PA)', 1, N'32', N'2', N'Intel Celeron N2840 2.16GHz - 1M', 4900000, N'25637_stream-11-purplee_2015_12_15_21_19_20.jpg', N'12 tháng', 0, 83, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (1025, N'Dell Inspiron N3558A', 2, N'500', N'4', N'Intel Core i3 4005U 1.7GHz - 3M', 9800000, N'24080_n3558aA_2015_12_15_21_47_06.jpg', N'12 tháng', 0, 66, 1)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
INSERT [dbo].[TinhTrangDonDH] ([Id], [TinhTrang]) VALUES (0, N'Chưa giao')
INSERT [dbo].[TinhTrangDonDH] ([Id], [TinhTrang]) VALUES (1, N'Đã giao ')
INSERT [dbo].[TinhTrangDonDH] ([Id], [TinhTrang]) VALUES (2, N'Đã hủy')
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(N'2014-10-10' AS Date), 1, 12)
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(N'2014-10-10' AS Date), 2, 10)
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(N'2014-10-10' AS Date), 3, 5)
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(N'2014-10-10' AS Date), 4, 7)
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(N'2014-10-10' AS Date), 5, 10)
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(N'2014-10-10' AS Date), 6, 20)
ALTER TABLE [dbo].[CT_DonDH]  WITH CHECK ADD  CONSTRAINT [FK_CT_DonDH_DonDH1] FOREIGN KEY([Id_DonDH])
REFERENCES [dbo].[DonDH] ([Id])
GO
ALTER TABLE [dbo].[CT_DonDH] CHECK CONSTRAINT [FK_CT_DonDH_DonDH1]
GO
ALTER TABLE [dbo].[CT_DonDH]  WITH CHECK ADD  CONSTRAINT [FK_CT_DonDH_SanPham1] FOREIGN KEY([Id_SP])
REFERENCES [dbo].[SanPham] ([Id])
GO
ALTER TABLE [dbo].[CT_DonDH] CHECK CONSTRAINT [FK_CT_DonDH_SanPham1]
GO
ALTER TABLE [dbo].[DonDH]  WITH CHECK ADD  CONSTRAINT [FK_DonDH_TinhTrangDonDH1] FOREIGN KEY([Id_TinhTrang])
REFERENCES [dbo].[TinhTrangDonDH] ([Id])
GO
ALTER TABLE [dbo].[DonDH] CHECK CONSTRAINT [FK_DonDH_TinhTrangDonDH1]
GO
ALTER TABLE [dbo].[NguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_NguoiDung_Quyen1] FOREIGN KEY([Id_Quyen])
REFERENCES [dbo].[Quyen] ([Id])
GO
ALTER TABLE [dbo].[NguoiDung] CHECK CONSTRAINT [FK_NguoiDung_Quyen1]
GO
ALTER TABLE [dbo].[PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_PhieuNhap_SanPham] FOREIGN KEY([Id_SP])
REFERENCES [dbo].[SanPham] ([Id])
GO
ALTER TABLE [dbo].[PhieuNhap] CHECK CONSTRAINT [FK_PhieuNhap_SanPham]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_NhaCungCap1] FOREIGN KEY([Id_NCC])
REFERENCES [dbo].[NhaCungCap] ([Id])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_NhaCungCap1]
GO
ALTER TABLE [dbo].[TonKho]  WITH CHECK ADD  CONSTRAINT [FK_TonKho_SanPham1] FOREIGN KEY([Id_SP])
REFERENCES [dbo].[SanPham] ([Id])
GO
ALTER TABLE [dbo].[TonKho] CHECK CONSTRAINT [FK_TonKho_SanPham1]
GO
/****** Object:  StoredProcedure [dbo].[ThongKe]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Nguyen Thi Quynh>
-- Create date: <15/12/2015>
-- Description:	<Thong ke so luong ton>
-- =============================================
CREATE PROCEDURE [dbo].[ThongKe]
	@Id_SP int,
	@TuNgay date,
	@DenNgay date
AS
BEGIN
	select TonKho.Id_SP, TonKho.TenSP, SUM(TonKho.SoLuongNhap) AS SoLuongNhap, SUM(TonKho.SoLuongXuat) AS SoLuongXuat, TonKho.ThangNam from(
		select Id_SP, sp.TenSP, SUM(pn.SoLuong) AS SoLuongNhap, 0 AS SoLuongXuat, CONVERT(varchar(50),Datepart(mm,pn.NgayNhap)) + '/' + CONVERT(varchar(50),Datepart(yyyy,pn.NgayNhap)) AS ThangNam 
		from PhieuNhap pn JOIN SanPham sp ON pn.Id_SP = sp.Id
		where (Id_SP = @Id_SP OR @Id_SP = -1)
		and NgayNhap > @TuNgay and NgayNhap < @DenNgay
		group by Id_SP, sp.TenSP, CONVERT(varchar(50),Datepart(mm,pn.NgayNhap)) + '/' + CONVERT(varchar(50),Datepart(yyyy,pn.NgayNhap))
		union all
		select Id_SP, sp.TenSP, 0 AS SoLuongNhap, SUM(ct.SoLuong) AS SoLuongXuat, CONVERT(varchar(50),Datepart(mm,ddh.NgayGiao)) + '/' + CONVERT(varchar(50),Datepart(yyyy,ddh.NgayGiao)) AS ThangNam 
		from CT_DonDH ct JOIN DonDH ddh on ct.Id_DonDH = ddh.Id JOIN SanPham sp ON ct.Id_SP = sp.Id
		where (Id_SP = @Id_SP OR @Id_SP = -1)
		and NgayGiao > @TuNgay and NgayGiao < @DenNgay
		group by Id_SP, sp.TenSP, CONVERT(varchar(50),Datepart(mm,ddh.NgayGiao)) + '/' + CONVERT(varchar(50),Datepart(yyyy,ddh.NgayGiao))
	) TonKho
	group by TonKho.Id_SP, TonKho.TenSP, TonKho.ThangNam

END



GO
/****** Object:  StoredProcedure [dbo].[ThongKe1]    Script Date: 12/15/2015 10:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ThongKe1]
	@Id_SP int,
	@TuNgay date,
	@DenNgay date
AS
BEGIN
	select TonKho.Id_SP, SUM(TonKho.SoLuongNhap) AS SoLuongNhap, SUM(TonKho.SoLuongXuat) AS SoLuongXuat, TonKho.ThangNam from(
		select Id_SP, SUM(SoLuong) AS SoLuongNhap, 0 AS SoLuongXuat, CONVERT(varchar(50),Datepart(mm,pn.NgayNhap)) + '/' + CONVERT(varchar(50),Datepart(yyyy,pn.NgayNhap)) AS ThangNam 
		from PhieuNhap pn
		where (Id_SP = @Id_SP OR @Id_SP = -1)
		and NgayNhap > @TuNgay and NgayNhap < @DenNgay
		group by Id_SP, CONVERT(varchar(50),Datepart(mm,pn.NgayNhap)) + '/' + CONVERT(varchar(50),Datepart(yyyy,pn.NgayNhap))
		union all
		select Id_SP, 0 AS SoLuongNhap, SUM(SoLuong) AS SoLuongXuat, CONVERT(varchar(50),Datepart(mm,ddh.NgayGiao)) + '/' + CONVERT(varchar(50),Datepart(yyyy,ddh.NgayGiao)) AS ThangNam 
		from CT_DonDH ct JOIN DonDH ddh on ct.Id_DonDH = ddh.Id
		where (Id_SP = @Id_SP OR @Id_SP = -1)
		and NgayGiao > @TuNgay and NgayGiao < @DenNgay
		group by Id_SP, CONVERT(varchar(50),Datepart(mm,ddh.NgayGiao)) + '/' + CONVERT(varchar(50),Datepart(yyyy,ddh.NgayGiao))
	) TonKho
	group by TonKho.Id_SP, TonKho.ThangNam

END


GO
USE [master]
GO
ALTER DATABASE [LTHD_WebLaptop] SET  READ_WRITE 
GO
