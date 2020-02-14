using ADProject.Data;
using ADProject.Models;
using ADProject.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ADProject.Controllers;

namespace ADProject.Services.Inventory
{
    interface IInventory
    {
        public ItemCatalogue GetItemCatalogue(ADProjectDb db, int itemId);

        public List<AdjustmentVoucher> GetAdjustmentVoucherListByEmpIdStatusId(ADProjectDb db,int empId, int statusId);

        public void AddtoAdjustmentVoucher(ADProjectDb db,int voucherId, AdjustmentDetail AD);

        public List<ViewInventory> GetListofViewIntentory(ADProjectDb db);
        public void CreateEmptyVoucher(ADProjectDb db,int empId);
        public Boolean CheckifAdjExist(ADProjectDb db, int itemId, int voucherid);
        public void UpdateAdjDetails(ADProjectDb db, int itemId, int voucherid, int AdjQty, string VoucherReason);
        public List<ViewInventory> FilterBySearchAndStatus(ADProjectDb db, string search, string stockstatus, List<ViewInventory> viewInventories);
    }
}
