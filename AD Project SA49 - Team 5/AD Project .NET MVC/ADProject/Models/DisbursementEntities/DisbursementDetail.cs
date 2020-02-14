using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class DisbursementDetail
    {
        public int DisbursementDetailId { get; set; }

        //1 DisbursementDetail to 1 Disbursement
        public int DisbursementId { get; set; }
        public virtual Disbursement Disbursement { get; set; }


        //1 Disbursement to 1 ItemCatalogue
        public int ItemCatalogueId { get; set; }        
        public virtual ItemCatalogue ItemCatalogue { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Only positive number allowed")]
        public int DisburseQuantity { get; set; }
        
        //1 Disbursement to 1 DisbursementStatus        
        public int DisbursementStatusId { get; set; }
        public virtual DisbursementStatus DisbursementStatus { get; set; }
    }

}