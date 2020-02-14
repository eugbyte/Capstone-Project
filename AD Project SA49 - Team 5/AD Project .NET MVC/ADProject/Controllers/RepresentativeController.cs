using ADProject.Data;
using ADProject.Filters;
using ADProject.Models;
using ADProject.Services.Representative;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using static ADProject.StatusEnums;

namespace ADProject.Controllers
{
    [AuthenticationFilter]
    [RepresentativeFilter]
    public class RepresentativeController : Controller
    {
        private IRepresentative representativeService;

        public RepresentativeController()
        {
            representativeService = new RepresentativeService();
        }
        public class Container
        {
            public RequestDetail RequestDetail { get; set; }
            public Request Request { get; set; }
            public RequestStatus RequestStatus { get; set; }
            public ItemCatalogue ItemCatalogue { get; set; }
            public CollectionPoint CollectionPoint { get; set; }
            public DisbursementDetail DisbursementDetail { get; set; }
            public DisbursementStatus DisbursementStatus { get; set; }
            public Category Category { get; set; }

        }

        
        // GET: Representative
        public ActionResult Index()
        {
            using (var db = new ADProjectDb())
            {
                
                List<Container> containers = representativeService.GetContainers(db);
                int totalQuantity = containers.Sum(ce => ce.RequestDetail.Quantity);
                CollectionPoint currentCollectionPoint = representativeService.GetLatestCollectionPoint(db);

                List<SelectListItem> selectListCollectionPoints = db.CollectionPoint
                    .Select(cp => new SelectListItem
                    {
                        Value = cp.CollectionPointId.ToString(),
                        Text = cp.Location,
                        Selected = cp.CollectionPointId == currentCollectionPoint.CollectionPointId ? true : false
                    }).ToList();

                ViewData["totalQuantity"] = totalQuantity;
                ViewData["containers"] = containers;
                ViewData["selectListCollectionPoints"] = selectListCollectionPoints;

                
                ViewData["currentCollectionPoint"] = currentCollectionPoint;
                return View();
            }
            
        }        

        public ActionResult Save(int collectionPointId)
        {
            using (var db = new ADProjectDb())
            {
                representativeService.UpdateCollectionPointForAllRequest(db, collectionPointId);

            }
                return RedirectToAction("Index", "Representative");
        }

        public ActionResult CollectRequestedItems()
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = representativeService.GetCollectRequestedItems(db);
  
                ViewData["containers"] = containers;
                return View();
            }

        }

        public ActionResult AcceptDelivery(int requestId)
        {
            using (var db = new ADProjectDb())
            {
                representativeService.SetRequestStatusToDelivered(db, requestId);
            }
            return RedirectToAction("CollectRequestedItems", "Representative");
        }


    }

    
}