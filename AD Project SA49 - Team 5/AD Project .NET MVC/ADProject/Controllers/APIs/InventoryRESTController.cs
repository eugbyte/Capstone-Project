using ADProject.Data;
using ADProject.Models;
using ADProject.Services.Inventory;
using ADProject.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;

namespace ADProject.Controllers.APIs
{
    [System.Web.Http.Route("api/inventory")]
    public class InventoryRESTController : ApiController
    {
        //Dependency injection
        private IInventory inventoryService;

        public InventoryRESTController()
        {
            inventoryService = new InventoryService();
        }
        public IHttpActionResult GetAllViewInventory(string search, string StockStatus)
        {
            
            List<ViewInventory> viewInventories = null;

            using (var db = new ADProjectDb())
            {
                viewInventories = inventoryService.GetListofViewIntentory(db);
                viewInventories = inventoryService.FilterBySearchAndStatus(db, search, StockStatus, viewInventories);
            }

            if (viewInventories.Count == 0)
            {
                return NotFound();
            }

            return Ok(viewInventories);
        }

        //  [System.Web.Http.AcceptVerbs("PUT")]

        //  [System.Web.Http.Route("api/inventory/put")]
        //  [System.Web.Http.HttpPut]
        public IHttpActionResult PutAdjustmentVoucherUpdate(int adjusQty, string VoucherReason, int VoucherId, int ItemId)
        {
            // create new voucher detail object
            AdjustmentDetail adjustmentDetail = new AdjustmentDetail() { ItemCatalogueId = ItemId, Reason = VoucherReason, Quantity = adjusQty };
            //Update adjustmentVoucher with new dsetail
            using (var db = new ADProjectDb())
            {
                //Check if entry existed
                bool IsExisted = inventoryService.CheckifAdjExist(db, ItemId, VoucherId);
                if (IsExisted == true)
                {
                    inventoryService.UpdateAdjDetails(db, ItemId, VoucherId, adjusQty, VoucherReason);
                }
                else
                {
                    inventoryService.AddtoAdjustmentVoucher(db, VoucherId, adjustmentDetail);
                }
            }
            return Ok();
        }

        public IHttpActionResult GetAdjustmentEntry(int itemId,int empId)
        {
            //Create SelectListItem for voucher
            List<SelectListItem> existingVouchers = new List<SelectListItem>();
            // get the item
            ItemCatalogue itemCatalogue;
            using (var db = new ADProjectDb())
            {
                itemCatalogue = inventoryService.GetItemCatalogue(db, itemId);
                //get list of existing Adjustment voucher raised by current employee and status is draft
                List<AdjustmentVoucher> voucherList = inventoryService.GetAdjustmentVoucherListByEmpIdStatusId(db, empId, 1);


                //Create a Json that send the exisiting Voucher list and viewInventory (I just need the item id and description).
                AdjustmentEntry adjustmentEntry = new AdjustmentEntry() { itemDesc = itemCatalogue.ItemDes, itemId = itemCatalogue.ItemCatalogueId };
                int[] existingvoucherId = new int[voucherList.Count];
                for(int i = 0; i < voucherList.Count; i++)
                {
                    existingvoucherId[i] = voucherList[i].AdjustmentVoucherId;
                }
                adjustmentEntry.voucherId = existingvoucherId;

                if (adjustmentEntry == null)
                {
                    return NotFound();
                }

                return Ok(adjustmentEntry);
            }

        }

        public IHttpActionResult PostNewEmptyVoucher(int empId)
        {

            using (var db = new ADProjectDb())
            {
                // Create new empty voucher for this employee
                inventoryService.CreateEmptyVoucher(db, empId);
            }
            // redirect back to inventory list, need the itemId to show back the same page
            return Ok();
        }


    }
    public class AdjustmentEntry
    {
        public int itemId { get; set; }
        public string itemDesc { get; set; }
        public int[] voucherId { get; set; }
    }
}
