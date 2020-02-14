using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.ViewModels
{
    public class ViewOrder
    {
        public int orderId { get; set; }
        public string supplier { get; set; }
        public DateTime? orderDate { get; set; }
        public string status { get; set; }
    }
}