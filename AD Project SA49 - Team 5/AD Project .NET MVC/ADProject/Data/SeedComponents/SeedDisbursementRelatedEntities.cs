using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.Data
{
    public class SeedDisbursementRelatedEntities
    {
        public static void SeedEntities(ADProjectDb context)
        {
            Request request = context.Request.FirstOrDefault();

            CollectionPoint collectionPoint = new CollectionPoint();
            collectionPoint.Location = "CANTEEN";
            collectionPoint.Employee = context.Employee.FirstOrDefault();

            List<DisbursementStatus> disbursementStatuses = new List<DisbursementStatus>()
            {
                new DisbursementStatus("FULFILLED"),
                new DisbursementStatus("UNFULFILLED")
            };

            Disbursement disbursement = new Disbursement();
            disbursement.Request = context.Request.ToList();
            //disbursement.Employee = context.Employee.FirstOrDefault();
            disbursement.Department = context.Department.SingleOrDefault(dep => dep.DepartmentId == 1);
            DisbursementDetail disbursementDetail = new DisbursementDetail();
            disbursementDetail.Disbursement = disbursement;
            disbursementDetail.DisbursementStatus = disbursementStatuses[0];
            disbursementDetail.ItemCatalogue = context.ItemCatalogue.FirstOrDefault();            

            context.CollectionPoint.Add(collectionPoint);
            context.DisbursementStatus.AddRange(disbursementStatuses);
            context.Disbursement.Add(disbursement);
            context.DisbursementDetail.Add(disbursementDetail);                    

            context.SaveChanges();     

        }
    }
}