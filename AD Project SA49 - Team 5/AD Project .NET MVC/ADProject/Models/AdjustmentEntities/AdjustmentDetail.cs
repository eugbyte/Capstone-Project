using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class AdjustmentDetail
    {
        //-----Added
        [Key, Column(Order = 0)]
        public int AdjustmentVoucherId { get; set; }

        //1 AdjustmentDatail to 1 ItemCatalogue
        [Key, Column(Order = 1)]
        public int ItemCatalogueId { get; set; }
        //-----


        //Removed --
        //public int AdjustmentDetailId { get; set; }
        //1 AdjustmentDatail to 1 ItemCatalogue
        //public int ItemCatalogueId { get; set; }
        //1 AdjustmentDetail to Many AdjustmentVoucher
        //public int AdjustmentVoucherId {get; set;}
        //--------
        public virtual ItemCatalogue ItemCatalogue { get; set; }

        public int Quantity { get; set; }
        public double Cost { get; set; }
        public string Reason { get; set; }

        
        public AdjustmentVoucher AdjustmentVoucher { get; set; }
    }
}