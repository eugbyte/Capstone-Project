using ADProject.Data;
using ADProject.Models;
using ADProject.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using System.Diagnostics;
using ADProject.Services.Order;

namespace ADProject.Controllers
{
    public class OrderController : Controller
    {
        //Dependency injection
        private IOrder orderService;

        public OrderController()
        {
            orderService = new OrderService();
        }
        public ActionResult CreatePO()
        {
            //Create SelectListItem for Supplier
            List<SelectListItem> Suppliers = new List<SelectListItem>();

            using (var db = new ADProjectDb())
            {
                //get list of existing Supplier
                List<Supplier> SupplierList = db.Supplier.ToList();
                // Fill up select list
                foreach (Supplier S in SupplierList)
                {
                    Suppliers.Add(new SelectListItem() { Text = S.SupplierName.ToString(), Value = S.SupplierId.ToString() });
                }
                //Send list of Supplier to view for user to select
                ViewData["existingSupplier"] = Suppliers;

            }
            return View();
        }

        // Create new PO
        [HttpPost]
        public ActionResult CreatePO(string Supplier)
        {

            int selectedSupplierId = Int32.Parse(Supplier);
            Order newOrder;
            Employee employee = Session["employee"] as Employee;
            // Save to database
            using (var db = new ADProjectDb())
            {
                Supplier selectedSupplier = orderService.GetSupplier(db,selectedSupplierId);

                // create new PO object with SupplierId and EmpId

                OrderStatus orderStatusDraft = db.OrderStatus.Where(x => x.OrderStatusId == 1).FirstOrDefault();

                newOrder = new Order() { EmpId = employee.EmployeeId, SupplierId = selectedSupplier.SupplierId, Supplier = selectedSupplier, OrderStatus = orderStatusDraft};
                db.Order.Add(newOrder);
                db.SaveChanges();
                // Get back the last added order, need its orderId
                newOrder = db.Order.OrderByDescending(o => o.OrderId).FirstOrDefault();
            }
            // Redirect to the viewPO page
            return RedirectToAction("ViewPO", new { orderId = newOrder.OrderId, returnController = "Inventory", returnMethod = "showLowStock" });
        }

        //Delete an Order
        public ActionResult DeletePO(int orderId)
        {
            // Delete from database
            using (var db = new ADProjectDb())
            {
                orderService.DeleteOrder(db, orderId);
            }

            // Redirect to the viewPO page
            return RedirectToAction("showAllOrders");
        }

        //Edit an OrderDetail
        [HttpPost]
        public ActionResult EditOrderDetail(int orderId, int itemId)
        {
            using (var db = new ADProjectDb())
            {
                //get ViewOrderdetail from database

                ViewOrderDetail viewOrderDetail = orderService.GetViewOrderDetail(db, orderId, itemId);
                // Send Vieworderdetail to record the change
                return View(viewOrderDetail);
            }
        }


        //Save the edit to an OrderDetail
        [HttpPost]
        public ActionResult SaveEdit(int? orderQty, DateTime? expectedDelDate, int orderId, int itemId)
        {
            using (var db = new ADProjectDb())
            {
                orderService.SaveOrderDetail(db, orderQty, expectedDelDate, orderId,itemId);
                return RedirectToAction("ViewPO", new { orderId = orderId, returnPg = -3 });
            }

        }


        // Create new PO with the this supplier adding the 1st selected item
        [HttpPost]
        public ActionResult CreatePOWithFirstSupplier(string supplier, int itemId)
        {
            Employee employee = Session["employee"] as Employee;
            // Add new Order and Orderdetail to database
            using (var db = new ADProjectDb())
            {
                Order newOrder = orderService.CreateNewOrderWithSupplierWithFirstOrderDetail(db, employee.EmployeeId, supplier, itemId);
                return RedirectToAction("ViewPO", new { orderId = newOrder.OrderId, returnController ="Inventory", returnMethod = "showLowStock" });
            }

        }

        // View Order
        public ActionResult ViewPO(int orderId, string returnController = "Order", string returnMethod = "showAllOrders")
        {
            ViewBag.returnController = returnController;
            ViewBag.returnMethod = returnMethod;
            using (var db = new ADProjectDb())
            {

                List<ViewOrderDetail> viewOrderDetails = orderService.GetViewOrderDetailList(db, orderId);
                ViewBag.Orderdetails = viewOrderDetails;
                Order Order = orderService.GetOrder(db,orderId);

                //Send Order object to the view
                return View(Order);
            }

        }

        // Delete an entry on the  PO
        [HttpPost]
        public ActionResult deleteLine(int orderId, int itemId)
        {

            using (var db = new ADProjectDb())
            {
                orderService.DeleteOrderDetail(db, orderId, itemId);
            }

            return RedirectToAction("ViewPO", new { orderId = orderId });
        }

        // Add an entry on the PO
        public ActionResult addOrderDetails(string SelectedOrder, int itemId, int orderQty)
        {
            int orderId = Int32.Parse(SelectedOrder);

            using (var db = new ADProjectDb())
            {
                //Check if entry existed
                bool IsExisted = orderService.CheckIfODExist(db,orderId,itemId);
                if (IsExisted == true)
                {
                    orderService.UpdateOrderDetail(db, orderId,itemId,orderQty);
                }
                else
                {
                    orderService.AddOrderDetailtoOrder(db, orderId, itemId, orderQty);
                }
                
            }

            return RedirectToAction("ViewPO", new { orderId = orderId, returnController = "Inventory", returnMethod = "showLowStock" });
        }

        // Show the list of Orders and their status

        public ActionResult showAllOrders(string search)
        {
            Employee employee = Session["employee"] as Employee;

            using (var db = new ADProjectDb())
            {
                List<ViewOrder> viewOrders = orderService.GetAllOrdersAndFilterBySearch(db, search,employee.EmployeeId);
                ViewBag.viewOrderList = viewOrders;
                return View();
            }

        }

        // From low stock list to create purchase order, check if there is existing order, if yes, ask user to choose, still give option to create new
        //If no ask user whether he want to create a new order.
        [HttpPost]
        public ActionResult CreateOrderFromStockList(int itemId, string supplierName, int reOrderQty)
        {
            Employee employee = Session["employee"] as Employee;
            //Create SelectListItem for Order
            List<SelectListItem> existingOrders = new List<SelectListItem>();
            // Create item variable
            ItemCatalogue itemCatalogue;
            using (var db = new ADProjectDb())
            {
                itemCatalogue = db.ItemCatalogue.Where(x => x.ItemCatalogueId == itemId).FirstOrDefault();

                //get list of existing Orders raised by current employee for this supplier and is not submitted
                Supplier supplier = orderService.GetSupplierByName(db,supplierName);
                List<Order> OrderList = orderService.GetActiveOrderListByEmpIdSupplierId(db, supplier.SupplierId, employee.EmployeeId);


                // Fill up select list if order list is not empty (there are existing orders)
                if (OrderList.Count != 0)
                {
                    foreach (Order O in OrderList)
                    {
                        existingOrders.Add(new SelectListItem() { Text = O.OrderId.ToString(), Value = O.OrderId.ToString() });
                    }

                    // Return the view to allow selection
                    ViewData["existingOrders"] = existingOrders;
                    ViewData["itemid"] = itemId;
                    ViewData["itemDescription"] = itemCatalogue.ItemDes;
                    ViewData["reOrderQty"] = reOrderQty;
                    ViewData["SupplierId"] = supplier.SupplierId;
                    return View();

                }
                else
                {
                    // Pass item id and supplier to create new order with first order detail
                    return RedirectToAction("CreatePOWithFirstSupplier", new { supplier = supplier.SupplierName, itemId = itemId });
                }
            }

        }

        //For Ajax, check if there is existing order with this supplier
        [HttpPost]
        public ActionResult CheckForExistingOrder(string supplierName)
        {
            Employee employee = Session["employee"] as Employee;

            using (var db = new ADProjectDb())
            {
                //Check for database if there is existing order with this supplier by this employee 
                Supplier supplier = orderService.GetSupplierByName(db,supplierName);
                List<Order> OrderList = orderService.GetActiveOrderListByEmpIdSupplierId(db, supplier.SupplierId, employee.EmployeeId);

                // Check if order list is empty (there are no existing orders with this supplier)
                if (OrderList.Count == 0)
                {
                    //Respond to Client's Ajax that there is no existing order
                    return Json(new { reply = "No" });
                }
                else
                {
                    //Respond to Client's Ajax that there is existing order
                    return Json(new { reply = "Yes" });
                }
            }

        }

    }
}