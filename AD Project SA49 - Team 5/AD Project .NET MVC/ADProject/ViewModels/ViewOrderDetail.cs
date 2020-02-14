using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.ViewModels
{
    public class ViewOrderDetail
    {
        public int orderId { get; set; }
        public int itemId { get; set; }
        public string description { get; set; }
        public int orderQty { get; set; }

        public DateTime? expDate { get; set; }

        public DateTime? actDate { get; set; }

        public string unit { get; set; }
        public double price { get; set; }
    }
}