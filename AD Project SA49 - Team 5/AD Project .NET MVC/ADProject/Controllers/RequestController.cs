using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using ADProject.Filters;
using ADProject.Services.Requests;
using ADProject.Validation;


namespace ADProject.Controllers
{
    [AuthenticationFilter]
    [EmployeeFilter]
    public class RequestController : Controller
    {
        //Dependency Injection
        private IRequest requestService;        
        public RequestController()
        {
            requestService = new RequestService();
            
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

        public ActionResult Index(string search, int? page)
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = requestService.GetContainersForIndex(db);
                if (search != null)
                {
                    containers = containers.Where(ce => ce.ItemCatalogue.ItemDes.ToLower()
                    .Contains(search.ToLower()))
                        .ToList();
                }

                ViewData["containers"] = containers;

                int pageSize = 5;
                int pageNumber = (page ?? 1);

                return View(containers.ToPagedList(pageNumber, pageSize));
            }
                
        }

        public ActionResult Create(int? categoryId, int? itemCatalogueId)
        {
            using (var db = new ADProjectDb())
            {
                //To get the item select list filtered by the category
                List<Container> containers = requestService.GetAndFilterContainersForCreateOrUpdate(db, categoryId);
                ViewData["containers"] = containers;              
                SelectListItem_ItemCatalogue_CollectionPoint_Categories(db, containers);

                //The same page is used for both create and update, thus need to differentiate
                ViewData["isUpdate"] = false;
                RequestDetail requestDetail = new RequestDetail();
                ViewData["requestDetail"] = requestDetail;

                //To get the unit of measure based on the item selected
                string unitOfMeasure = requestService.GetUnitOfMeasure(db, itemCatalogueId);
                ViewData["chosenItemCatalogueId"] = itemCatalogueId;
                ViewData["unitOfMeasure"] = unitOfMeasure;

                return View();
            }
                
        }
        public ActionResult Update(bool? isUpdate, int? categoryId, int? requestId, int? itemCatalogueId, int? quantity, int? collectionPointId)
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = requestService.GetAndFilterContainersForCreateOrUpdate(db, categoryId);
                ViewData["containers"] = containers;

                if (categoryId == null)
                {
                    categoryId = db.ItemCatalogue
                        .Where(ic => ic.ItemCatalogueId == itemCatalogueId)
                        .Select(ic => ic.Category.CategoryId)
                        .SingleOrDefault();
                }

                //When updating, you want the select list to remember your choice
                SelectListItem_ItemCatalogue_CollectionPoint_Categories(db, containers, categoryId, itemCatalogueId, collectionPointId);

                //For update 
                isUpdate = ((isUpdate == null) ? false : true);
                ViewData["isUpdate"] = isUpdate;
                RequestDetail requestDetail = null;
                if (requestId != null)
                {
                    requestDetail = db.RequestDetail.Where(rd => rd.Request.RequestId == requestId).SingleOrDefault();
                }
                ViewData["requestDetail"] = requestDetail;

                //To get the unit of measure based on the item selected
                string unitOfMeasure = requestService.GetUnitOfMeasure(db, itemCatalogueId);
                ViewData["chosenItemCatalogueId"] = itemCatalogueId;
                ViewData["unitOfMeasure"] = unitOfMeasure;

                return View("Create");
            }
        }

        public ActionResult Save(int? itemCatalogueId, int? quantity, bool? isUpdate, int? requestId)
        {
            if (IsValid(itemCatalogueId, quantity) == false)
                return Redirect(Request.UrlReferrer.ToString());

            using (var db = new ADProjectDb())
            {   
                requestService.SaveRequest(db, (int)itemCatalogueId, (int)quantity, isUpdate, requestId);
            }                

            return RedirectToAction("Index", "Request");
        }

        public ActionResult Delete(int requestId)
        {
            using (var db = new ADProjectDb())
            {
                requestService.DeleteRequest(db, requestId);
                return RedirectToAction("Index", "Request");
            }
                
        }
        
        //Helper methods...

        public void SelectListItem_ItemCatalogue_CollectionPoint_Categories(ADProjectDb db, List<Container> containers, int? categoryId = null, int? itemCatalogueId = null, int? collectionPointId = null)
        {
            List<SelectListItem> selectListCategories = db.Categories.Select(c => new SelectListItem
            {
                Text = c.CategoryDescription,
                Value = c.CategoryId.ToString(),
                Selected = (c.CategoryId == categoryId ? true : false)
            }).ToList();

            List<SelectListItem> selectListItemCatalogues = null;
            if (containers != null)
            {
                selectListItemCatalogues = containers
                .Select(ce => ce.ItemCatalogue)
                .Select(item => new SelectListItem
                {
                    Text = item.ItemDes,
                    Value = item.ItemCatalogueId.ToString(),
                    Selected = (item.ItemCatalogueId == itemCatalogueId ? true : false)
                }).ToList();
            }
            

            List<SelectListItem> selectListCollectionPoints = db.CollectionPoint.Select(cp =>
            new SelectListItem
            {
                Text = cp.Location,
                Value = cp.CollectionPointId.ToString(),
                Selected = (cp.CollectionPointId == collectionPointId ? true : false)
            }).ToList();

            ViewData["selectListCategories"] = selectListCategories;
            ViewData["selectListItemCatalogues"] = selectListItemCatalogues;
            ViewData["selectListCollectionPoints"] = selectListCollectionPoints;
        }

        public bool IsValid(int? itemCatalogueId, int? quantity)
        {
            bool isValid = true;
            if (itemCatalogueId == null)
            {
                isValid = false;
            }
            if (quantity == null || quantity <= 0)
            {
                isValid = false;
            }
            return isValid;
        }

    }

    
 }


        