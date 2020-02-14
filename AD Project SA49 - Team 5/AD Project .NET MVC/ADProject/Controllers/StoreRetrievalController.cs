using ADProject.Controllers.APIs;
using ADProject.Data;
using ADProject.Filters;
using ADProject.Models;
using ADProject.Services.Disbursements;
using ADProject.Services.StoreRetrieval;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using static ADProject.StatusEnums;

namespace ADProject.Controllers
{
    [AuthenticationFilter]
    [StoreClerkFilter]
    public class StoreRetrievalController : Controller
    {
        private IDisbursement disbursementService;
        private IStoreRetrieval storeRetrievalService;

        public StoreRetrievalController()
        {
            disbursementService = new DisbursementService();
            storeRetrievalService = new StoreRetrievalService();
        }
        public class Container
        {
            public ItemCatalogue ItemCatalogue { get; set; }
            public DisbursementDetail DisbursementDetail { get; set; }
            public Request Request { get; set; }
            public RequestDetail RequestDetail { get; set; }
            public DisbursementStatus DisbursementStatus { get; set; }
            public StockInfo StockInfo { get; set; }
        }

        public class GroupedContainer
        {
            public string ItemDes { get; set; }
            public int Quantity { get; set; }
            public string ItemLocation { get; set; }
        }

        public ActionResult Index()
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = storeRetrievalService.GetContainers(db);
                ViewData["containers"] = containers;

                List<GroupedContainer> groupedContainers = storeRetrievalService.GetGroupedContainers(containers);

                ViewData["groupedContainers"] = groupedContainers;

                List<SelectListItem> selectListDisbursementStatus = db.DisbursementStatus
                    .Where(ds => ds.Description != DisbursementStatusEnum.COLLECTED.ToString())
                    .Select(ds => new SelectListItem
                    {
                        Text = ds.Description,
                        Value = ds.DisbursementStatusId.ToString()
                    }).ToList();
                ViewData["selectListStatus"] = selectListDisbursementStatus;

            }

            return View();
        }

        public ActionResult SaveStatus(int disbursementStatusId, int? disbursementDetailId, int? disburseQuantity)
        {
            using (var db = new ADProjectDb())
            {
                disbursementService.SaveStatus(db, disbursementStatusId, disbursementDetailId, disburseQuantity);
            }                

            return RedirectToAction("Index", "StoreRetrieval");
        }

        
        
    }
}