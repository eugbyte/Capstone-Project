using ADProject.Data;
using ADProject.Models;
using ADProject.Services.Representative;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using static ADProject.Controllers.RepresentativeController;
using ADProject.ViewModels;


namespace ADProject.Controllers.APIs
{
    public class RepresentativeRESTController : ApiController
    {
        private IRepresentative representativeService;

        public RepresentativeRESTController()
        {
            representativeService = new RepresentativeService();
        }

        public class JsonContainer
        {
            //Request
            public int RequestId { get; set; }
            public string RequestDate { get; set; }

            public int DepartmentId { get; set; }

            //ItemCatalogue
            public int ItemCatalogueId { get; set; }
            public string ItemDes { get; set; }

            //CollectionPoint
            public int CollectionPointId { get; set; }
            public string Location { get; set; }            

            //Disbursement
            public int DisbursementDetailId { get; set; }
            public int DisburseQuantity { get; set; }

        }

        [HttpGet]
        [Route("api/representative/collectItems/{employeeId:int?}")]
        public IHttpActionResult GetItemsToCollect(int? employeeId)
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = representativeService.GetCollectRequestedItems(db, employeeId);

                List<JsonContainer> jsonContainers = TransformToJsonContainer(containers);
                return Ok(jsonContainers);
            }
        }

        [HttpPatch]
        [Route("api/representative/collectItems")]
        public IHttpActionResult PutItemsToCollect(JsonContainer jsonContainer)
        {
            using (var db = new ADProjectDb())
            {
                int requestId = jsonContainer.RequestId;
                representativeService.SetRequestStatusToDelivered(db, requestId);
                return Ok();
            }
        }

        [HttpGet]
        [Route("api/representative/changeCollectionPoint/{employeeId?}")]
        public IHttpActionResult GetLatestCollectionPoint(int? employeeId)
        {
            
            using (var db = new ADProjectDb())
            {
                CollectionPoint collectionPoint = representativeService.GetLatestCollectionPoint(db, employeeId);
                string currentLocation = collectionPoint.Location;
                List<JsonContainer> allCollectionPoints = GetAllCollectionPoints();

                return Ok(new {
                    currentLocation,
                    allCollectionPoints
                });
            }
        }

        [HttpPatch]
        [Route("api/representative/changeCollectionPoint/{employeeId?}")]
        public IHttpActionResult PutCollectionPoint(JsonContainer jsonContainer, int? employeeId)
        {
            using (var db = new ADProjectDb())
            {
                int collectionPointId = jsonContainer.CollectionPointId;
                representativeService.UpdateCollectionPointForAllRequest(db, collectionPointId, employeeId);

                return Ok();
            }
        }


        public List<JsonContainer> GetAllCollectionPoints()
        {
            using (var db = new ADProjectDb())
            {
                List<Container> collectionPointContainers = db.CollectionPoint
                    .Distinct()
                    .Select(cp => new Container
                    {
                        CollectionPoint = cp
                    })
                    .ToList();
                List<JsonContainer> jsonContainers = TransformToJsonContainer(collectionPointContainers);
                return jsonContainers;
            }
        }

        protected List<JsonContainer> TransformToJsonContainer(List<Container> containers)
        {

            List<JsonContainer> jsonContainers = containers.Select(ce =>
            {
                JsonContainer jsonContainer = new JsonContainer();
                if (ce.Request != null)
                {
                    jsonContainer.RequestId = ce.Request.RequestId;
                    jsonContainer.DepartmentId = ce.Request.DepartmentId;
                    jsonContainer.RequestDate = ce.Request.RequestDate.ToString();
                }
                if (ce.ItemCatalogue != null)
                {
                    jsonContainer.ItemCatalogueId = ce.ItemCatalogue.ItemCatalogueId;
                    jsonContainer.ItemDes = ce.ItemCatalogue.ItemDes;
                }
                if (ce.CollectionPoint != null)
                {
                    jsonContainer.CollectionPointId = ce.CollectionPoint.CollectionPointId;
                    jsonContainer.Location = ce.CollectionPoint.Location;
                }
                if (ce.DisbursementDetail != null)
                {
                    jsonContainer.DisbursementDetailId = ce.DisbursementDetail.DisbursementDetailId;
                    jsonContainer.DisburseQuantity = ce.DisbursementDetail.DisburseQuantity;
                }

                return jsonContainer;
            }).ToList();

            return jsonContainers;
        }
    }
}
