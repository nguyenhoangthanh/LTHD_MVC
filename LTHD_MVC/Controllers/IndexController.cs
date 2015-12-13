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

        public ActionResult Index(int Id_NCC = 0)
        {
            if (Id_NCC == 0)
            {
                List<SanPham> listsp = new List<SanPham>();
                listsp = db.SanPham.ToList();
                ViewBag.ListSP = listsp;
            }
            else
            {

                List<SanPham> listspnsx = new List<SanPham>();
                List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.ToList();
                listspnsx = db.SanPham.Where(p => p.Id_NCC == Id_NCC && p.TrangThai == 1).ToList();
                ViewBag.ListSP = listspnsx.ToList();
                ViewBag.ListNhaCungCap = ListNhaCungCap.ToList();
            }
            return View();
        }
        public ActionResult ChiTietSanPham(int Id)
        {
            SanPham listsp = new SanPham();
            listsp = db.SanPham.Find(Id);
            ViewBag.ListSP = listsp;
            return View();
        }
        public ActionResult ThemVaoGioHang(int Id)
        {
            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    List<GioHang> listgiohang = new List<GioHang>();
                    SanPham sp = db.SanPham.Find(Id);
                    if (Session["listgiohang"] == null)  // có 1 sản phẩm trong giỏ
                    {
                        GioHang gh = new GioHang();
                        gh.Id = sp.Id;
                        gh.TenSanPham = sp.TenSP.ToString();
                        gh.DonGia = sp.DonGia;
                        gh.SoLuong = 1;
                        gh.ThanhTien = gh.DonGia * gh.SoLuong;
                        listgiohang.Add(gh);
                        Session["listgiohang"] = listgiohang;
                    }
                    else
                    {
                        listgiohang = (List<GioHang>)Session["listgiohang"];
                        GioHang gh = listgiohang.Where(g => g.Id == Id).FirstOrDefault(); // không có sản phẩm trùng trong giỏ
                        if (gh == null)
                        {
                            gh = new GioHang();
                            gh.Id = sp.Id;
                            gh.TenSanPham = sp.TenSP.ToString();
                            gh.DonGia = sp.DonGia;
                            gh.SoLuong = 1;
                            gh.ThanhTien = gh.DonGia * gh.SoLuong;
                            listgiohang.Add(gh);
                            Session["listgiohang"] = listgiohang;
                        }
                        else
                        {
                            listgiohang.Where(g => g.Id == Id).FirstOrDefault().SoLuong = listgiohang.Where(g => g.Id == Id).FirstOrDefault().SoLuong + 1;
                            listgiohang.Where(g => g.Id == Id).FirstOrDefault().DonGia = sp.DonGia;
                            listgiohang.Where(g => g.Id == Id).FirstOrDefault().ThanhTien = sp.DonGia * (listgiohang.Where(g => g.Id == Id).FirstOrDefault().SoLuong);
                            Session["listgiohang"] = listgiohang;
                        }
                    }
                }
            }
            catch
            {

            }
            return RedirectToAction("GioHang");
        }
        public ActionResult GioHang()
        {
            return View();
        }

        public ActionResult XoaGioHang(int Id)
        {
            try
            {
                List<GioHang> listgiohang = (List<GioHang>)Session["listgiohang"];
                GioHang gh = listgiohang.Where(g => g.Id == Id).FirstOrDefault();
                listgiohang.Remove(gh);
                Session["listgiohang"] = listgiohang; 
            }
            catch
            {

            }
            return RedirectToAction("GioHang");
        }

        public ActionResult DangKy()
        {
            return View();
        }
        public ActionResult Thoat()
        {
            Session["HoTen"] = null;
            Session["Email"] = null;
            return RedirectToAction("Index");
        }
        public int XuLyDangKy(FormCollection fc)
        {
            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
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
                    return 1;
                }
            }
            catch
            {
                return -1;
            }
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
            List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.ToList();
            listspnsx = db.SanPham.Where(p => p.Id_NCC == Id_NCC && p.TrangThai == 1).ToList();
            ViewBag.ListSP = listspnsx.ToList();
            ViewBag.ListNhaCungCap = ListNhaCungCap.ToList();
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