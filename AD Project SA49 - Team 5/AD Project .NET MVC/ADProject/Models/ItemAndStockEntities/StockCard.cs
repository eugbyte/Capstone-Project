using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class StockCard
    {
        public int StockCardId { get; set; }

        public int ItemCatalogueId { get; set; }
        public ItemCatalogue ItemCatalogue { get; set; }

        public virtual StockInfo StockInfo { get; set; }

        public DateTime? ChangeDate { get; set; }
        public string ChangeDescription { get; set; }
        public int ChangeQuantity { get; set; }
    }
}