using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class Supplier
    {
        public int SupplierId { get; set; }
        public String SupplierName { get; set; }
        public String SupplierContact { get; set; }
        public String SupplierPhone { get; set; }
        public String SupplierFax { get; set; }
        public String SupplierAddress { get; set; }
        public String SupplierEmail { get; set; }
        public String SupplierGST { get; set; }

    }
}