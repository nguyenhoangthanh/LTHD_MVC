USE [LTHD_WebLaptop]
GO
/****** Object:  StoredProcedure [dbo].[ThongKe]    Script Date: 15/12/2015 01:37:18 ******/
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
	@IDSanPham int = -1,
	@Thang int,
	@Nam int
AS
BEGIN
	select A.Id, A.TenSP, SUM(A.SoLuongNhap) AS SoLuongNhap, SUM(A.SoLuongXuat) AS SoLuongXuat, A.NgayThang from (
		select sp.Id, sp.TenSP, SUM(pn.SoLuong) AS SoLuongNhap, 0 AS SoLuongXuat, convert(varchar(5),@Thang) + '/' + convert(varchar(5),@Nam) AS NgayThang 
		from PhieuNhap pn JOIN SanPham sp ON pn.Id_SP = sp.Id
		where (pn.Id_SP = @IDSanPham OR @IDSanPham = -1) and DATEPART(mm,pn.NgayNhap) = @Thang and DATEPART(yyyy,pn.NgayNhap) = @Nam
		group by sp.Id, sp.TenSP
		union all
		select sp.Id, sp.TenSP, 0 AS SoLuongNhap, SUM(ct.SoLuong) AS SoLuongXuat, convert(varchar(5),@Thang) + '/' + convert(varchar(5),@Nam) AS NgayThang
		from DonDH ddh JOIN CT_DonDH ct ON ddh.Id = ct.Id_DonDH JOIN SanPham sp ON ct.Id_SP = sp.Id
		where (ct.Id_SP = @IDSanPham OR @IDSanPham = -1) and DATEPART(mm,ddh.NgayDat) = @Thang and DATEPART(yyyy,ddh.NgayDat) = @Nam
		group by sp.Id, sp.TenSP
	)A
	group by A.Id, A.TenSP, A.NgayThang
END

GO
/****** Object:  Table [dbo].[CT_DonDH]    Script Date: 15/12/2015 01:37:18 ******/
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
/****** Object:  Table [dbo].[DonDH]    Script Date: 15/12/2015 01:37:18 ******/
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
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 15/12/2015 01:37:18 ******/
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
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 15/12/2015 01:37:18 ******/
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
/****** Object:  Table [dbo].[PhieuNhap]    Script Date: 15/12/2015 01:37:18 ******/
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
/****** Object:  Table [dbo].[Quyen]    Script Date: 15/12/2015 01:37:18 ******/
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
/****** Object:  Table [dbo].[SanPham]    Script Date: 15/12/2015 01:37:18 ******/
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
/****** Object:  Table [dbo].[TinhTrangDonDH]    Script Date: 15/12/2015 01:37:18 ******/
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
/****** Object:  Table [dbo].[TonKho]    Script Date: 15/12/2015 01:37:18 ******/
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

INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (4, CAST(0x39390B00 AS Date), CAST(0x3E390B00 AS Date), 42000000, N'dadsds', N'dadsada', N'01234567892', N'Gọi trước khi giao hàng', 1, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (5, CAST(0x39390B00 AS Date), CAST(0x3E390B00 AS Date), 24000000, N'b', N'bbbb', N'43243243222', N'fsdfsdf', 2, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (6, CAST(0x3A390B00 AS Date), CAST(0x3F390B00 AS Date), 78500000, N'Phan Thanh Minh', N'123 Nguyễn Du', N'01231231232', N'Giao hàng buổi trưa', 1, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (7, CAST(0x3A390B00 AS Date), CAST(0x41390B00 AS Date), 24000000, N'asdasdasasd', N'adasdasdas', N'23321312314', N'dasdasdasdas', 0, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (8, CAST(0x58390B00 AS Date), CAST(0x59390B00 AS Date), 14000000, N'aaaa', N'bbbb', N'01212411412', N'rewrewrewr', 1, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (9, CAST(0x59390B00 AS Date), CAST(0x42390B00 AS Date), 28000000, N'Lê Thanh Bình', N'123 Nguyễn Du', N'01231231237', N'rewrewrewr', 2, 0, 1)
INSERT [dbo].[DonDH] ([Id], [NgayDat], [NgayGiao], [TongTien], [HoTen], [DiaChi], [DienThoai], [GhiChu], [Id_TinhTrang], [Id_NguoiDung], [TrangThai]) VALUES (10, CAST(0x3D390B00 AS Date), CAST(0x3D390B00 AS Date), 50000000, N'Nguyễn Minh Anh', N'23 Lê Lai', N'01223314656', N'Giao hàng gọi trước', 0, 17, 1)
SET IDENTITY_INSERT [dbo].[DonDH] OFF
SET IDENTITY_INSERT [dbo].[NguoiDung] ON 

INSERT [dbo].[NguoiDung] ([Id], [MatKhau], [Id_Quyen], [HoTen], [DiaChi], [DienThoai], [Email], [KichHoat], [TrangThai]) VALUES (14, N'123456', 2, N'Nguyễn Thị Quỳnh', N'Nguyễn Trãi', N'01135453215', N'nguyenthiquynh.1112@gmail.com', 1, 1)
INSERT [dbo].[NguoiDung] ([Id], [MatKhau], [Id_Quyen], [HoTen], [DiaChi], [DienThoai], [Email], [KichHoat], [TrangThai]) VALUES (15, N'123456', 1, N'Văn Quốc Phát', N'123 Nguyễn Trãi', N'01234561231', N'dtphong@gmail.com', 1, 1)
INSERT [dbo].[NguoiDung] ([Id], [MatKhau], [Id_Quyen], [HoTen], [DiaChi], [DienThoai], [Email], [KichHoat], [TrangThai]) VALUES (28, N'1234', 0, N'sfsdf', N'sdfsd', N'221        ', N'21221', 1, 0)
INSERT [dbo].[NguoiDung] ([Id], [MatKhau], [Id_Quyen], [HoTen], [DiaChi], [DienThoai], [Email], [KichHoat], [TrangThai]) VALUES (29, N'123456', 2, N'Nguyễn Hoàng Thanh', N'Huỳnh Tấn Phát', N'01694466134', N'thanh@gmail.com', 1, 1)
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

INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (1, CAST(0x0000A3E100000000 AS DateTime), 1, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (4, CAST(0x0000A3E100000000 AS DateTime), 2, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (5, CAST(0x0000A3E100000000 AS DateTime), 3, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (6, CAST(0x0000A3E100000000 AS DateTime), 4, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (7, CAST(0x0000A3FE00000000 AS DateTime), 5, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (8, CAST(0x0000A3E100000000 AS DateTime), 6, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (9, CAST(0x0000A3E100000000 AS DateTime), 7, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (10, CAST(0x0000A3E100000000 AS DateTime), 8, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (11, CAST(0x0000A3E100000000 AS DateTime), 9, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (12, CAST(0x0000A3FE00000000 AS DateTime), 10, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (13, CAST(0x0000A3E100000000 AS DateTime), 20, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (14, CAST(0x0000A3E100000000 AS DateTime), 21, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (15, CAST(0x0000A3E100000000 AS DateTime), 22, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (16, CAST(0x0000A3FE00000000 AS DateTime), 23, 10)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (17, CAST(0x0000A3E700000000 AS DateTime), 1, 15)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (18, CAST(0x0000A3E100000000 AS DateTime), 1, 5)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (19, CAST(0x0000A57100000000 AS DateTime), 35, 20)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (20, CAST(0x0000A54E00000000 AS DateTime), 5, 100)
INSERT [dbo].[PhieuNhap] ([Id_PhieuNhap], [NgayNhap], [Id_SP], [SoLuong]) VALUES (21, CAST(0x0000A56B00000000 AS DateTime), 24, 100)
SET IDENTITY_INSERT [dbo].[PhieuNhap] OFF
INSERT [dbo].[Quyen] ([Id], [TenQuyen]) VALUES (0, N'User      ')
INSERT [dbo].[Quyen] ([Id], [TenQuyen]) VALUES (1, N'Admin     ')
INSERT [dbo].[Quyen] ([Id], [TenQuyen]) VALUES (2, N'SuperAdmin')
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (1, N'Acer 01', 6, N'500GB', N'4GB', N'Intel Core I7', 12500000, N'acer_01.jpg         ', N'12 tháng', 11, 0, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (2, N'Acer 02', 6, N'500GB', N'4GB', N'Intel Core I3', 10000000, N'acer_02.jpg         ', N'12 tháng', 23, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (3, N'HP 01', 1, N'500GB', N'4GB', N'Intel Core I5', 14000000, N'hp_01.jpg           ', N'12 tháng', 5, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (4, N'HP 02', 1, N'500GB', N'2GB', N'Intel Core I3', 13500000, N'hp_02.jpg           ', N'12 tháng', 4, 0, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (5, N'Dell 01', 2, N'500GB', N'4GB', N'Intel Core I5', 14000000, N'dell_01.jpg         ', N'12 tháng', 5, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (6, N'Dell 02', 2, N'500GB', N'4GB', N'Intel Core I3', 15000000, N'dell_02.jpg         ', N'12 tháng', 2, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (7, N'Dell 03', 2, N'500GB', N'2GB', N'Intel Core I5', 14500000, N'dell_03.jpg         ', N'12 tháng', 1, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (8, N'Samsung 01', 4, N'500GB', N'4GB', N'Intel Core I3', 14000000, N'ss_01.jpg           ', N'12 tháng', 2, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (9, N'Samsung 02', 4, N'500GB', N'2GB', N'Intel Core I5', 10000000, N'ss_02.jpg           ', N'12 tháng', 4, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (10, N'Samsung 03', 4, N'500GB', N'4GB', N'Intel Core I3', 15500000, N'ss_03.jpg           ', N'12 tháng', 6, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (20, N'Dell 04', 2, N'500GB', N'4GB', N'Intel Core I3', 14500000, N'dell_04.jpg         ', N'12 tháng', 7, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (21, N'HP 03', 1, N'500GB', N'4GB', N'Intel Core I5', 15000000, N'hp_03.jpg           ', N'12 tháng', 8, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (22, N'Acer 03', 6, N'500GB', N'4GB', N'Intel Core I5', 16000000, N'acer_03.jpg         ', N'12 tháng', 4, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (23, N'Dell 05', 2, N'500GB', N'4GB', N'Intel Core I3', 13500000, N'dell_05.jpg         ', N'12 tháng', 9, 10, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (24, N'Nguyễn Hoàng Thanh', 2, N'500', N'4', N'Intel Core I5', 1000000, N'avatar_2015_12_10_22_46_50.png', N'12 tháng', 0, 100, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (25, N'thanhzzzzzzzzzzzzzzzzz', 6, N'22', N'2', N'2222222222', 222222, N'avatar5_2015_12_09_00_33_19.png', N'22 tháng', 0, 222, 0)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (26, N'thanh', 8, N'5', N'5', N'sdd7s', 5, N'profile-pic_2015_12_09_22_39_07.jpg', N'4 tháng', 0, 4, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (27, N'Hoàng Thanh', 4, N'6', N'6', N'8asjaj', 7, N'avatar4_2015_12_09_23_38_49.png', N'13 tháng', 0, 25, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (28, N'sasasd', 1, N'1', N'1', N'dsasda', 1, N'avatar2_2015_12_09_23_43_31.png', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (29, N'quỳnh', 2, N'9', N'6', N'8sdisa', 6, N'avatar1_2015_12_09_23_44_53.png', N'5 tháng', 0, 5, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (30, N'dsaasddsa', 1, N'1', N'1', N'dadsadsa', 1, N'avatar_2015_12_09_23_48_17.png', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (31, N'dsasda', 1, N'1', N'1', N'dsassad', 1, N'avatar_2015_12_09_23_50_11.png', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (32, N'dsasddas', 1, N'1', N'1', N'dasdsa', 1, N'avatar_2015_12_09_23_52_30.png', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (33, N'ddsda', 1, N'1', N'1', N'adsdsa', 1, N'avatar4_2015_12_09_23_53_43.png', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (34, N'sasad', 1, N'1', N'1', N'sdasda', 1, N'avatar5_2015_12_09_23_54_44.png', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (35, N'4453', 6, N'1', N'1', N'fdsfds', 3234, N'avatar_2015_12_09_23_55_14.png', N'12 tháng', 0, 1333, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (36, N'dsdsaa', 1, N'1', N'1', N'dasads', 1, N'avatar_2015_12_09_23_56_11.png', N'1 tháng', 0, 1, 1)
INSERT [dbo].[SanPham] ([Id], [TenSP], [Id_NCC], [HDD], [RAM], [CPU], [DonGia], [HinhAnh], [BaoHanh], [LuotXem], [SoLuong], [TrangThai]) VALUES (37, N'testdell', 2, N'9', N'9', N'8888', 7, N'avatar4_2015_12_10_23_07_22.png', N'12 tháng', 0, 122, 1)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
INSERT [dbo].[TinhTrangDonDH] ([Id], [TinhTrang]) VALUES (0, N'Chưa giao')
INSERT [dbo].[TinhTrangDonDH] ([Id], [TinhTrang]) VALUES (1, N'Đã giao ')
INSERT [dbo].[TinhTrangDonDH] ([Id], [TinhTrang]) VALUES (2, N'Đã hủy')
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(0x1B390B00 AS Date), 1, 12)
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(0x1B390B00 AS Date), 2, 10)
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(0x1B390B00 AS Date), 3, 5)
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(0x1B390B00 AS Date), 4, 7)
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(0x1B390B00 AS Date), 5, 10)
INSERT [dbo].[TonKho] ([NgayThang], [Id_SP], [SoLuongTon]) VALUES (CAST(0x1B390B00 AS Date), 6, 20)
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
