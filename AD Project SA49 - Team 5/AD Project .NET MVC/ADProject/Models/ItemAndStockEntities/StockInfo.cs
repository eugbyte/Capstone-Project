using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class StockInfo
    {
        [ForeignKey("ItemCatalogue")]
        public int StockInfoId { get; set; }
        
        public int ItemCatalogueId { get; set; }
        public virtual ItemCatalogue ItemCatalogue { get; set; }

        public string ItemLocation { get; set; }
        public int ReOrderLevel { get; set; }
        public int ReOrderQuantity { get; set; }
        public int StockQuantity { get; set; }

    }
}