using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ADProject.Controllers.DisbursementController;

namespace ADProject.Services.Disbursements
{
    interface IDisbursement
    {
        List<Container> GetContainers(ADProjectDb db);
        void SaveDisbursement(ADProjectDb db, int? disburseQuantity, int? recipientDisbursementDetailId, int? transferorDisbursementDetailId);
        void SaveStatus(ADProjectDb db, int disbursementStatusId, int? disbursementDetailId, int? disburseQuantity = null);
    }
}
