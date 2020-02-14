using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.ViewModels
{
    public class ViewAdjustmentDetail
    {
        public int voucherId { get; set; }
        public int itemId { get; set; }
        public string description { get; set; }
        public int quantity { get; set; }
        public string unit { get; set; }
        public string reason { get; set; }
        public double price { get; set; }

    }
}