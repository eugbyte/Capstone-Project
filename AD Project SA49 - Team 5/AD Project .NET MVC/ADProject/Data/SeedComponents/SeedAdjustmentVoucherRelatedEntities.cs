using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.Data
{
    public class SeedAdjustmentVoucherRelatedEntities
    {
        public static void SeedEntities(ADProjectDb context)
        {
            StockInfo stockInfo = new StockInfo();
            stockInfo.ItemCatalogue = context.ItemCatalogue.FirstOrDefault();

            AdjustmentStatus adjustmentStatus = new AdjustmentStatus();
            adjustmentStatus.Description = "APPROVED";
                        
            AdjustmentDetail adjustmentDetail = new AdjustmentDetail();
            adjustmentDetail.ItemCatalogue = context.ItemCatalogue.FirstOrDefault();

            AdjustmentVoucher adjustmentVoucher = new AdjustmentVoucher();
            adjustmentVoucher.AdjustmentStatus = adjustmentStatus;
            adjustmentVoucher.AdjustmentDetail = new List<AdjustmentDetail>() { adjustmentDetail };

            context.StockInfo.Add(stockInfo);
            context.AdjustmentStatus.Add(adjustmentStatus);
            context.AdjustmentDetail.Add(adjustmentDetail);
            context.AdjustmentVoucher.Add(adjustmentVoucher);

            context.SaveChanges();          

        }
    }
}