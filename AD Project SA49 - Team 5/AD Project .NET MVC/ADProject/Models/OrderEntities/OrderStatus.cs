using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class OrderStatus
    {
        public int OrderStatusId { get; set; }
        public string OrderDes { get; set; }
        public OrderStatus()
        {
            //
        }

        public OrderStatus(string OrderDes)
        {
            this.OrderDes = OrderDes;
        }


    }
}