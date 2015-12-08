using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace LTHD_MVC.Helper
{
    public class Helper
    {
        //        public void SendEmail(string address, string subject, string message)
        //        {
        //            string email = "lthd.websitelaptop@gmail.com";
        //            string password = "sa123456789";

        //            var loginInfo = new NetworkCredential(email, password);
        //            var msg = new System.Net.Mail.MailMessage();
        //            var smtpClient = new SmtpClient("smtp.gmail.com", 587);

        //            msg.From = new MailAddress(email);
        //            msg.To.Add(new MailAddress(address));
        //            msg.Subject = subject;
        //            msg.Body = message;
        //            msg.IsBodyHtml = true;

        //            smtpClient.EnableSsl = true;
        //            smtpClient.UseDefaultCredentials = false;
        //            smtpClient.Credentials = loginInfo;
        //            smtpClient.Send(msg);
        //        }

        //        public string RandomString(int size, bool lowerCase)
        //        {
        //            StringBuilder sb = new StringBuilder();
        //            char c;
        //            Random rand = new Random();
        //            for (int i = 0; i < size; i++)
        //            {
        //                c = Convert.ToChar(Convert.ToInt32(rand.Next(65, 87)));
        //                sb.Append(c);
        //            }
        //            if (lowerCase)
        //            {
        //                return sb.ToString().ToLower();
        //            }
        //            return sb.ToString();
        //        }

        //        public string md5(string str, int code)
        //        {
        //            if (code == 16)
        //            {
        //                return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(str, "MD5").ToLower().Substring(8, 16);
        //            }
        //            else
        //            {
        //                return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(str, "MD5").ToLower();
        //            }
        //        }
        //    }
    }
}