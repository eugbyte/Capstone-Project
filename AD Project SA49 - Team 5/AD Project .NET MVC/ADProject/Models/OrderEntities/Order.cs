using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class Order
    {
        public int OrderId { get; set; }

        public int SupplierId { get; set; }
        public virtual Supplier Supplier { get; set; }

        public int EmpId { get; set; }
        public virtual Employee Employee { get; set; }

        //Made this nullable as of 1/24/2020
        public DateTime? OrderDate { get; set; }

        //public int OrderStatusId { get; set; }
        public virtual OrderStatus OrderStatus { get; set; }

        public ICollection<OrderDetail> OrderDetails { get; set; }
    }
}