using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ADProject.Controllers.RepresentativeController;

namespace ADProject.Services.Representative
{
    interface IRepresentative
    {
        List<Container> GetContainers(ADProjectDb db);
        CollectionPoint GetLatestCollectionPoint(ADProjectDb db, int? employeeId = null);
        void UpdateCollectionPointForAllRequest(ADProjectDb db, int collectionPointId, int? employeeId = null);
        Employee GetEmployee(ADProjectDb db);
        List<Container> GetCollectRequestedItems(ADProjectDb db, int? employeeId = null);
        void SetRequestStatusToDelivered(ADProjectDb db, int requestId);
    }
}
