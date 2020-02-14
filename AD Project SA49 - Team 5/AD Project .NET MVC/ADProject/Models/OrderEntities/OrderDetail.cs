using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class OrderDetail
    {
        //public int Id { get; set; }
        [Key]
        [Column(Order=1)]
        public int OrderId { get; set; }
        public virtual Order Order { get; set; }

        [Key]
        [Column(Order = 2)]
        public int ItemId { get; set; }
        public virtual ItemCatalogue ItemCatalogue { get; set; }

        public int OrderQuantity { get; set; }
        public DateTime? ExpDelDate { get; set; }
        public DateTime? ActDelDate { get; set; }
        public int ReceiveQuantity { get; set; }
    }
}