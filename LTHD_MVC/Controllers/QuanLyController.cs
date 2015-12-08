using LTHD_MVC.Models;
using System;
using System.Collections.Generic;
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
