using ADProject.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using System.Diagnostics;
using ADProject.Models;
using ADProject.ViewModels;
using ADProject.Services.Inventory;

namespace ADProject.Controllers
{
    public class InventoryController : Controller
    {
        //Dependency injection
        private IInventory inventoryService;

        public InventoryController()
        {
            inventoryService = new InventoryService();
        }

        public class InventoryContainer
        {
            public int itemId { get; set; }
            public string description { get; set; }
            public int quantity { get; set; }
            public int roLevel { get; set; }
            public int roQty { get; set; }
            public string unit { get; set; }
            public string supplier{ get; set; }
            public string location { get; set; }
            public int rank { get; set; }

        }


        // Show the list of inventory
        public ActionResult showLowStock(string search, int? page, string StockStatus, FormCollection fc)
        {
            using (var db = new ADProjectDb())
            {
                List<ViewInventory> viewInventories = inventoryService.GetListofViewIntentory(db);
                viewInventories = inventoryService.FilterBySearchAndStatus(db, search, StockStatus, viewInventories);
                int pageSize = 10;
                int pageNumber = (page ?? 1);

                return View(viewInventories.ToPagedList(pageNumber, pageSize));
            }
        }


        // show adjustment, single entry
        public ActionResult ShowAdjustmentEntry(int itemId)
        {
            Employee employee = Session["employee"] as Employee;
            //Create SelectListItem for voucher
            List<SelectListItem> existingVouchers = new List<SelectListItem>();
            // get the item
            ItemCatalogue itemCatalogue;
            using (var db = new ADProjectDb())
            {
                itemCatalogue = inventoryService.GetItemCatalogue(db, itemId);
                //get list of existing Adjustment voucher raised by current employee and status is draft
                //Make sure the  voucher id is autogenerate so that the first one is the latest voucher
                List<AdjustmentVoucher> voucherList = inventoryService.GetAdjustmentVoucherListByEmpIdStatusId(db, employee.EmployeeId, 1);
                // Fill up select list
                foreach (AdjustmentVoucher V in voucherList)
                {
                    existingVouchers.Add(new SelectListItem() { Text = V.AdjustmentVoucherId.ToString(), Value = V.AdjustmentVoucherId.ToString() });
                }
                //Send list of voucher to view for user to  select
                ViewBag.VoucherList = voucherList;
                // Send current time
                ViewData["date"] = DateTime.Now.ToShortDateString();
                ViewData["existingVouchers"] = existingVouchers;
            }

            // pass catalogue item to the view
            return View(itemCatalogue);
        }

        //add adjustment, single entry, to an voucher
        public ActionResult SubmitAdjustmentEntry(int adjusQty, string VoucherReason, string SelectedVoucher, int ItemId)
        {

            // create new voucher detail object
            AdjustmentDetail adjustmentDetail = new AdjustmentDetail() { ItemCatalogueId = ItemId, Reason = VoucherReason, Quantity = adjusQty };
            //Update adjustmentVoucher with new dsetail
            int VoucherId = Int32.Parse(SelectedVoucher);
            using (var db = new ADProjectDb())
            {
                //Check if entry existed
                bool IsExisted = inventoryService.CheckifAdjExist(db, ItemId, VoucherId);
                if(IsExisted == true)
                {
                    inventoryService.UpdateAdjDetails(db, ItemId, VoucherId, adjusQty,VoucherReason);
                }
                else
                {
                    inventoryService.AddtoAdjustmentVoucher(db, VoucherId, adjustmentDetail);
                }

            }
            // redirect back to inventory list
            return RedirectToAction("showLowStock", "Inventory");
        }

        public ActionResult createEmptyVoucher(int itemId)
        {
            Employee employee = Session["employee"] as Employee;

            using (var db = new ADProjectDb())
            {
                // Create new empty voucher for this employee
                inventoryService.CreateEmptyVoucher(db, employee.EmployeeId);
            }
            // redirect back to inventory list, need the itemId to show back the same page
            return RedirectToAction("ShowAdjustmentEntry", "Inventory",new { itemId = itemId });
        }

    }
}

