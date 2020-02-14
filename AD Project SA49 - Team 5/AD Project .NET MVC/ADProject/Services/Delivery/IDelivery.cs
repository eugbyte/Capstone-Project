using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ADProject.Data;
using ADProject.ViewModels;

namespace ADProject.Services.Delivery
{
    interface IDelivery
    {
        public List<ViewDelivery> GetViewDeliveryList(ADProjectDb db);

        public List<ViewDelivery> FilterViewDeliveryListBySearch(ADProjectDb db, string search, List<ViewDelivery> viewDeliveries);

        public void UpdateOrderDetail(ADProjectDb db, int orderId, int itemId, int receivedQty);
        public void UpdateOrderStatus(ADProjectDb db, int orderId);
        public void UpdateStockCardStockInfo(ADProjectDb db, int itemId, int receivedQty, string supplierName);
    }
}
