using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace LTHD_MVC
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            // Start Quan Ly

            routes.MapRoute(
                name: "DangNhap",
                url: "QuanLy/DangNhap/{action}/{id}",
                defaults: new { controller = "QuanLy", action = "DangNhap", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "SanPham",
                url: "QuanLy/SanPham/{action}/{id}",
                defaults: new { controller = "QuanLy", action = "SanPham", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "NhaCungCap",
                url: "QuanLy/NhaCungCap/{action}/{id}",
                defaults: new { controller = "QuanLy", action = "NhaCungCap", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "QuanLy",
                url: "QuanLy/{action}",
                defaults: new { controller = "QuanLy", action = "ThongKe", id = UrlParameter.Optional }
            );

            // End Quan Ly

            routes.MapRoute(
               name: "GioHang",
               url: "GioHang/XoaGioHang/{id}",
               defaults: new { controller = "Index", action = "XoaGioHang", id = UrlParameter.Optional }
           );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Index", action = "Index", id = UrlParameter.Optional }
            );
            routes.MapRoute(
               name: "Dang nhap",
               url: "dangnhap",
               defaults: new { controller = "Index", action = "DangNhap", id = UrlParameter.Optional }
           );
            //routes.MapRoute(
            //name: "DangKi",
            //url: "dang-ki",
            //defaults: new { Controller = "Index", Action = "Dangki", ia = UrlParameter.Optional},
            //    namespace: new[] {"LTHD_MVC.Controller"}
            //);
        }
    }
}