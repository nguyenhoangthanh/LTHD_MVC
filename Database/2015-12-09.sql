USE [master]
GO
/****** Object:  Database [LTHD_WebLaptop]    Script Date: 12/9/2015 5:47:18 PM ******/
CREATE DATABASE [LTHD_WebLaptop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LTHD_WebLaptop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\LTHD_WebLaptop.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LTHD_WebLaptop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\LTHD_WebLaptop_log.ldf' , SIZE = 4224KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [LTHD_WebLaptop] SET COMPATIBILITY_LEVEL = 110
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
ALTER DATABASE [LTHD_WebLaptop] SET RECOVERY FULL 
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
/****** Object:  Table [dbo].[CT_DonDH]    Script Date: 12/9/2015 5:47:19 PM ******/
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
/****** Object:  Table [dbo].[DonDH]    Script Date: 12/9/2015 5:47:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonDH](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NgayDat] [datetime] NOT NULL,
	[NgayGiao] [datetime] NOT NULL,
	[TongTien] [float] NOT NULL,
	[HoTen] [nvarchar](200) NOT NULL,
	[DiaChi] [nvarchar](200) NOT NULL,
	[DienThoai] [nchar](11) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[Id_TinhTrang] [int] NOT NULL,
	[Id_NguoiDung] [int] NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_DonDH] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 12/9/2015 5:47:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MatKhau] [nvarchar](max) NOT NULL,
	[Id_Quyen] [int] NOT NULL,
	[HoTen] [nvarchar](200) NOT NULL,
	[DiaChi] [nvarchar](200) NOT NULL,
	[DienThoai] [nchar](11) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[KichHoat] [int] NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_NguoiDung] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 12/9/2015 5:47:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenNhaCC] [nvarchar](200) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhieuNhap]    Script Date: 12/9/2015 5:47:19 PM ******/
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
/****** Object:  Table [dbo].[Quyen]    Script Date: 12/9/2015 5:47:19 PM ******/
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
/****** Object:  Table [dbo].[SanPham]    Script Date: 12/9/2015 5:47:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenSP] [nvarchar](200) NOT NULL,
	[Id_NCC] [int] NOT NULL,
	[HDD] [nvarchar](200) NOT NULL,
	[RAM] [nvarchar](200) NOT NULL,
	[CPU] [nvarchar](200) NOT NULL,
	[DonGia] [nvarchar](53) NOT NULL,
	[HinhAnh] [nchar](200) NOT NULL,
	[BaoHanh] [nvarchar](200) NOT NULL,
	[LuotXem] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_SanPham] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TinhTrangDonDH]    Script Date: 12/9/2015 5:47:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhTrangDonDH](
	[Id] [int] NOT NULL,
	[TinhTrang] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_TinhTrangDonDH] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TonKho]    Script Date: 12/9/2015 5:47:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TonKho](
	[NgayThang] [datetime] NOT NULL,
	[Id_SP] [int] NOT NULL,
	[SoLuongTon] [int] NOT NULL,
 CONSTRAINT [PK_TonKho] PRIMARY KEY CLUSTERED 
(
	[NgayThang] ASC,
	[Id_SP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
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
USE [master]
GO
ALTER DATABASE [LTHD_WebLaptop] SET  READ_WRITE 
GO
