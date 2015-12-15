USE [LTHD_WebLaptop]
GO
/****** Object:  StoredProcedure [dbo].[ThongKe]    Script Date: 12/15/2015 17:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Nguyen Thi Quynh>
-- Create date: <15/12/2015>
-- Description:	<Thong ke so luong ton>
-- =============================================
ALTER PROCEDURE [dbo].[ThongKe]
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

