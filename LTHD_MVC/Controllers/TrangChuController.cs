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
using PagedList;

namespace LTHD_MVC.Controllers
{
    public class TrangChuController : Controller
    {
        #region Layout
        public void Layout()
        {
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.ToList();
                ViewBag.ListNhaCungCap = ListNhaCungCap;
            }
        }
        #endregion Layout

        public ActionResult Index(int id = 0, int? page = 1)
        {
            Layout();
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<SanPham> ListSanPham = db.SanPham.Where(p => (p.Id_NCC == id || id == 0) && p.TrangThai == 1).ToList();
                var pageNumber = page ?? 1;
                var onePageOfProducts = ListSanPham.ToPagedList(pageNumber, 6);

                ViewBag.ListSanPham = onePageOfProducts;
            }
            return View();
        }
        public ActionResult ChiTietSanPham(int id)
        {
            Layout();
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                SanPham sp = db.SanPham.Find(id);
                ViewBag.SanPham = sp;
                ViewBag.TenNhaCC = sp.NhaCungCap.TenNhaCC;
            }
            return View();
        }
        
        [AllowAnonymous]
        public ActionResult ThemVaoGioHang(int id)
        {
            try
            {
                using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
                {
                    List<GioHang> listgiohang = new List<GioHang>();
                    SanPham sp = db.SanPham.Find(id);
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
                        Session["SoLuongSanPhamTrongGio"] = listgiohang.Count();
                        Session["TongTien"] = listgiohang.Sum(i => i.SoLuong * i.DonGia);
                    }
                    else
                    {
                        listgiohang = (List<GioHang>)Session["listgiohang"];
                        GioHang gh = listgiohang.Where(g => g.Id == id).FirstOrDefault(); // không có sản phẩm trùng trong giỏ
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
                            Session["SoLuongSanPhamTrongGio"] = listgiohang.Count();
                            Session["TongTien"] = listgiohang.Sum(i => i.SoLuong * i.DonGia);
                        }
                        else
                        {
                            listgiohang.Where(g => g.Id == id).FirstOrDefault().SoLuong = listgiohang.Where(g => g.Id == id).FirstOrDefault().SoLuong + 1;
                            listgiohang.Where(g => g.Id == id).FirstOrDefault().DonGia = sp.DonGia;
                            listgiohang.Where(g => g.Id == id).FirstOrDefault().ThanhTien = sp.DonGia * (listgiohang.Where(g => g.Id == id).FirstOrDefault().SoLuong);
                            Session["listgiohang"] = listgiohang;
                            Session["SoLuongSanPhamTrongGio"] = listgiohang.Count();
                            Session["TongTien"] = listgiohang.Sum(i => i.SoLuong * i.DonGia);
                        }
                    }
                }
            }
            catch
            {

            }
            return Redirect(Session["URL"].ToString());
        }
        public ActionResult GioHangCuaBan()
        {
            Layout();
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
                Session["SoLuongSanPhamTrongGio"] = listgiohang.Count();
                Session["TongTien"] = listgiohang.Sum(i => i.SoLuong * i.DonGia);
            }
            catch
            {

            }
            return RedirectToAction("GioHangCuaBan");
        }

        public ActionResult DangKy()
        {
            Layout();
            return View();
        }
        public int XuLyDangKy(FormCollection fc)
        {
            Layout();
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

        #region Đăng nhập
        public ActionResult DangNhap()
        {
            Layout();
            return View();
        }

        public string XuLyDangNhap(FormCollection fc)
        {
            string email = fc["email"].ToString();
            string password = fc["password"].ToString();
            string url = fc["url"].ToString();

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                NguoiDung nd = db.NguoiDung.Where(i => i.Email == email && i.MatKhau == password && i.KichHoat == 1 && i.TrangThai == 1).FirstOrDefault();
                if (nd == null)
                {
                    return "-1";
                }
                else
                {
                    Session["Id"] = nd.Id;
                    Session["HoTen"] = nd.HoTen;
                    Session["Email"] = nd.Email;
                    Session["DiaChi"] = nd.DiaChi;
                    Session["DienThoai"] = nd.DienThoai;
                }

            }
            return url;
        }
        #endregion Đăng nhập

        #region Đăng xuất
        public ActionResult Thoat()
        {
            Session["HoTen"] = null;
            Session["Email"] = null;
            return RedirectToAction("Index");
        }
        #endregion Đăng xuất

        public ActionResult HienThiSPNhaSX(int Id_NCC)
        {
            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                List<SanPham> listspnsx = new List<SanPham>();
                List<NhaCungCap> ListNhaCungCap = db.NhaCungCap.ToList();
                listspnsx = db.SanPham.Where(p => p.Id_NCC == Id_NCC && p.TrangThai == 1).ToList();
                ViewBag.ListSP = listspnsx.ToList();
                ViewBag.ListNhaCungCap = ListNhaCungCap.ToList();
            }
            return View();
        }

        public ActionResult DonHang(FormCollection fc)
        {
            if (fc["NgayDat"] == null)
            {
                return RedirectToAction("Index");
            }
            Layout();
            DateTime ngaydathang = Convert.ToDateTime(fc["NgayDat"].ToString());
            DateTime ngaygiaohang = Convert.ToDateTime(fc["NgayGiao"].ToString());
            double tongtien = double.Parse(Session["TongTien"].ToString());
            string ghichu = fc["GhiChu"].ToString();
            string hoten = fc["HoTen"].ToString();
            string diachi = fc["DiaChi"].ToString();
            string email = fc["Email"].ToString();
            string dienthoai = fc["DienThoai"].ToString();

            using (LTHD_WebLaptopEntities db = new LTHD_WebLaptopEntities())
            {
                DonDH ddh = new DonDH();
                ddh.NgayDat = ngaydathang;
                ddh.NgayGiao = ngaygiaohang;
                ddh.TongTien = tongtien;
                ddh.HoTen = hoten;
                ddh.DiaChi = diachi;
                ddh.DienThoai = dienthoai;
                ddh.GhiChu = ghichu;
                ddh.TinhTrangDonDH = db.TinhTrangDonDH.Find(0);
                if (Session["Id"] == null)
                {
                    ddh.Id_NguoiDung = 0;
                }
                else
                {
                    ddh.Id_NguoiDung = int.Parse(Session["Id"].ToString());
                }
                ddh.TrangThai = 1;

                db.DonDH.Add(ddh);
                db.SaveChanges();

                List<GioHang> ListGioHang = (List<GioHang>)Session["listgiohang"];
                foreach (GioHang gh in ListGioHang)
                {
                    CT_DonDH ct = new CT_DonDH();
                    ct.DonDH = ddh;
                    ct.SanPham = db.SanPham.Find(gh.Id);
                    ct.DonGia = gh.DonGia;
                    ct.SoLuong = gh.SoLuong;
                    db.CT_DonDH.Add(ct);
                    ct.SanPham.SoLuong = ct.SanPham.SoLuong - gh.SoLuong;
                    db.SaveChanges();

                }

                ViewBag.DonDH = ddh;
                ViewBag.ListGioHang = ListGioHang;
                ViewBag.TongTien = Session["TongTien"];
                Session["listgiohang"] = null;
                Session["SoLuongSanPhamTrongGio"] = null;
                Session["TongTien"] = null;
            }
            return View();
        }
        public ActionResult BaoHanh()
        {
            Layout();
            return View();
        }

        public ActionResult LienHe()
        {
            Layout();
            return View();
        }
        public ActionResult GioiThieu()
        {
            Layout();
            return View();
        }

        public ActionResult ThongTinCaNhan()
        {
            Layout();
            return View();
        }

        public ActionResult DoiMatKhau()
        {
            Layout();
            return View();
        }
    }

}