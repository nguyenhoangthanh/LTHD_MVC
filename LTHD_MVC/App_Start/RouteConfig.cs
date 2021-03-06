﻿using System;
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
                name: "NguoiDung",
                url: "QuanLy/NguoiDung/{action}/{id}",
                defaults: new { controller = "QuanLy", action = "NguoiDung", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "PhieuNhap",
                url: "QuanLy/PhieuNhap/{action}/{id}",
                defaults: new { controller = "QuanLy", action = "PhieuNhap", id = UrlParameter.Optional }
            );

            routes.MapRoute(
               name: "DonDatHang",
               url: "QuanLy/DonDatHang/{action}/{id}",
               defaults: new { controller = "QuanLy", action = "DonDatHang", id = UrlParameter.Optional }
            );

            routes.MapRoute(
               name: "TonKho",
               url: "QuanLy/TonKho/{action}/{id}",
               defaults: new { controller = "QuanLy", action = "TonKho", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "QuanLy",
                url: "QuanLy/{action}",
                defaults: new { controller = "QuanLy", action = "SanPham", id = UrlParameter.Optional }
            );

            // End Quan Ly


            // Start Trang Chu

            routes.MapRoute(
               name: "TrangChu_NhaCungCap",
               url: "TrangChu/NhaCungCap/{name}/{id}",
               defaults: new { controller = "TrangChu", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "TrangChu_DangNhap",
                url: "TrangChu/DangNhap/{action}/{id}",
                defaults: new { controller = "TrangChu", action = "DangNhap", id = UrlParameter.Optional }
            );

            routes.MapRoute(
               name: "GioHang",
               url: "GioHang/XoaGioHang/{id}",
               defaults: new { controller = "TrangChu", action = "XoaGioHang", id = UrlParameter.Optional }
            );

            routes.MapRoute(
               name: "TrangChu",
               url: "{controller}/{action}/{id}",
               defaults: new { controller = "TrangChu", action = "Index", id = UrlParameter.Optional }
            );
            
            //End Trang Chu
        }
    }
}