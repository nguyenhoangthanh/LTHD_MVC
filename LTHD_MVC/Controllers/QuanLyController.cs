using LTHD_MVC.Helper;
using LTHD_MVC.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace LTHD_MVC.Controllers
{
    public class QuanLyController : Controller
    {
        #region Thống kê
        public ActionResult ThongKe()
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            return View();
        }
        #endregion Thống kê
        
        #region Thoát
        public ActionResult Thoat(){
            Session["Admin_Email"] = null;
            return RedirectToAction("DangNhap");
        }
        #endregion Thoát

        #region Đăng nhập
        public bool KiemTraDangNhap()
        {
            Session["Path_URL"] = Request.Url.AbsolutePath;
            if (Session["Admin_Email"] == null)
            {
                return false;
            }
            return true;
        }
        public ActionResult DangNhap()
        {
            return View();
        }
        public string XuLyDangNhap(FormCollection fc)
        {
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                string email = fc["email"].ToString();
                string password = fc["password"].ToString();
                NguoiDung nd = db.NguoiDung.Where(i => i.Email == email && i.MatKhau == password && i.TrangThai == 1 && i.Id_Quyen > 0).FirstOrDefault();
                if (nd == null)
                {
                    return "-1";
                }
                else
                {
                    Session["Admin_Email"] = email;
                    Session["Admin_Hoten"] = nd.HoTen;
                    Session["Admin_Quyen"] = nd.Id_Quyen;
                    if (Session["Path_URL"] == null)
                        Session["Path_URL"] = "/QuanLy";
                    return Session["Path_URL"].ToString();
                }
            }
        }
        #endregion Đăng nhập

        #region Sản phẩm
        public ActionResult SanPham()
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<SanPham> ListSanPham = db.SanPham.Where(i => i.TrangThai == 1).ToList();
                List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.Where(a => a.TrangThai == 1) .ToList();
                ViewBag.ListSanPham = ListSanPham;
                ViewBag.ListNhaCungCap = ListNhaCungCap;
            }
            return View();
        }

        public ActionResult ThemSanPham()
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.ToList();
                ViewBag.ListNhaCungCap = ListNhaCungCap;
            }
            return View();
        }

        public int XuLyThemSanPham(FormCollection fc)
        {
            if (!KiemTraDangNhap())
                return -1;
            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    SanPham sp = new SanPham();
                    sp.TenSP = fc["tensanpham"].ToString();
                    sp.NhaCungCap = db.NhaCungCap.Find(Int32.Parse(fc["nhacungcap"].ToString()));
                    sp.HDD = fc["hdd"].ToString();
                    sp.RAM = fc["ram"].ToString();
                    sp.CPU = fc["cpu"].ToString();
                    sp.DonGia = Double.Parse(fc["dongia"].ToString());

                    HttpPostedFileBase hinh = Request.Files["hinh"];
                    if ((hinh != null) && (hinh.ContentLength > 0) && !string.IsNullOrEmpty(hinh.FileName))
                    {
                        string fileName = StringHelper.DoiTenFile(hinh.FileName);
                        hinh.SaveAs(Server.MapPath("/Hinh/MayTinh/sanpham/" + fileName));
                        sp.HinhAnh = fileName;
                    }
                    sp.BaoHanh = fc["baohanh"].ToString() + " tháng";
                    sp.SoLuong = 0; // Int32.Parse(fc["soluong"].ToString());
                    sp.TrangThai = 1;

                    db.SanPham.Add(sp);
                    db.SaveChanges();

                    //PhieuNhap pn = new PhieuNhap();
                    //pn.SanPham = sp;
                    //pn.NgayNhap = DateTime.Now;
                    //pn.SoLuong = sp.SoLuong;

                    //db.PhieuNhap.Add(pn);
                    //db.SaveChanges();

                    return 1;
                }
            }
            catch
            {
                return -1;
            }
        }

        public ActionResult ChiTietSanPham(int ID)
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                SanPham sp = db.SanPham.Find(ID);
                ViewBag.SanPham = sp;
                ViewBag.TenNhaCC = sp.NhaCungCap.TenNhaCC;
            }
            return View();
        }

        public ActionResult CapNhatSanPham(int ID)
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                SanPham sp = db.SanPham.Find(ID);
                ViewBag.SanPham = sp;

                List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.ToList();
                ViewBag.ListNhaCungCap = ListNhaCungCap;
            }
            return View();
        }

        public int XuLyCapNhatSanPham(FormCollection fc)
        {
            if (!KiemTraDangNhap())
                return -1;

            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    SanPham sp = db.SanPham.Find(Int32.Parse(fc["idsanpham"].ToString()));
                    sp.TenSP = fc["tensanpham"].ToString();
                    sp.NhaCungCap = db.NhaCungCap.Find(Int32.Parse(fc["nhacungcap"].ToString()));
                    sp.HDD = fc["hdd"].ToString();
                    sp.RAM = fc["ram"].ToString();
                    sp.CPU = fc["cpu"].ToString();
                    sp.DonGia = Double.Parse(fc["dongia"].ToString());

                    HttpPostedFileBase hinh = Request.Files["hinh"];
                    if ((hinh != null) && (hinh.ContentLength > 0) && !string.IsNullOrEmpty(hinh.FileName))
                    {
                        string fileName = StringHelper.DoiTenFile(hinh.FileName);
                        hinh.SaveAs(Server.MapPath("/Hinh/MayTinh/sanpham/" + fileName));
                        sp.HinhAnh = fileName;
                    }
                    sp.BaoHanh = fc["baohanh"].ToString() + " tháng";
                    //sp.SoLuong = Int32.Parse(fc["soluong"].ToString());

                    db.SaveChanges();

                    return 1;
                }
            }
            catch
            {
                return -1;
            }
        }

        public int XuLyXoaSanPham(int id)
        {
            if (!KiemTraDangNhap())
                return -1;

            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    SanPham sp = db.SanPham.Find(id);
                    sp.TrangThai = 0;
                    db.SaveChanges();
                    return 1;
                }
            }
            catch
            {
                return -1;
            }
        }
        #endregion Sản phẩm

        #region Nhà cung cấp
        public ActionResult NhaCungCap()
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.Where(i => i.TrangThai == 1).ToList();
                ViewBag.ListNhaCungCap = ListNhaCungCap;
            }
            return View();
        }

        public ActionResult ThemNhaCungCap()
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            return View();
        }

        public int XuLyThemNhaCungCap(FormCollection fc)
        {
            if (!KiemTraDangNhap())
                return -1;

            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    // check trùng tên
                    string tennhacungcap = fc["tennhacungcap"].ToString();
                    NhaCungCap _ncc = db.NhaCungCap.Where(i => i.TenNhaCC == tennhacungcap && i.TrangThai == 1).FirstOrDefault();
                    if (_ncc == null)
                    {
                        _ncc = db.NhaCungCap.Where(i => i.TenNhaCC == tennhacungcap && i.TrangThai == 0).FirstOrDefault();
                        if (_ncc == null)
                        {
                            NhaCungCap ncc = new NhaCungCap();
                            ncc.TenNhaCC = tennhacungcap;
                            ncc.TrangThai = 1;

                            db.NhaCungCap.Add(ncc);
                            db.SaveChanges();

                            return 1;
                        }
                        else
                        {
                            _ncc.TrangThai = 1;
                            db.SaveChanges();
                            return 1;
                        }
                    }
                    else
                    {
                        return -2;
                    }
                }
            }
            catch
            {
                return -1;
            }
        }

        public ActionResult CapNhatNhaCungCap(int ID)
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                NhaCungCap ncc = db.NhaCungCap.Find(ID);
                ViewBag.NhaCungCap = ncc;
            }
            return View();
        }

        public int XuLyCapNhatNhaCungCap(FormCollection fc)
        {
            if (!KiemTraDangNhap())
                return -1;

            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    // check trùng tên
                    string tennhacungcap = fc["tennhacungcap"].ToString();
                    NhaCungCap _ncc = db.NhaCungCap.Where(i => i.TenNhaCC == tennhacungcap).FirstOrDefault();
                    if (_ncc == null)
                    {
                        NhaCungCap ncc = db.NhaCungCap.Find(Int32.Parse(fc["idnhacungcap"].ToString()));
                        ncc.TenNhaCC = tennhacungcap;
                        db.SaveChanges();
                        return 1;
                    }
                    else
                    {
                        return -2;
                    }
                }
            }
            catch
            {
                return -1;
            }
        }

        public int XuLyXoaNhaCungCap(int id)
        {
            if (!KiemTraDangNhap())
                return -1;

            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    NhaCungCap ncc = db.NhaCungCap.Find(id);
                    ncc.TrangThai = 0;
                    db.SaveChanges();
                    return 1;
                }
            }
            catch
            {
                return -1;
            }
        }
        #endregion Nhà cung cấp

        #region Người dùng
        public ActionResult NguoiDung()
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<NguoiDung> ListNguoiDung = db.NguoiDung.Where(i => i.TrangThai == 1).ToList();
                ViewBag.ListNguoiDung = ListNguoiDung;

                List<Quyen> ListQuyen = db.Quyen.ToList();
                ViewBag.ListQuyen = ListQuyen;

                string admin_email = Session["Admin_Email"].ToString();

                NguoiDung nd = db.NguoiDung.Where(i => i.Email == admin_email).FirstOrDefault();
                ViewBag.UserLogin = nd;
            }
            return View();
        }

        public ActionResult CapNhatNguoiDung(int ID)
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                NguoiDung nd = db.NguoiDung.Find(ID);
                ViewBag.NguoiDung = nd;

                List<Quyen> ListQuyen = db.Quyen.ToList();
                ViewBag.ListQuyen = ListQuyen;
            }

            return View();
        }

        public int XuLyCapNhatNguoiDung(FormCollection fc)
        {
            if (!KiemTraDangNhap())
                return -1;

            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    NguoiDung nd = db.NguoiDung.Find(Int32.Parse(fc["idnguoidung"].ToString()));
                    nd.HoTen = fc["hoten"].ToString();
                    nd.DiaChi = fc["diachi"].ToString();
                    nd.DienThoai = fc["dienthoai"].ToString();
                    nd.MatKhau = fc["matkhau"].ToString() == "" ? nd.MatKhau : fc["matkhau"].ToString();
                    if (fc["quyen"] != null)
                    {
                        nd.Quyen = db.Quyen.Find(Int32.Parse(fc["quyen"].ToString()));
                    }

                    db.SaveChanges();
                    return 1;
                }
            }
            catch
            {
                return -1;
            }
        }

        public int XuLyXoaNguoiDung(int id)
        {
            if (!KiemTraDangNhap())
                return -1;
            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    NguoiDung nd = db.NguoiDung.Find(id);
                    nd.TrangThai = 0;
                    db.SaveChanges();
                    return 1;
                }
            }
            catch
            {
                return -1;
            }
        }
        #endregion Người dùng
        
        #region Phiếu nhập
        public ActionResult PhieuNhap()
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<SanPham> ListSanPham = db.SanPham.ToList();
                List<PhieuNhap> ListPhieuNhap = db.PhieuNhap.ToList();
                ViewBag.ListSanPham = ListSanPham;
                ViewBag.ListPhieuNhap = ListPhieuNhap;
            }
            return View();
        }

        public ActionResult ThemPhieuNhap()
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<SanPham> ListSanPham = db.SanPham.Where(i => i.TrangThai == 1).ToList();
                ViewBag.ListSanPham = ListSanPham;
            }
            return View();
        }

        public int XuLyThemPhieuNhap(FormCollection fc)
        {
            if (!KiemTraDangNhap())
                return -1;
            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    PhieuNhap pn = new PhieuNhap();
                    pn.NgayNhap = Convert.ToDateTime(fc["ngaynhap"].ToString());
                    pn.SanPham = db.SanPham.Find(Int32.Parse(fc["sanpham"].ToString()));
                    pn.SoLuong = int.Parse(fc["soluong"].ToString());

                    db.PhieuNhap.Add(pn);

                    pn.SanPham.SoLuong += pn.SoLuong;

                    db.SaveChanges();

                    return 1;
                }
            }
            catch
            {
                return -1;
            }
        }

        public ActionResult CapNhatPhieuNhap(int ID)
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                PhieuNhap pn = db.PhieuNhap.Find(ID);
                ViewBag.PhieuNhap = pn;

                List<SanPham> ListSanPham = db.SanPham.ToList();
                ViewBag.ListSanPham = ListSanPham;
            }
            return View();
        }

        public int XuLyCapNhatPhieuNhap(FormCollection fc)
        {
            if (!KiemTraDangNhap())
                return -1;

            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    PhieuNhap pn = db.PhieuNhap.Find(Int32.Parse(fc["idphieunhap"].ToString()));
                    int pnId_SP = pn.Id_SP;
                    int pnSoLuong = pn.SoLuong;
                    pn.SanPham = db.SanPham.Find(Int32.Parse(fc["sanpham"].ToString()));
                    pn.NgayNhap = Convert.ToDateTime(fc["ngaynhap"].ToString());
                    pn.SoLuong = Int32.Parse(fc["soluong"].ToString());

                    pn.SanPham.SoLuong += pn.SoLuong;

                    SanPham sp = db.SanPham.Find(pnId_SP);
                    sp.SoLuong = sp.SoLuong - pnSoLuong;

                    db.SaveChanges();

                    return 1;
                }
            }
            catch
            {
                return -1;
            }
        }

        public int XuLyXoaPhieuNhap(int id)
        {
            if (!KiemTraDangNhap())
                return -1;

            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    PhieuNhap pn = db.PhieuNhap.Find(id);
                    db.PhieuNhap.Remove(pn);
                    db.SaveChanges();
                    return 1;
                }
            }
            catch
            {
                return -1;
            }
        }
        #endregion Phiếu nhập

        #region Đơn đặt hàng
        public ActionResult DonDatHang()
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<DonDH> ListDonDH = db.DonDH.Where(i => i.TrangThai == 1).ToList();
                List<TinhTrangDonDH> ListTinhTrangDonDH = db.TinhTrangDonDH.ToList();
                ViewBag.ListDonDH = ListDonDH;
                ViewBag.ListTinhTrangDonDH = ListTinhTrangDonDH;
            }
            return View();
        }

        public ActionResult ChiTietDonDatHang(int ID)
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                DonDH ddh = db.DonDH.Find(ID);
                ViewBag.DonDH = ddh;
                ViewBag.TinhTrang = ddh.TinhTrangDonDH.TinhTrang;
                List<CT_DonDH> ListCT_DonDH = db.CT_DonDH.Where(i => i.Id_DonDH == ID).ToList();
                ViewBag.ListCT_DonDH = ListCT_DonDH;
                ViewBag.Total = db.CT_DonDH.Where(i => i.Id_DonDH == ID).Sum(i => i.DonGia * i.SoLuong);
                List<SanPham> ListSanPham = db.SanPham.ToList();
                ViewBag.ListSanPham = ListSanPham;
            }
            return View();
        }

        public int XuLyCapNhatDonDatHang(FormCollection fc)
        {
            if (!KiemTraDangNhap())
                return -1;

            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    DonDH dh = db.DonDH.Find(Int32.Parse(fc["id"].ToString()));
                    dh.TinhTrangDonDH = db.TinhTrangDonDH.Find(Int32.Parse(fc["tinhtrang"].ToString()));
                    db.SaveChanges();

                    return 1;
                }
            }
            catch
            {
                return -1;
            }
        }
        #endregion Đơn đặt hàng

        #region Tồn kho
        public ActionResult TonKho(FormCollection fc)
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            Session["ThongKe_sanpham"] = -1;
            Session["ThongKe_tungay"] = "";
            Session["ThongKe_denngay"] = "";

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<ThongKe_Result> ListThongKe = new List<ThongKe_Result>();
                List<SanPham> ListSanPham = new List<SanPham>();
                if (fc["sanpham"] != null && fc["tungay"] != null && fc["denngay"] != null)
                {
                    int sanpham = int.Parse(fc["sanpham"].ToString());
                    DateTime tungay = Convert.ToDateTime(fc["tungay"].ToString());
                    DateTime denngay = Convert.ToDateTime(fc["denngay"].ToString());

                    Session["ThongKe_sanpham"] = sanpham;
                    Session["ThongKe_tungay"] = tungay.ToString("yyyy-MM");
                    Session["ThongKe_denngay"] = denngay.ToString("yyyy-MM");

                    ListThongKe = db.ThongKe(sanpham, tungay, denngay).ToList();

                    if (fc["thongke"] == "Xuất báo cáo")
                    {
                        Export(ListThongKe);
                    }
                }
                ViewBag.ListThongKe = ListThongKe;

                ListSanPham = db.SanPham.ToList();
                ViewBag.ListSanPham = ListSanPham;
            }
            return View();
        }

        public void Export(List<ThongKe_Result> ListThongKe)
        {
            var grid = new System.Web.UI.WebControls.GridView();

            grid.DataSource = from tk in ListThongKe
                              select new
                              {
                                  IDSanPham = tk.Id_SP,
                                  TenSanPham = tk.TenSP,
                                  SoLuongNhap = tk.SoLuongNhap,
                                  SoLuongXuat = tk.SoLuongXuat,
                                  SoluongTon = tk.SoLuongNhap - tk.SoLuongXuat,
                                  NgayThang = tk.ThangNam,
                              };

            grid.DataBind();

            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment; filename=ThongKe.xls");
            Response.ContentType = "application/excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            grid.RenderControl(htw);

            Response.Write(sw.ToString());

            Response.End();

        }
        #endregion Tồn kho
        
    }
}
