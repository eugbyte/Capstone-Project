using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class SupplierCatalogue
    {
        [Key]
        [Column(Order = 1)]
        public int SupplierId { get; set; }
        public virtual Supplier Supplier { get; set; }

        [Key]
        [Column(Order = 2)]
        public int ItemId { get; set; }
        public virtual ItemCatalogue ItemCatalogue { get; set; }

        public double ItemPrice { get; set; }

        public int SupplierRank { get; set; }

    }
}