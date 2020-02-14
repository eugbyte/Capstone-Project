using ADProject.Data;
using ADProject.Models;
using ADProject.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using static ADProject.Controllers.AdjustmentVoucherController;

namespace ADProject.Services.AdjustmentVouchers
{
    public class AdjustmentVoucherServices : IAdjustmentVoucher
    {
        public List<RequisitionInfo> GetRequisitionInfos(ADProjectDb db)
        {
            List<RequisitionInfo> requisitionInfos = (from r in db.Request
                                                      join rd in db.RequestDetail
                                                      on r.RequestId equals rd.RequestId
                                                      join item in db.ItemCatalogue
                                                      on rd.ItemCatalogueId equals item.ItemCatalogueId
                                                      join dep in db.Department
                                                      on r.DepartmentId equals dep.DepartmentId
                                                      join em in db.Employee
                                                      on r.ApprByEmp.EmployeeId equals em.EmployeeId
                                                      join rs in db.RequestStatus
                                                      on r.RequestStatusId equals rs.RequestStatusId
                                                      select new RequisitionInfo()
                                                      {
                                                          RequisitionNo = r.RequestId,
                                                          ItemId = item.ItemCatalogueId,
                                                          Description = item.ItemDes,
                                                          Quantity = rd.Quantity,
                                                          Unit = item.UnitOfMeasure,
                                                          DepartmentName = dep.DepName,
                                                          DepartmentId = dep.DepartmentId,
                                                          RaisedBy = em.LastName + em.FirstName,
                                                          RequestDate = r.RequestDate,
                                                          Status = rs.RequestStatusDescription
                                                      }).ToList();
            return requisitionInfos;
        }

        public double getUnitPrice(ADProjectDb db, string itemdes)
        {
            int itemId = db.ItemCatalogue.Where(item => item.ItemDes == itemdes)
                   .Select(item => item.ItemCatalogueId).SingleOrDefault();
            double unitPrice = db.SupplierCatalogue
                .Where(sc => sc.ItemCatalogue.ItemCatalogueId == itemId)
                .OrderBy(sc => sc.SupplierRank)
                .Select(sc => sc.ItemPrice)
                .FirstOrDefault();
            return unitPrice;
        }

        public AdjustmentVoucher CreateAdjustmentVoucher(ADProjectDb db, int employeeId)
        {
            Employee raise = db.Employee.Where(em => em.EmployeeId == employeeId).SingleOrDefault();
            Employee approve = db.Employee.Where(em => em.EmployeeId == employeeId).SingleOrDefault();

            AdjustmentVoucher NewVoucher = new AdjustmentVoucher() { RaiseDate = DateTime.Now, ApproveDate = DateTime.Now, AdjustmentStatusId = 1 };

            NewVoucher.AdjustmentVoucherId = (from ad in db.AdjustmentVoucher
                                              orderby ad.AdjustmentVoucherId descending
                                              select ad.AdjustmentVoucherId).First() + 1;
            return NewVoucher;
        }

        public List<VoucherInfo> GetAllVoucherInfo(ADProjectDb db)
        {
            List<VoucherInfo> adjustments = (from a in db.AdjustmentVoucher
                                             join ad in db.AdjustmentDetail
                                             on a.AdjustmentVoucherId equals ad.AdjustmentVoucherId

                                             join ads in db.AdjustmentStatus
                                             on a.AdjustmentStatusId equals ads.AdjustmentStatusId
                                             group new { a, ad, ads } by new { a.AdjustmentVoucherId, a.RaiseDate, ads.Description } into g
                                             select new VoucherInfo()
                                             {
                                                 VoucherNo = g.Key.AdjustmentVoucherId,

                                                 RequestDate = g.Key.RaiseDate,
                                                 TotalCost = g.Sum(x => x.ad.Cost),
                                                 Status = g.Key.Description
                                             }).ToList();
            return adjustments;
        }

        public List<ViewAdjustmentDetail> GetViewAdjustmentDetailList(ADProjectDb db, int VoucherId)
        {

            List<ViewAdjustmentDetail> viewAdjustmentDetails = (from IC in db.ItemCatalogue
                                                               join AD in db.AdjustmentDetail
                                                               on IC.ItemCatalogueId equals AD.ItemCatalogueId
                                                               where AD.AdjustmentVoucherId == VoucherId
                                                               join SC in db.SupplierCatalogue
                                                               on IC.ItemCatalogueId equals SC.ItemId
                                                               where SC.SupplierRank == 1 
                                                               orderby AD.ItemCatalogueId
                                                               select new ViewAdjustmentDetail()
                                                               {
                                                                   voucherId = AD.AdjustmentVoucherId,
                                                                   itemId = IC.ItemCatalogueId,
                                                                   description = IC.ItemDes,
                                                                   quantity = AD.Quantity,
                                                                   price = SC.ItemPrice,
                                                                   unit = IC.UnitOfMeasure,
                                                                   reason = AD.Reason
                                                               }).ToList();
            return viewAdjustmentDetails;

        }
        public AdjustmentVoucher GetOrder(ADProjectDb db, int VoucherId)
        {
            AdjustmentVoucher AV = db.AdjustmentVoucher.Where(x => x.AdjustmentVoucherId == VoucherId).FirstOrDefault();
            return AV;
        }
    }
}