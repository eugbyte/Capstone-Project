using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ADProject.Controllers;
using ADProject.Data;
using ADProject.Models;
using ADProject.ViewModels;

namespace ADProject.Services.Inventory
{
    public class InventoryService : IInventory
    {
        public void AddtoAdjustmentVoucher(ADProjectDb db, int voucherId, AdjustmentDetail AD)
        {
            // Update cost of adjustmentDetail
            double price = (from IC in db.ItemCatalogue
                            join SC in db.SupplierCatalogue
                            on IC.ItemCatalogueId equals SC.ItemId
                            where SC.SupplierRank == 1
                            where IC.ItemCatalogueId == AD.ItemCatalogueId
                            select SC.ItemPrice).FirstOrDefault();
            AD.Cost = AD.Quantity * price;

            //Add to AdjustmentDetail Database
            db.AdjustmentDetail.Add(AD);

            AdjustmentVoucher adjustmentVoucher = db.AdjustmentVoucher.Where(x => x.AdjustmentVoucherId == voucherId).FirstOrDefault();

            if (adjustmentVoucher != null)
            {
                if (adjustmentVoucher.AdjustmentDetail == null) adjustmentVoucher.AdjustmentDetail = new List<AdjustmentDetail>();
                adjustmentVoucher.AdjustmentDetail.Add(AD);
            }
            db.SaveChanges();


        }

        public List<ViewInventory> FilterBySearchAndStatus(ADProjectDb db, string search, string stockstatus, List<ViewInventory> viewInventories)
        {
            // Filter if there is a search term passed to method
            if (!string.IsNullOrEmpty(search))
            {
                viewInventories = viewInventories
                     .Where(ce => ce.description.ToLower()
                         .Contains(search.ToLower())
                      || ce.itemId.ToString().ToLower()
                         .Contains(search.ToLower()))
                     .ToList();
            }

            if (!string.IsNullOrEmpty(stockstatus))
            {
                viewInventories = viewInventories
                    .Where(ce => ce.status == stockstatus)
                    .ToList();
            }

            return viewInventories;
        }

        public List<AdjustmentVoucher> GetAdjustmentVoucherListByEmpIdStatusId(ADProjectDb db, int empId, int statusId)
        {
            List<AdjustmentVoucher> voucherList = db.AdjustmentVoucher.Where(x => x.RaisedByEmployee.EmployeeId == empId)
                                                                      .Where(x => x.AdjustmentStatusId == statusId)
                                                                      .OrderByDescending(x => x.AdjustmentVoucherId)
                                                                      .ToList();
            return voucherList;
        }

        public ItemCatalogue GetItemCatalogue(ADProjectDb db, int itemId)
        {
            ItemCatalogue itemCatalogue = db.ItemCatalogue.Where(x => x.ItemCatalogueId == itemId).FirstOrDefault();
            return itemCatalogue;
        }

        public List<ViewInventory> GetListofViewIntentory(ADProjectDb db)
        {
            List<InventoryController.InventoryContainer> inventoryContainersList = (from IC in db.ItemCatalogue
                                                                                    join SI in db.StockInfo
                                                                                    on IC.ItemCatalogueId equals SI.ItemCatalogueId
                                                                                    join SC in db.SupplierCatalogue
                                                                                    on IC.ItemCatalogueId equals SC.ItemId
                                                                                    join S in db.Supplier
                                                                                    on SC.SupplierId equals S.SupplierId
                                                                                    orderby SC.ItemId, SC.SupplierRank
                                                                                    select new InventoryController.InventoryContainer()
                                                                                    {
                                                                                        itemId = IC.ItemCatalogueId,
                                                                                        description = IC.ItemDes,
                                                                                        quantity = SI.StockQuantity,
                                                                                        roLevel = SI.ReOrderLevel,
                                                                                        roQty = SI.ReOrderQuantity,
                                                                                        unit = IC.UnitOfMeasure,
                                                                                        supplier = S.SupplierName,
                                                                                        rank = SC.SupplierRank,
                                                                                        location = SI.ItemLocation
                                                                                        
                                                                                    }).ToList();

            // Get the list of itemId in orderdetails are in "Ordered" order
            List<int> itemInOrderList = (from OD in db.OrderDetail
                                         where OD.Order.OrderStatus.OrderStatusId == 3
                                         select OD.ItemId).ToList();

            // Get the list of itemId in orderdetails are in "Draft" order
            List<int> itemInDraftList = (from OD in db.OrderDetail
                                         where OD.Order.OrderStatus.OrderStatusId == 1
                                         select OD.ItemId).ToList();
            // Get the list of itemId in orderdetails are in "Enquiry" order
            List<int> itemInEnquiryList = (from OD in db.OrderDetail
                                         where OD.Order.OrderStatus.OrderStatusId == 2
                                         select OD.ItemId).ToList();

            // Filter out 3 lists based on supplier Rank for each item
            List<InventoryController.InventoryContainer> itemlistS1 = inventoryContainersList.Where(S => S.rank == 1).ToList();
            List<InventoryController.InventoryContainer> itemlistS2 = inventoryContainersList.Where(S => S.rank == 2).ToList();
            List<InventoryController.InventoryContainer> itemlistS3 = inventoryContainersList.Where(S => S.rank == 3).ToList();

            List<ViewInventory> viewInventories = new List<ViewInventory>();

            for (int i = 0; i < itemlistS1.Count; i++)
            {
                ViewInventory newEntry = new ViewInventory()
                {
                    itemId = itemlistS1[i].itemId,
                    description = itemlistS1[i].description,
                    quantity = itemlistS1[i].quantity,
                    rOLevel = itemlistS1[i].roLevel,
                    rOQty = itemlistS1[i].roQty,
                    unit = itemlistS1[i].unit,
                    location = itemlistS1[i].location,
                    supplier1 = itemlistS1[i].supplier,
                    supplier2 = itemlistS2[i].supplier,
                    supplier3 = itemlistS3[i].supplier
                };
                //if low stock level but in an existing orderdetails, status  is Ordered 
                //if low stock level and not found in existing orderdetails, status is InSufficient
                if (itemlistS1[i].quantity <= itemlistS1[i].roLevel)
                {
                    if (itemInOrderList.Contains(itemlistS1[i].itemId))
                    {
                        newEntry.status = "Ordered";
                    }else if (itemInDraftList.Contains(itemlistS1[i].itemId))
                    {
                        newEntry.status = "Drafted";
                    }
                    else if (itemInEnquiryList.Contains(itemlistS1[i].itemId))
                    {
                        newEntry.status = "Enquiring";
                    }
                    else { newEntry.status = "Insufficient"; }
                }
                else { newEntry.status = "Sufficient"; }

                viewInventories.Add(newEntry);
            }
            return viewInventories;
        }

        public Boolean CheckifAdjExist(ADProjectDb db, int itemId, int voucherid)
        {
            AdjustmentDetail Ad = db.AdjustmentDetail.Where(x => x.AdjustmentVoucherId == voucherid)
                                                     .Where(x => x.ItemCatalogueId == itemId)
                                                     .FirstOrDefault();
            if (Ad == null)
            {
                return false;
            }
            else return true;
        }
        public void UpdateAdjDetails(ADProjectDb db, int itemId, int voucherid, int AdjQty, string VoucherReason)
        {
            AdjustmentDetail Ad = db.AdjustmentDetail.Where(x => x.AdjustmentVoucherId == voucherid)
                                         .Where(x => x.ItemCatalogueId == itemId)
                                         .FirstOrDefault();
            Ad.Quantity = Ad.Quantity + AdjQty;
            double price = (from IC in db.ItemCatalogue
                            join SC in db.SupplierCatalogue
                            on IC.ItemCatalogueId equals SC.ItemId
                            where SC.SupplierRank == 1
                            where IC.ItemCatalogueId == itemId
                            select SC.ItemPrice).FirstOrDefault();
            Ad.Cost = Ad.Quantity * price;  
            Ad.Reason = VoucherReason;
            db.SaveChanges();
        }
        public void CreateEmptyVoucher(ADProjectDb db, int empId)
        {
            Employee employee = db.Employee.Where(x => x.EmployeeId == empId).FirstOrDefault();
            AdjustmentVoucher newEntry = new AdjustmentVoucher() { RaisedByEmployee = employee, AdjustmentStatusId = 1 };
            db.AdjustmentVoucher.Add(newEntry);
            db.SaveChanges();
        }
    }
}