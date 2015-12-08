using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace LTHD_MVC.Helper
{
    public class StringHelper
    {
        public static string DoiTenFile(String TenFileFull)
        {
            string PhanMoRong = Path.GetExtension(TenFileFull);
            string TenTapTin = Path.GetFileNameWithoutExtension(TenFileFull);
            string NgayGioHienTai = DateTime.Now.ToString("yyyy_MM_dd_HH_mm_ss");
            string FileName = RemoveSpecialCharacters(String.Format("{0}_{1}{2}", TenTapTin, NgayGioHienTai, PhanMoRong));
            FileName = RemoveSpace(FileName);
            return FileName;
        }
        public static String RemoveSpecialCharacters(String strInput)
        {
            try
            {
                if (!Object.Equals(strInput, null))
                {
                    List<String> ListSpecialCharacters = new List<String>(new String[] { "/", "\\", ":", "*", "?", "\"", "<", ">", "|" });
                    foreach (String strSpecial in ListSpecialCharacters)
                    {
                        strInput = strInput.Replace(strSpecial, String.Empty);
                    }
                    return strInput;
                }
                return "";
            }
            catch
            {
                return "";
            }
        }

        public static String RemoveSpace(String strInput)
        {
            try
            {
                if (!Object.Equals(strInput, null))
                {
                    strInput.Trim();
                    strInput = strInput.Replace(" ", String.Empty);
                    return strInput;
                }
                return "";
            }
            catch
            {
                return "";
            }
        }
    }
}