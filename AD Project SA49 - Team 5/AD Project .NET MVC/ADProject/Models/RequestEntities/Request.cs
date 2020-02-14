using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class Request
    {
        public int RequestId { get; set; }

       public int DepartmentId { get; set; }
        public virtual Department Department { get; set; }

        public DateTime? ApprByDate { get; set; }

        //public int EmpId { get; set; }
        [Column("EmpId")]
        public virtual Employee RaisedByEmployee { get; set; }

        //public int ApproveByEmpId { get; set; }
        [Column("ApprByEmpId")]
        public virtual Employee ApprByEmp { get; set; }

        public int RequestStatusId { get; set; }
        public virtual RequestStatus RequestStatus { get; set; }
        
        public String RequestComment { get; set; }
        public String DepHeadComment { get; set; }

        public DateTime? RequestDate { get; set; }

        //Test this
        public virtual ICollection<RequestDetail> RequestDetail { get; set; }

        //Added this
        public virtual CollectionPoint CollectionPoint { get; set; }

    }
}