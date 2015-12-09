using LTHD_MVC.Helper;
using LTHD_MVC.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Diagnostics;
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
        public ActionResult SanPham()
        {
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<SanPham> ListSanPham = db.SanPham.ToList();
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
                    sp.TrangThai = 1; // fc["trangthai"] == null ? 1 : 0;

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


        public ActionResult NhaCungCap()
        {
            return View();
        }
        public ActionResult NguoiDung()
        {
            return View();
        }
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
