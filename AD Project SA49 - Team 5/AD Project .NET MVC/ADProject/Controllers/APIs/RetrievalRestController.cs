using ADProject.Data;
using ADProject.Services.Disbursements;
using ADProject.Services.StoreRetrieval;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using static ADProject.StatusEnums;

namespace ADProject.Controllers.APIs
{
    [System.Web.Http.Route("api/retrieval")]
    public class RetrievalRestController : ApiController
    {
        private IDisbursement disbursementService;
        private IStoreRetrieval storeRetrievalService;

        public RetrievalRestController()
        {
            disbursementService = new DisbursementService();
            storeRetrievalService = new StoreRetrievalService();
        }

        public IHttpActionResult GetRetrievalDetail()
        {
            using (var db = new ADProjectDb())
            {
                List<ADProject.Controllers.StoreRetrievalController.Container> containers = storeRetrievalService.GetContainers(db);

                List<ADProject.Controllers.StoreRetrievalController.GroupedContainer> groupedContainers = storeRetrievalService.GetGroupedContainers(containers);

                List<Groupinfo> groupInfoList = groupedContainers
                                             .Select(x => new Groupinfo()
                                             {itemdes = x.ItemDes,
                                              totalReqQty = x.Quantity,
                                              itemlocation = x.ItemLocation
                                             }).ToList();
                List<Disinfo> disbursementInfoList = containers
                                                           .Select(x => new Disinfo()
                                                           {               
                                                               disbursementId = x.DisbursementDetail.DisbursementId,
                                                               itemdes = x.ItemCatalogue.ItemDes,
                                                               ReqQty = x.RequestDetail.Quantity,
                                                           }).ToList();


                Dictionary<int, string> disbursementStatus = db.DisbursementStatus
                                                            .Where(ds => ds.Description != DisbursementStatusEnum.COLLECTED.ToString()).ToList()
                                                            .Select(x => new KeyValuePair<int, string>
                                                            ( x.DisbursementStatusId, x.Description )).ToDictionary(x => x.Key, x => x.Value);

                RetrievalPgContainer retrievalPgContainer = new RetrievalPgContainer() {disbursementStatusSelectList = disbursementStatus,groupInfos = groupInfoList,disbursementInfos = disbursementInfoList };
                return Ok(retrievalPgContainer);
            }
        }
    }

    public class Groupinfo
    {
        public string itemdes{ get; set; }
        public int totalReqQty { get; set; }
        public string itemlocation { get; set; }
    }

    public class Disinfo
    {
        public string itemdes { get; set; }
        public int ReqQty { get; set; }
        public int disbursementId { get; set; }
    }

    public class RetrievalPgContainer
    {
        public Dictionary<int, string> disbursementStatusSelectList { get; set; }
        public List<Disinfo> disbursementInfos { get; set; }

        public List<Groupinfo> groupInfos { get; set; }

    }

}
