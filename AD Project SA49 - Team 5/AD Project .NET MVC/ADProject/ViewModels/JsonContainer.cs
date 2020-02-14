using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.ViewModels
{
    //JsonContainer only contains primitive type to prevent Serializable errors
    public class JsonContainer
    {
        //Request
        public int RequestId { get; set; }
        public int DepartmentId { get; set; }
        public DateTime? RequestDate { get; set; }

        //RequestDetail
        public int RequestDetailId { get; set; }
        public int Quantity { get; set; }
        
        //RequestStatus
        public int RequestStatusId { get; set; }
        public string RequestStatusDescription { get; set; }

        //ItemCatalogue
        public int ItemCatalogueId { get; set; }
        public string UnitOfMeasure { get; set; }
        public string ItemDes { get; set; }

        //CollectionPoint
        public int CollectionPointId { get; set; }
        public string Location { get; set; }

        //Category
        public int CategoryId { get; set; }
        public string CategoryDescription { get; set; }

        //Disbursement
        public int DisbursementId { get; set; }

        //DisbursementDetail
        public int DisbursementDetailId { get; set; }
        public int DisburseQuantity { get; set; }

        //DisbursementStatus
        public int DisbursementStatusId { get; set; }
        public string DisbursementStatusDescription { get; set; }

        //StockInfo
        public int StockInfoId { get; set; }
        public string ItemLocation { get; set; }
    }
}