//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace LTHD_MVC.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class CT_DonDH
    {
        public int Id_DonDH { get; set; }
        public int Id_SP { get; set; }
        public double DonGia { get; set; }
        public int SoLuong { get; set; }
    
        public virtual DonDH DonDH { get; set; }
        public virtual SanPham SanPham { get; set; }
    }
}
