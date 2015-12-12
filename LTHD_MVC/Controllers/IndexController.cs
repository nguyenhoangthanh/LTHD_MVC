using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LTHD_MVC.Models;
using System.Web.Security;
using LTHD_MVC.SessionCode;
using System.Data.Entity;
using LTHD_MVC.Helper;
namespace LTHD_MVC.Controllers
{
    public class IndexController : Controller
    {
        private LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities();
        Helper.Helper hp = new Helper.Helper();

        public ActionResult Index()
        {
            List<SanPham> listsp = new List<SanPham>();
            listsp = db.SanPham.ToList();
            ViewBag.ListSP = listsp;
            return View();
        }
        public ActionResult ChiTietSanPham(int Id)
        {
            SanPham listsp = new SanPham();
            listsp = db.SanPham.Find(Id);
            ViewBag.ListSP = listsp;
            return View();
        }
        public ActionResult GioHang()
        {
            return View();
        }

        public ActionResult DangKy()
        {
            return View();
        }
        public ActionResult Thoat()
        {
            Session["HoTen"] = "";
            return RedirectToAction("Index");
        }

        public ActionResult XuLyDangKy(FormCollection fc)
        {
            NguoiDung user = new NguoiDung();
            user.HoTen = fc["HoTen"].ToString();
            user.MatKhau = fc["MatKhau"].ToString();
            user.DiaChi = fc["DiaChi"].ToString();
            user.DienThoai = fc["DienThoai"].ToString();
            user.Email = fc["Email"].ToString();
            user.TrangThai = 1;
            user.KichHoat = 1;
            db.NguoiDung.Add(user);
            db.SaveChanges();
            return RedirectToAction("DangKyThanhCong");       
        }
        public ActionResult DangKyThanhCong()
        {
            return View();
        }
        public ActionResult DangNhap(FormCollection fc)
        {
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                string email = fc["Email"].ToString();
                string matkhau = fc["MatKhau"].ToString();
                NguoiDung nd = db.NguoiDung.Where(i => i.Email == email && i.MatKhau == matkhau).FirstOrDefault();
                if (nd == null)
                {
                    Response.Write("<script> alert('Tên người dùng hoặc mật khẩu không chính xác'); </script>");
                }
                else
                {
                    Session["HoTen"] = nd.HoTen;
                    Session["Email"] = nd.Email;
                }
                
            }
            return RedirectToAction("Index");
        }

        public ActionResult HienThiSPNhaSX(int Id_NCC)
        {
            List<SanPham> listspnsx = new List<SanPham>();
            listspnsx = db.SanPham.Where(p => p.Id_NCC == Id_NCC && p.TrangThai == 1).ToList();
            ViewBag.ListSP = listspnsx;
            return View();
        }
        public ActionResult BaoHanh()
        {
            return View();
        }

        public ActionResult LienHe()
        {
            return View();
        }
        public ActionResult GioiThieu()
        {
            return View();
        }
    }

}