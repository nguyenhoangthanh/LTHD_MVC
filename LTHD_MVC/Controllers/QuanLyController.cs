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
        public ActionResult ThongKe()
        {
            return View();
        }

        #region Đăng nhập
        public bool KiemTraDangNhap()
        {
            Session["Path_URL"] = Path.GetFileName(Request.Url.AbsolutePath);
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
        public int XuLyDangNhap(FormCollection fc)
        {
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                string email = fc["email"].ToString();
                string password = fc["password"].ToString();
                NguoiDung nd = db.NguoiDung.Where(i => i.Email == email && i.MatKhau == password).FirstOrDefault();
                if (nd == null)
                {
                    return -1;
                }
                else
                {
                    Session["Admin_Email"] = email;
                    return 1;
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
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.ToList();
                ViewBag.ListNhaCungCap = ListNhaCungCap;
            }
            return View();
        }

        public int XuLyThemSanPham(FormCollection fc)
        {
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
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.Where(i => i.TrangThai == 1).ToList();
                ViewBag.ListNhaCungCap = ListNhaCungCap;
            }
            return View();
        }

        public ActionResult ThemNhaCungCap()
        {
            return View();
        }

        public int XuLyThemNhaCungCap(FormCollection fc)
        {
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
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                NhaCungCap ncc = db.NhaCungCap.Find(ID);
                ViewBag.NhaCungCap = ncc;
            }
            return View();
        }

        public int XuLyCapNhatNhaCungCap(FormCollection fc)
        {
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
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<Quyen> ListQuyen = db.Quyen.ToList();
                ViewBag.ListQuyen = ListQuyen;
            }
            return View();
        }

        public int XuLyThemNguoiDung(FormCollection fc)
        {
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
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                NhaCungCap ncc = db.NhaCungCap.Find(ID);
                ViewBag.NhaCungCap = ncc;
            }
            return View();
        }

        public int XuLyCapNhatNguoiDung(FormCollection fc)
        {
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
        public ActionResult PhieuNhap()
        {
            return View();
        }
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
