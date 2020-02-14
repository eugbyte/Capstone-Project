using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ADProject.Controllers.DepartmentHeadController;

//Eugene
namespace ADProject.Services.DepartmentHead
{
    interface IDepartmentHead
    {
        public List<Container> GetPendingRequestContainers(ADProjectDb db);
        public void CreateDisbursementForApprovedRequest(ADProjectDb db, int requestId, int? collectionPointId, int quantity, int itemCatalogueId);
        public void UpdateDisbursementForApprovedRequest(ADProjectDb db, int requestId, int collectionPointId);
        public void DeleteDisbursementForDisapprovedRequest(ADProjectDb db, int requestId);
        public void UpdateCollectionPointOnlyForRequest(ADProjectDb db, int requestId, int collectionPointId);

        public List<Container> GetNonPendingRequestContainers(ADProjectDb db);
    }
}
