using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace ADProject.Data
{
    public class SeedClerkRelatedEntites
    {
        public static void SeedEntities (ADProjectDb context)
        {
            List<OrderStatus> orderStatuses = new List<OrderStatus>()
            {
                new OrderStatus("PENDING"),
                new OrderStatus("DELIVERED")
            };

            context.OrderStatus.AddRange(orderStatuses);
            context.SaveChanges();

            Order order = new Order();
            order.OrderDate = DateTime.Today;
            order.OrderStatus = orderStatuses[0];

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.OrderQuantity = 2;
            orderDetail.ExpDelDate = new DateTime(2020, 1, 4);
            orderDetail.ActDelDate = null;

            order.OrderDetails = new List<OrderDetail>() { orderDetail };

            Supplier supplier = new Supplier();
            supplier.SupplierName = "ABC Holdings";

            order.Supplier = supplier;

            Employee employee = context.Employee.FirstOrDefault();
            order.Employee = employee;

            context.Order.Add(order);
            context.OrderDetail.Add(orderDetail);
            context.Supplier.Add(supplier);

            Category category = new Category();
            category.CategoryDescription = "pencil";

            ItemCatalogue itemCatalogue = new ItemCatalogue();
            itemCatalogue.ItemDes = "AA pencil";
            itemCatalogue.Category = category;

            context.Categories.Add(category);
            context.ItemCatalogue.Add(itemCatalogue);
            
            context.SaveChanges();
        }
    }
}