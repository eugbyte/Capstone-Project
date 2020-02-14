using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.ViewModels
{
    public class ViewAnalyticsResult
    {
        public int itemId { get; set; }
        public string itemDescription { get; set; }
        public int predictedDemand { get; set; }
        public int stockLevel { get; set; }

    }
}