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
                NguoiDung nd = db.NguoiDung.Where(i => i.Email == email && i.MatKhau == password).FirstOrDefault();
                if (nd == null)
                {
                    return "-1";
                }
                else
                {
                    Session["Admin_Email"] = email;
                    Session["Admin_Hoten"] = nd.HoTen;
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
                List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.ToList();
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
                    sp.SoLuong = Int32.Parse(fc["soluong"].ToString());
                    sp.TrangThai = 1;

                    db.SanPham.Add(sp);
                    db.SaveChanges();

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
                    sp.SoLuong = Int32.Parse(fc["soluong"].ToString());

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
            }
            return View();
        }

        public ActionResult ThemNguoiDung()
        {
            if (!KiemTraDangNhap())
                return RedirectToAction("DangNhap");

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<Quyen> ListQuyen = db.Quyen.ToList();
                ViewBag.ListQuyen = ListQuyen;
            }
            return View();
        }

        public int XuLyThemNguoiDung(FormCollection fc)
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

        public ActionResult CapNhatNguoiDung(int ID)
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

        public int XuLyCapNhatNguoiDung(FormCollection fc)
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

        public int XuLyXoaNguoiDung(int id)
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
                    pn.SanPham = db.SanPham.Find(Int32.Parse(fc["sanpham"].ToString()));
                    pn.NgayNhap = Convert.ToDateTime(fc["ngaynhap"].ToString());
                    pn.SoLuong = Int32.Parse(fc["soluong"].ToString());
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
        public ActionResult DonDatHang()
        {
            return View();
        }
        public ActionResult TonKho()
        {
            return View();
        }
    }
}
