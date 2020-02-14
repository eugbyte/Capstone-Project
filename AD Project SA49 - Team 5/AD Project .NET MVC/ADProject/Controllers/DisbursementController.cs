using ADProject.Data;
using ADProject.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using System.Diagnostics;
using PagedList;
using ADProject.Services.Disbursements;
using System;
using ADProject.Filters;

namespace ADProject.Controllers
{
    [AuthenticationFilter]
    [StoreClerkFilter]
    public class DisbursementController : Controller
    {
        //Dependency injection
        private IDisbursement disbursementService;
        public DisbursementController()
        {
            disbursementService = new DisbursementService();
        }

        public class Container
        {
            public ItemCatalogue ItemCatalogue { get; set; }
            public DisbursementDetail DisbursementDetail { get; set; }
            public RequestDetail RequestDetail { get; set; }
            public DisbursementStatus DisbursementStatus { get; set; }
            public CollectionPoint CollectionPoint { get; set; }
            public Department Department { get; set; }
        }

        public ActionResult Index(Department department, CollectionPoint collectionPoint, int? page)
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = disbursementService.GetContainers(db) ?? new List<Container>();

                List<Container> selectListContainers = containers.ConvertAll(ce => ce).ToList();   //deep copy
                SelectList_Department_DisbursementStatus_CollectionPoints(db, selectListContainers);
                DisbursementStatus collectedDisbursementStatus = db.DisbursementStatus.Where(ds => ds.Description == StatusEnums.DisbursementStatusEnum.COLLECTED.ToString()).SingleOrDefault();
                ViewData["collectedDisbursementStatus"] = collectedDisbursementStatus;

                if (collectionPoint.CollectionPointId != 0)
                {
                    containers = containers.Where(ce => ce.CollectionPoint.CollectionPointId == collectionPoint.CollectionPointId)
                        .ToList();
                }

                if (department.DepartmentId != 0)
                {
                    containers = containers.Where(ce => ce.Department.DepartmentId == department.DepartmentId)
                        .ToList();
                }

                ViewData["results"] = containers;

                int pageSize = 5;
                int pageNumber = (page ?? 1);
                return View(containers.ToPagedList(pageNumber, pageSize));
            }
            
        }
      
        public ActionResult Edit(Container container)
        {
            var db = new ADProjectDb();
            Employee employee = Session["employee"] as Employee;
            List<Container> containers = disbursementService.GetContainers(db);

            Container targetContainer = containers.Where(ce => ce.DisbursementDetail.DisbursementDetailId == container.DisbursementDetail.DisbursementDetailId)
                .SingleOrDefault();
            ViewData["container"] = targetContainer;

            List<Container> otherContainers = containers.Where(ce => ce.ItemCatalogue.ItemCatalogueId == container.ItemCatalogue.ItemCatalogueId)
                .Where(ce => ce.Department.DepartmentId != targetContainer.Department.DepartmentId)
                .Distinct().ToList();
            List<SelectListItem> selectListOtherDepartments = otherContainers.Select(ce => new SelectListItem
            {
                Text = ce.Department.DepName + " | DibursementDetail Id: " + ce.DisbursementDetail.DisbursementDetailId.ToString(),
                Value = ce.DisbursementDetail.DisbursementDetailId.ToString()
            }).ToList();

            ViewData["selectListOtherDepartments"] = selectListOtherDepartments;
            
            
            return View();
        }

        public ActionResult Save(int? disburseQuantity, int? recipientDisbursementDetailId, int? transferorDisbursementDetailId)
        {
            using (var db = new ADProjectDb())
            {
                disbursementService.SaveDisbursement(db, disburseQuantity, recipientDisbursementDetailId, transferorDisbursementDetailId);
            }                     

            return RedirectToAction("Index");
        }

        public ActionResult SaveStatus(int disbursementStatusId, int? disbursementDetailId)
        {
            var db = new ADProjectDb();
            disbursementService.SaveStatus(db, disbursementStatusId, disbursementDetailId);
            ReduceQuantity(db, (int)disbursementDetailId, disbursementStatusId);

            string hrefLink = "#" + disbursementDetailId.ToString();
            return Redirect(Url.Action("Index", "Disbursement") + hrefLink);
        }

        public void ReduceQuantity(ADProjectDb db, int disbursementDetailId, int disbursementStatusId)
        {
            DisbursementStatus disbursementStatus = db.DisbursementStatus
                .Where(ds => ds.DisbursementStatusId == disbursementStatusId)
                .SingleOrDefault();

            if (disbursementStatus.Description != StatusEnums.DisbursementStatusEnum.COLLECTED.ToString())
                return;

            DisbursementDetail disbursementDetail = db.DisbursementDetail
                .Where(dd => dd.DisbursementDetailId == disbursementDetailId)
                .SingleOrDefault();

            StockInfo stockInfo = db.StockInfo
                .Where(stock => stock.ItemCatalogueId == disbursementDetail.ItemCatalogueId)
                .SingleOrDefault();

            stockInfo.StockQuantity -= disbursementDetail.DisburseQuantity;
            db.SaveChanges();
        }

        public void SelectList_Department_DisbursementStatus_CollectionPoints(ADProjectDb db, List<Container> selectListContainers)
        {
            ViewData["selectListDepartments"] = selectListContainers.Select(ce => ce.Department)
                .Distinct().ToList();
            ViewData["selectListCollectionPoints"] = selectListContainers.Select(ce => ce.CollectionPoint)
                .Distinct().ToList();

            List<SelectListItem> selectListDisbursementStatus = db.DisbursementStatus
                .Select(ds => new SelectListItem
                {
                    Text = ds.Description,
                    Value = ds.DisbursementStatusId.ToString()
                }).ToList();
            ViewData["selectListStatus"] = selectListDisbursementStatus;
        }
    }
}
