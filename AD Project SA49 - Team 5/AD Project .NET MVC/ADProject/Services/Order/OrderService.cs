using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using ADProject.Data;
using ADProject.Models;
using ADProject.ViewModels;

namespace ADProject.Services.Order
{
    public class OrderService : IOrder
    {
        public void AddOrderDetailtoOrder(ADProjectDb db, int orderId, int itemId, int orderQty)
        {
            //Create Orderdetail object
            OrderDetail toAdd = new OrderDetail() { OrderId = orderId, ItemId = itemId, OrderQuantity = orderQty };

            db.OrderDetail.Add(toAdd);

            //Get that order and add orderdetail to it
            ADProject.Models.Order orderToAddto = db.Order.Where(x => x.OrderId == orderId).FirstOrDefault();

            if (orderToAddto != null)
            {
                if (orderToAddto.OrderDetails == null)
                    orderToAddto.OrderDetails = new List<OrderDetail>();
                orderToAddto.OrderDetails.Add(toAdd);
            }
            db.SaveChanges();
        }

        public Models.Order CreateNewOrderWithSupplierWithFirstOrderDetail(ADProjectDb db, int empId, string supplier, int itemId)
        {
            Supplier selectedSupplier = GetSupplierByName(db,supplier);
            ItemCatalogue firstitem = GetItemCatalogue(db, itemId);
            // create new PO object with SupplierId and EmpId
            OrderStatus orderStatusDraft = db.OrderStatus.Where(x => x.OrderStatusId == 1).FirstOrDefault();
            ADProject.Models.Order newOrder = new ADProject.Models.Order() { EmpId = empId, SupplierId = selectedSupplier.SupplierId, Supplier = selectedSupplier, OrderStatus = orderStatusDraft };
            db.Order.Add(newOrder);
            //Need to save changes first so that the new order id will be generated
            db.SaveChanges();
            // Get back the last added order, need its orderId
            newOrder = db.Order.OrderByDescending(o => o.OrderId).FirstOrDefault();
            //Get the reordering qty
            var reorder = db.StockInfo.Where(x => x.ItemCatalogueId == itemId).FirstOrDefault().ReOrderQuantity;
            // Create and add the new orderdetail, qty is the default restock quantity
            OrderDetail firstOd = new OrderDetail() { OrderId = newOrder.OrderId, ItemId = itemId, ItemCatalogue = firstitem, OrderQuantity = reorder };
            db.OrderDetail.Add(firstOd);
            newOrder.OrderDetails = new List<OrderDetail>();
            newOrder.OrderDetails.Add(firstOd);
            db.SaveChanges();
            return newOrder;
        }

        public void DeleteOrder(ADProjectDb db, int orderId)
        {
            // get the Order to delete and commit
            ADProject.Models.Order toDelete = db.Order.Where(x => x.OrderId == orderId).FirstOrDefault();
            db.Order.Remove(toDelete);
            db.SaveChanges();
        }

        public void DeleteOrderDetail(ADProjectDb db, int orderId, int itemId)
        {
            //get Orderdetail from database and delete
            OrderDetail toDelete = db.OrderDetail.Where(x => x.OrderId == orderId).Where(x => x.ItemId == itemId).FirstOrDefault();
            db.OrderDetail.Remove(toDelete);
            db.SaveChanges();
        }

        public List<ViewOrder> GetAllOrdersAndFilterBySearch(ADProjectDb db, string search, int empId)
        {
            List<ViewOrder> viewOrders = (from O in db.Order
                                          join OS in db.OrderStatus
                                          on O.OrderStatus.OrderStatusId equals OS.OrderStatusId
                                          join S in db.Supplier
                                          on O.SupplierId equals S.SupplierId
                                          where O.EmpId == empId
                                          orderby O.OrderId
                                          select new ViewOrder()
                                          {
                                              orderId = O.OrderId,
                                              supplier = S.SupplierName,
                                              orderDate = O.OrderDate,
                                              status = OS.OrderDes,
    
                                          }).ToList();

            // Filter if there is a search term passed to method

            if (!String.IsNullOrEmpty(search))
            {
                viewOrders = viewOrders.Where(S => S.supplier.Contains(search) || S.status.Contains(search)).ToList();
            }
            return viewOrders;
        }

        public ItemCatalogue GetItemCatalogue(ADProjectDb db, int itemId)
        {
            ItemCatalogue itemCatalogue = db.ItemCatalogue.Where(x => x.ItemCatalogueId == itemId).FirstOrDefault();
            return itemCatalogue;

        }

        public Models.Order GetOrder(ADProjectDb db, int orderId)
        {
            Models.Order order = db.Order.Where(x => x.OrderId == orderId).Include(x=>x.OrderStatus).FirstOrDefault();
            return order;
        }

        public List<Models.Order> GetActiveOrderListByEmpIdSupplierId(ADProjectDb db, int supplierId, int empId)
        {
            List<Models.Order> OrderList = db.Order.Where(x => x.EmpId == empId).Where(x => x.SupplierId == supplierId).Where(x => x.OrderStatus.OrderStatusId == 1|| x.OrderStatus.OrderStatusId == 2).ToList();
            return OrderList;
        }

        public Supplier GetSupplier(ADProjectDb db, int supplierId)
        {
            Supplier supplier = db.Supplier.Where(x => x.SupplierId == supplierId).FirstOrDefault();
            return supplier;
        }

        public Supplier GetSupplierByName(ADProjectDb db, string supplierName)
        {
            Supplier supplier = db.Supplier.Where(x => x.SupplierName == supplierName).FirstOrDefault();
            return supplier;
        }

        public ViewOrderDetail GetViewOrderDetail(ADProjectDb db, int orderId, int itemId)
        {

            ViewOrderDetail viewOrderDetail = (from IC in db.ItemCatalogue
                                               join OD in db.OrderDetail
                                               on IC.ItemCatalogueId equals OD.ItemId
                                               where OD.OrderId == orderId
                                               where OD.ItemId == itemId
                                               join SC in db.SupplierCatalogue
                                               on IC.ItemCatalogueId equals SC.ItemId
                                               join O in db.Order
                                               on OD.OrderId equals O.OrderId
                                               where SC.SupplierId == O.SupplierId
                                               select new ViewOrderDetail()
                                               {
                                                   orderId = OD.OrderId,
                                                   itemId = IC.ItemCatalogueId,
                                                   description = IC.ItemDes,
                                                   orderQty = OD.OrderQuantity,
                                                   price = SC.ItemPrice,
                                                   unit = IC.UnitOfMeasure,
                                                   expDate = OD.ExpDelDate,
                                                   actDate = OD.ActDelDate
                                               }).FirstOrDefault();

            return viewOrderDetail;
        }

        public List<ViewOrderDetail> GetViewOrderDetailList(ADProjectDb db, int orderId)
        {

            List<ViewOrderDetail> viewOrderDetails = (from IC in db.ItemCatalogue
                                                      join OD in db.OrderDetail
                                                      on IC.ItemCatalogueId equals OD.ItemId
                                                      where OD.OrderId == orderId
                                                      join SC in db.SupplierCatalogue
                                                      on IC.ItemCatalogueId equals SC.ItemId
                                                      join O in db.Order
                                                      on OD.OrderId equals O.OrderId
                                                      where SC.SupplierId == O.SupplierId
                                                      orderby OD.ItemId
                                                      select new ViewOrderDetail()
                                                      {
                                                          orderId = OD.OrderId,
                                                          itemId = IC.ItemCatalogueId,
                                                          description = IC.ItemDes,
                                                          orderQty = OD.OrderQuantity,
                                                          price = SC.ItemPrice,
                                                          unit = IC.UnitOfMeasure,
                                                          expDate = OD.ExpDelDate,
                                                          actDate = OD.ActDelDate
                                                      }).ToList();
            return viewOrderDetails;
        }

        public void SaveOrderDetail(ADProjectDb db, int? orderQty, DateTime? expectedDelDate, int orderId, int itemId)
        {
            //get Orderdetail from database
            OrderDetail orderDetail = db.OrderDetail.Where(x => x.OrderId == orderId).Where(x => x.ItemId == itemId).FirstOrDefault();
            // Now update qty and date
            if(orderQty != null)
            {
                orderDetail.OrderQuantity = orderQty.Value;
            }

            if(expectedDelDate != null)
            {
                orderDetail.ExpDelDate = expectedDelDate.Value;
            }
            
            db.SaveChanges();
        }

        public void ChangeOrderStatus(ADProjectDb db, int orderId, int orderStatusId)
        {
            Models.Order Order = db.Order.Where(x => x.OrderId == orderId).FirstOrDefault();
            OrderStatus newOrderStatus = db.OrderStatus.Where(x => x.OrderStatusId == orderStatusId).FirstOrDefault();
            Order.OrderStatus = newOrderStatus;
            db.SaveChanges();
        }

        public bool CheckIfODExist(ADProjectDb db, int orderId, int itemId)
        {
            OrderDetail Od = db.OrderDetail.Where(x => x.OrderId == orderId)
                                           .Where(x => x.ItemId == itemId)
                                           .FirstOrDefault();
            if (Od == null)
            {
                return false;
            }
            else return true;
        }
        public void UpdateOrderDetail(ADProjectDb db, int orderId, int itemId, int newQty)
        {
            OrderDetail Od = db.OrderDetail.Where(x => x.OrderId == orderId)
                                           .Where(x => x.ItemId == itemId)
                                           .FirstOrDefault();
            Od.OrderQuantity = Od.OrderQuantity + newQty;
            db.SaveChanges();
        }
    }
}