using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.ViewModels
{
    public class ViewInventory
    {
        public int itemId { get; set; }
        public string description { get; set; }
        public int quantity { get; set; }
        public int rOLevel { get; set; }
        public int rOQty { get; set; }
        public string unit { get; set; }
        public string location { get; set; }

        public string supplier1 { get; set; }
        public string supplier2 { get; set; }
        public string supplier3 { get; set; }
        public string status { get; set; }
    }
}