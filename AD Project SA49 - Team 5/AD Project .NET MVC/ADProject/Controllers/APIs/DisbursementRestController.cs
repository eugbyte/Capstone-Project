using ADProject.Data;
using ADProject.Models;
using ADProject.Services.Disbursements;
using ADProject.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;
using ADProject.Controllers;
using Newtonsoft.Json;

namespace ADProject.Controllers.APIs
{
    [System.Web.Http.Route("api/disbursement")]
    public class DisbursementRESTController : ApiController
    {
        //Dependency injection
        private IDisbursement disbursementService;

        public DisbursementRESTController()
        {
            disbursementService = new DisbursementService();
        }

        public IHttpActionResult GetDisbursementInfo(int collectionPointId, int departmentId, int disbursementStatusId)
        {
            using (var db = new ADProjectDb())
            {
                List<DisbursementController.Container> containers = disbursementService.GetContainers(db) ?? new List<DisbursementController.Container>();

                List<DisbursementController.Container> selectListContainers = containers.ConvertAll(ce => ce).ToList();   //deep copy
                Dictionary<int, string> collectionPoint = containers.Select(x=>x.CollectionPoint)
                                                                    .Distinct()
                                                                    .Select(x=> new KeyValuePair<int,string>(x.CollectionPointId,x.Location))
                                                                    .ToDictionary(x=>x.Key,x=>x.Value);
                Dictionary<int, string> department = containers.Select(x => x.Department)
                                                               .Distinct()
                                                               .Select(x => new KeyValuePair<int, string>(x.DepartmentId, x.DepName))
                                                               .ToDictionary(x => x.Key, x => x.Value); 
                Dictionary<int, string> disbursementStatus = containers.Select(x=>x.DisbursementStatus)
                                                                       .Distinct()
                                                                       .Select(x => new KeyValuePair<int, string>(x.DisbursementStatusId, x.Description))
                                                                       .ToDictionary(x => x.Key, x => x.Value);
                if (collectionPointId != 0)
                {
                    containers = containers.Where(ce => ce.CollectionPoint.CollectionPointId == collectionPointId)
                        .ToList();
                }

                if (departmentId != 0)
                {
                    containers = containers.Where(ce => ce.Department.DepartmentId == departmentId)
                        .ToList();
                }

                if (disbursementStatusId != 0)
                {
                    containers = containers.Where(ce => ce.DisbursementStatus.DisbursementStatusId == disbursementStatusId).ToList();
                }

                List<DisbursementInfo> listDI = containers
                                                .Select(x => new DisbursementInfo {
                                                    requestId = x.RequestDetail.RequestId,
                                                    disbursementdetailId = x.DisbursementDetail.DisbursementDetailId,
                                                    itemDesc = x.ItemCatalogue.ItemDes,
                                                    departmentName = x.Department.DepName,
                                                    unitOfMeasurement = x.ItemCatalogue.UnitOfMeasure,
                                                    requestQty = x.RequestDetail.Quantity,
                                                    disbursementQty = x.DisbursementDetail.DisburseQuantity,
                                                    collectionPoint = x.CollectionPoint.Location,
                                                    disbursementStatus = x.DisbursementStatus.Description
                                                }).ToList();


                // Put all into a container
                DisbursementPgContainer data = new DisbursementPgContainer() {collectionPtsSelectList = collectionPoint, DepartmentSelectList = department,DisbursementStatusSelectList = disbursementStatus,disbursementInfos = listDI };
            //    string Jsonresult = JsonConvert.SerializeObject(data);
                return Ok(data);
            }

        }

        public IHttpActionResult PutDisbursementStatus(int disbursementStatusId, int disbursementDetailId)
        {
            using (var db = new ADProjectDb())
            {
                disbursementService.SaveStatus(db, disbursementStatusId, disbursementDetailId);
                ReduceQuantity(db, disbursementDetailId, disbursementStatusId);
            }
            return Ok();
        }

        protected void ReduceQuantity(ADProjectDb db, int disbursementDetailId, int disbursementStatusId)
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


    }
    public class DisbursementInfo
    {
        public int requestId { get; set; }
        public int disbursementdetailId { get; set; }
        public string itemDesc { get; set; }
        public string departmentName { get; set; }
        public string unitOfMeasurement{ get; set; }
        public int requestQty { get; set; }
        public int disbursementQty { get; set; }
        public string collectionPoint { get; set; }
        public string disbursementStatus { get; set; }
    }

    public class DisbursementPgContainer
    {
        public Dictionary<int, string> collectionPtsSelectList { get; set; }
        public Dictionary<int, string> DepartmentSelectList { get; set; }
        public Dictionary<int, string> DisbursementStatusSelectList { get; set; }
        public List<DisbursementInfo> disbursementInfos { get; set; }

    }

}
