using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ADProject.Controllers.RequestController;

//Eugene
namespace ADProject.Services.Requests
{
    interface IRequest
    {
        List<Container> GetContainersForIndex(ADProjectDb db, int? employeeId = null);
        List<Container> GetAndFilterContainersForCreateOrUpdate(ADProjectDb db, int? categoryId);
        void SaveRequest(ADProjectDb db, int itemCatalogueId, int quantity, bool? isUpdate, int? requestId);
        void DeleteRequest(ADProjectDb db, int requestId);
        string GetUnitOfMeasure(ADProjectDb db, int? itemCatalogueId);
    }
}
