using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ADProject.ViewModels;
using ADProject.Services.Delivery;

namespace ADProject.Controllers
{
    public class DeliveryController : Controller
    {
        //Dependency injection
        private IDelivery deliveryService;

        public DeliveryController()
        {
            deliveryService = new DeliveryService();
        }
        // GET: Delivery
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ShowDelivery(string search)
        {

            using (var db = new ADProjectDb())
            {
                List<ViewDelivery> viewDeliveries = deliveryService.GetViewDeliveryList(db);

                // Filter if there is a search term passed to method

                viewDeliveries = deliveryService.FilterViewDeliveryListBySearch(db,search, viewDeliveries);

                 ViewBag.ViewDeliveryList = viewDeliveries;
            }
            return View();
        }

        public ActionResult Accept(int orderId, int itemId, int receivedQty,string supplierName)
        {

            using (var db = new ADProjectDb())
            {
                deliveryService.UpdateOrderDetail(db, orderId, itemId, receivedQty);

                deliveryService.UpdateStockCardStockInfo(db, itemId, receivedQty, supplierName);
                deliveryService.UpdateOrderStatus(db, orderId);
            }

            return RedirectToAction("ShowDelivery");
        }
    }
}

