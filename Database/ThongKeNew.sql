USE [LTHD_WebLaptop]
GO

/****** Object:  StoredProcedure [dbo].[ThongKe1]    Script Date: 15/12/2015 13:32:55 ******/
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


