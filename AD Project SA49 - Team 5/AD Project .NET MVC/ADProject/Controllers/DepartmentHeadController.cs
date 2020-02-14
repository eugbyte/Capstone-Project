using ADProject.Data;
using ADProject.Filters;
using ADProject.Models;
using ADProject.Services.DepartmentHead;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ADProject.Controllers
{
    [AuthenticationFilter]
    [DepartmentHeadOrTempFilter]
    public class DepartmentHeadController : Controller
    {
        private IDepartmentHead departmentHeadService;

        //Dependency Injection
        public DepartmentHeadController()
        {
            departmentHeadService = new DepartmentHeadService();
        }

        public class Container
        {
            public RequestDetail RequestDetail { get; set; }
            public Request Request { get; set; }
            public RequestStatus RequestStatus { get; set; }
            public ItemCatalogue ItemCatalogue { get; set; }
            public Category Category { get; set; }
            public DisbursementStatus DisbursementStatus { get; set; }
            public DisbursementDetail DisbursementDetail { get; set; }
            public CollectionPoint CollectionPoint { get; set; }

        }
        public ActionResult ApproveRequest(int? page)
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = departmentHeadService.GetPendingRequestContainers(db);
                //----

                //List<Container> containers = GetContainersForApproval();
                ViewData["containers"] = containers;

                List<CollectionPoint> collectionPoints = db.CollectionPoint.ToList();
                ViewData["collectionPoints"] = collectionPoints;

                List<RequestStatus> requestStatuses = db.RequestStatus
                    .Where(rs => rs.RequestStatusDescription != StatusEnums.RequestStatusEnum.DELIVERED.ToString())
                    .ToList();
                ViewData["requestStatuses"] = requestStatuses;

                int pageSize = 5;
                int pageNumber = (page ?? 1);
                return View(containers.ToPagedList(pageNumber, pageSize));
            }

        }

        public ActionResult SaveApproval(int? itemCatalogueId, int? quantity, int? requestId, int? requestStatusId, int? collectionPointId = 1)
        {
            using (var db = new ADProjectDb())
            {
                Request request = db.Request.Where(r => r.RequestId == requestId).SingleOrDefault();
                RequestStatus requestStatus = db.RequestStatus.Where(rs => rs.RequestStatusId == requestStatusId).SingleOrDefault();

                request.RequestStatus = requestStatus;
                db.SaveChanges();

                string APPROVED = StatusEnums.RequestStatusEnum.APPROVED.ToString();

                //Only if Request is approved, then create Disbursement
                if (requestStatus.RequestStatusDescription == APPROVED)
                {
                    if (AlreadyHasDisbursement((int)requestId) == false)
                    {
                        departmentHeadService.CreateDisbursementForApprovedRequest(db, (int)requestId, (int)collectionPointId, (int)quantity, (int)itemCatalogueId);
                    }
                }

                if (requestStatus.RequestStatusDescription != APPROVED)
                {
                    if (AlreadyHasDisbursement((int)requestId))
                    {
                        departmentHeadService.DeleteDisbursementForDisapprovedRequest(db, (int)requestId);
                    }                   
                }

                return RedirectToAction("ApproveRequest", "DepartmentHead");
            }
                
        }

        public ActionResult ApprovalHistory(int? page)
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = departmentHeadService.GetNonPendingRequestContainers(db);
                ViewData["containers"] = containers;
                int pageSize = 5;
                int pageNumber = (page ?? 1);
                return View(containers.ToPagedList(pageNumber, pageSize));
            }
        }

        public bool AlreadyHasDisbursement(int requestId)
        {
            var db = new ADProjectDb();
            Disbursement disbursement = db.Disbursement.Where(dd => dd.RequestId == requestId).FirstOrDefault();
            if (disbursement == null)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        
    }
}