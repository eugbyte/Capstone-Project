using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class RequestDetail
    {
        public int RequestDetailId { get; set; }

        public int RequestId { get; set; }
        public virtual Request Request { get; set; }

        public int ItemCatalogueId { get; set; }
        public virtual ItemCatalogue ItemCatalogue { get; set; }

        [Required]
        [Range(1, int.MaxValue)]
        public int Quantity { get; set; }


    }
}