using ADProject.Data;
using ADProject.Services.Requests;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using ADProject.ViewModels;
using static ADProject.Controllers.RequestController;
using ADProject.Services.DepartmentHead;
using ADProject.Models;
using ADProject.Services.Representative;

namespace ADProject.Controllers.APIs
{
    public class JsonContainer
    {
        public int ItemCatalogueId { get; set; }
        public int Quantity { get; set; }
        public string ItemDes { get; set; }
        public int RequestId { get; set; }
        public string RequestDate { get; set; }
        public string RequestStatusDescription { get; set; }

    }
    public class RequestRESTController : ApiController
    {
        //Dependency injection
        private IRequest requestService;

        public RequestRESTController()
        {
            requestService = new RequestService();
        }

        //edit this to include employee id
        [HttpGet]
        [Route("api/request/{employeeId?}")]
        public IHttpActionResult Get(int? employeeId = 3)
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = requestService.GetContainersForIndex(db, employeeId);
                try
                {
                    List<JsonContainer> jsonContainers = TransformToJsonContainer(containers);
                    if (jsonContainers == null)
                        return NotFound();

                    return Ok(jsonContainers);
                } catch (Exception exception)
                {
                    Debug.WriteLine(exception.Message);
                    return InternalServerError();
                }                
            }           
        }

        [HttpPost]
        [Route("api/request")]
        public IHttpActionResult Post(JsonContainer jsonContainer)
        {
            using (var db = new ADProjectDb())
            {
                int itemCatalogueId = jsonContainer.ItemCatalogueId;
                int quantity = jsonContainer.Quantity;                
                int requestId = jsonContainer.RequestId;
                bool isUpdate = false;

                if (itemCatalogueId != 0 && quantity != 0 && requestId != 0)
                {
                    requestService.SaveRequest(db, itemCatalogueId, quantity, isUpdate, requestId);
                    return Ok(new
                    {
                        msg = "successful update",
                        itemCatalogueId,
                        quantity,
                        requestId
                    });
                } 
                return InternalServerError();                
            }
        }    

        //must set to protected otherwise apiController treats this as a route
        //JsonContainer contain only primitive type to avoid Serialization errors
        protected List<JsonContainer> TransformToJsonContainer(List<Container> containers)
        {
            List<JsonContainer> jsonContainers = containers.Select(ce =>
            {
                JsonContainer jsonContainer = new JsonContainer();
                if (ce.Request != null)
                {
                    jsonContainer.RequestId = ce.Request.RequestId;
                    jsonContainer.RequestDate = ce.Request.RequestDate.ToString();
                }
                if (ce.RequestDetail != null)
                {
                    jsonContainer.Quantity = ce.RequestDetail.Quantity;
                }
                if (ce.ItemCatalogue != null)
                {
                    jsonContainer.ItemCatalogueId = ce.ItemCatalogue.ItemCatalogueId;
                    jsonContainer.ItemDes = ce.ItemCatalogue.ItemDes;
                }
                if (ce.RequestStatus != null)
                {
                    jsonContainer.RequestStatusDescription = ce.RequestStatus.RequestStatusDescription;
                }
                
                return jsonContainer;
            }).ToList();

            return jsonContainers;
        }

    }
}
