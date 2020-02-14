using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class ItemCatalogue
    {
        
        [Column("ItemId")]
        [Required]
        public int ItemCatalogueId { get; set; }

        public string ItemDes { get; set; }

        public string UnitOfMeasure { get; set; }

        public int CategoryId{ get; set; }
        public virtual Category Category { get; set; }

        public virtual StockInfo StockInfo { get; set; }

    }
}