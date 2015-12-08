using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LTHD_MVC.SessionCode
{
    public class SessionHelper
    {
        public static void SetSession(NguoiDungSession session)
        {
            HttpContext.Current.Session["DangNhapSession"] = session;
        }
        public static NguoiDungSession GetSession()
        {
            var session = HttpContext.Current.Session["DangNhapSession"];
            if (session == null)
                return null;
            else
            {
                return session as NguoiDungSession;
            }
        }

    }
}