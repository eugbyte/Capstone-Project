using ADProject.Data;
using ADProject.Models;
using ADProject.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ADProject.Controllers.AdjustmentVoucherController;


namespace ADProject.Services.AdjustmentVouchers
{
    interface IAdjustmentVoucher
    {
        List<RequisitionInfo> GetRequisitionInfos(ADProjectDb db);
        double getUnitPrice(ADProjectDb db, string itemdes);
        List<VoucherInfo> GetAllVoucherInfo(ADProjectDb db);
        AdjustmentVoucher CreateAdjustmentVoucher(ADProjectDb db, int employeeId);
        List<ViewAdjustmentDetail> GetViewAdjustmentDetailList(ADProjectDb db, int VoucherId);
        AdjustmentVoucher GetOrder(ADProjectDb db, int VoucherId);
    }
}
