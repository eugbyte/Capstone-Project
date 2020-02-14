using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.ViewModels
{
    public class ViewDelivery
    {

        public string supplierName { get; set; }
        public int orderId { get; set; }
        public int itemId { get; set; }
        public string description { get; set; }
        public int quantity { get; set; }
        public string unit { get; set; }

        
        public DateTime? ExpDate { get; set; }
        public DateTime? ActDate { get; set; }
    
    }
}