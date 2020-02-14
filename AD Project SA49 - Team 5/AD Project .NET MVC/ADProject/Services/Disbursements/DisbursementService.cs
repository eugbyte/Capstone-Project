using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using static ADProject.Controllers.DisbursementController;

namespace ADProject.Services.Disbursements
{
    public class DisbursementService : IDisbursement
    {
        public List<Container> GetContainers(ADProjectDb db)
        {
            //cannot use using(db) {...}, which will dispose of the db context which another method within DisbusementController needs
            IQueryable<Container> queryResults = from dd in db.DisbursementDetail
                                                 join item in db.ItemCatalogue
                                                 on dd.ItemCatalogueId equals item.ItemCatalogueId
                                                 join rd in db.RequestDetail
                                                 on dd.Disbursement.RequestId equals rd.RequestId
                                                 where dd.DisbursementStatus.Description == StatusEnums.DisbursementStatusEnum.READY_FOR_COLLECTION.ToString()
                                                    select new Container()
                                                    {
                                                        DisbursementDetail = dd,
                                                        ItemCatalogue = item,
                                                        RequestDetail = rd,
                                                        DisbursementStatus = dd.DisbursementStatus,
                                                        CollectionPoint = dd.Disbursement.CollectionPoint,
                                                        Department = rd.Request.Department
                                                    };
            return queryResults.ToList();
            
        }

        public void SaveDisbursement(ADProjectDb db, int? disburseQuantity, int? recipientDisbursementDetailId, int? transferorDisbursementDetailId)
        {
            DisbursementDetail transferorDD = db.DisbursementDetail
                .Where(dd => dd.DisbursementDetailId == transferorDisbursementDetailId)
                .SingleOrDefault();

            DisbursementDetail recipientDD = db.DisbursementDetail
                .Where(dd => dd.DisbursementDetailId == recipientDisbursementDetailId)
                .SingleOrDefault();

            transferorDD.DisburseQuantity -= (int)disburseQuantity;
            recipientDD.DisburseQuantity += (int)disburseQuantity;
            db.SaveChanges();
        }

        public void SaveStatus(ADProjectDb db, int disbursementStatusId, int? disbursementDetailId, int? disburseQuantity = null)
        {
            DisbursementDetail disbursementDetail = db.DisbursementDetail
                .Where(dd => dd.DisbursementDetailId == disbursementDetailId)
                .SingleOrDefault();
            DisbursementStatus disbursementStatus = db.DisbursementStatus
                .Where(ds => ds.DisbursementStatusId == disbursementStatusId)
                .SingleOrDefault();

            disbursementDetail.DisbursementStatus = disbursementStatus;
            if (disburseQuantity != null)
                disbursementDetail.DisburseQuantity = (int)disburseQuantity;
            db.SaveChanges();

            
            
        }
    }
}