using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class AdjustmentVoucher
    {
        public int AdjustmentVoucherId { get; set; }
        public DateTime? RaiseDate { get; set; }
        public DateTime? ApproveDate { get; set; }
        
        //1 AdjustmentVoucher to 1 AdjustmentStatus
        public int AdjustmentStatusId { get; set; }
        public virtual AdjustmentStatus AdjustmentStatus { get; set; }

        public virtual Employee RaisedByEmployee { get; set; }
        public virtual Employee ApprovedByEmployee { get; set; }

        //1 AdjustmentVoucher to many AdjustmentDetails
        public int AdjustmentDetailId { get; set; }
        public virtual ICollection<AdjustmentDetail> AdjustmentDetail { get; set; }
    }
}