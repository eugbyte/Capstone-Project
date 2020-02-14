using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ADProject.Data;
using ADProject.Models;
using ADProject.ViewModels;

namespace ADProject.Services.Delivery
{
    public class DeliveryService:IDelivery
    {
        public List<ViewDelivery> GetViewDeliveryList(ADProjectDb db)
        {
            // get list of all order details
            List<ViewDelivery> viewDeliveries = (from IC in db.ItemCatalogue
                                                 join OD in db.OrderDetail
                                                 on IC.ItemCatalogueId equals OD.ItemId
                                                 join SI in db.StockInfo
                                                 on IC.ItemCatalogueId equals SI.ItemCatalogueId
                                                 join O in db.Order
                                                 on OD.OrderId equals O.OrderId
                                                 orderby OD.ItemId
                                                 select new ViewDelivery()
                                                 {
                                                     supplierName = O.Supplier.SupplierName,
                                                     orderId = OD.OrderId,
                                                     itemId = IC.ItemCatalogueId,
                                                     description = IC.ItemDes,
                                                     quantity = OD.OrderQuantity,
                                                     unit = IC.UnitOfMeasure,
                                                     ExpDate = OD.ExpDelDate,
                                                     ActDate = OD.ActDelDate
                                                 }).ToList();

            // get list of all order details with NULL Actual delivery date
            viewDeliveries = viewDeliveries.Where(S => S.ActDate == null).ToList();
            return viewDeliveries;

        }
        public List<ViewDelivery> FilterViewDeliveryListBySearch(ADProjectDb db, string search, List<ViewDelivery> viewDeliveries)
        {
            if (!String.IsNullOrEmpty(search))
            {
                viewDeliveries = viewDeliveries.Where(S => S.description.Contains(search) || S.supplierName.Contains(search)).ToList();
            }
            return viewDeliveries;
        }

        public void UpdateOrderDetail(ADProjectDb db, int orderId, int itemId, int receivedQty)
        {
            //get Orderdetail from database and update recieved qty
            OrderDetail toUpdateOD = db.OrderDetail.Where(x => x.OrderId == orderId).Where(x => x.ItemId == itemId).FirstOrDefault();
            toUpdateOD.ReceiveQuantity = receivedQty;
            toUpdateOD.ActDelDate = DateTime.Now;
            db.SaveChanges();
        }

        public void UpdateStockCardStockInfo(ADProjectDb db, int itemId, int receivedQty, string supplierName)
        {

            StockCard toAddSC = new StockCard() { ItemCatalogueId = itemId, ChangeDate = DateTime.Now, ChangeDescription = "Supplier - " + supplierName, ChangeQuantity = receivedQty };

            //Add new stockCard entry
            db.stockCard.Add(toAddSC);

            //get Stockinfo from database and update stock Qty
            StockInfo toUpdateSI = db.StockInfo.Where(x => x.ItemCatalogueId == itemId).FirstOrDefault();
            toUpdateSI.StockQuantity = toUpdateSI.StockQuantity + receivedQty;
            db.SaveChanges();
        }

        public void UpdateOrderStatus(ADProjectDb db, int orderId)
        {
            //If all the OD in the order has accepted date, then update order status to delivered.
            List<OrderDetail> ODList = db.OrderDetail.Where(x => x.OrderId == orderId).ToList();
            List<OrderDetail> Outstanding = ODList.Where(x => x.ActDelDate == null).ToList();
            if(Outstanding.Count == 0)
            {
                Models.Order order = db.Order.Where(x => x.OrderId == orderId).FirstOrDefault();
                order.OrderStatus = db.OrderStatus.Where(x => x.OrderStatusId == 4).FirstOrDefault();
                db.SaveChanges();

            }
        }
    }
}