using ADProject.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ADProject.Models;
using ADProject.ViewModels;

namespace ADProject.Services.Order
{
    interface IOrder
    {
        public void DeleteOrder(ADProjectDb db, int orderId);
        public ADProject.Models.Order GetOrder(ADProjectDb db, int orderId);

        public ViewOrderDetail GetViewOrderDetail(ADProjectDb db,int orderId, int itemId);
        public void SaveOrderDetail(ADProjectDb db, int? orderQty, DateTime? expectedDelDate, int orderId, int itemId);

        public ADProject.Models.Order CreateNewOrderWithSupplierWithFirstOrderDetail(ADProjectDb db, int empId,string supplier, int itemId);

        public Supplier GetSupplier(ADProjectDb db, int supplierId);
        public Supplier GetSupplierByName(ADProjectDb db, string supplierName);
        public ItemCatalogue GetItemCatalogue(ADProjectDb db, int itemId);

        public List<ViewOrderDetail> GetViewOrderDetailList(ADProjectDb db, int orderId);

        public void DeleteOrderDetail(ADProjectDb db, int orderId, int itemId);
        public void AddOrderDetailtoOrder(ADProjectDb db, int orderId, int itemId, int orderQty);

        public List<ViewOrder> GetAllOrdersAndFilterBySearch(ADProjectDb db, string search, int empId);

        public List<Models.Order> GetActiveOrderListByEmpIdSupplierId(ADProjectDb db, int supplierId, int empId);

        public void ChangeOrderStatus(ADProjectDb db, int orderId, int orderStatusId);
        public bool CheckIfODExist(ADProjectDb db, int orderId, int itemId);
        public void UpdateOrderDetail(ADProjectDb db, int orderId, int itemId,int newQty);
    }
}
