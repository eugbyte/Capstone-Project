using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class Disbursement
    {
        
        public int DisbursementId { get; set; }

        //1 Disbursement to 1 Department
        public int DepartmentId { get; set; }
        public virtual Department Department { get; set; }

        //1 Disbursement to 1 Employee who collects
        //public int EmployeeId { get; set; }   //error, sql don't allow - may cause cycles or multiple cascade paths
        public virtual Employee Employee { get; set; }

        //1 Disbursement to many Requests
        //public ICollection<Request> Requests { get; set; }

        //1 Disbursement to 1 CollectionPoint
        public int CollectionPointId { get; set; }
        public virtual CollectionPoint CollectionPoint { get; set; }

        //1 Disbursement to Many Request
        public int RequestId { get; set; }
        public virtual ICollection<Request> Request { get; set; }

        public DateTime? DisburseDate { get; set; }

        //1 Disbursement to 1 Disbursement Detail - this part is FAILLING
        //FAILED
        //public DisbursementDetail DisbursementDetail { get; set; }

    }
}