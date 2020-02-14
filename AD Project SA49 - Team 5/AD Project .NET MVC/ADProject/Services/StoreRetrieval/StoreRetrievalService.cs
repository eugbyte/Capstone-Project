using ADProject.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using static ADProject.Controllers.StoreRetrievalController;
using static ADProject.StatusEnums;

namespace ADProject.Services.StoreRetrieval
{
    public class StoreRetrievalService : IStoreRetrieval
    {
        public List<Container> GetContainers(ADProjectDb db)
        {
            List<Container> containers = (from dd in db.DisbursementDetail
                                          join item in db.ItemCatalogue
                                          on dd.ItemCatalogueId equals item.ItemCatalogueId
                                          join rd in db.RequestDetail
                                          on dd.Disbursement.RequestId equals rd.RequestId
                                          join stock in db.StockInfo
                                          on item.ItemCatalogueId equals stock.ItemCatalogueId
                                          where dd.DisbursementStatus.Description == DisbursementStatusEnum.PENDING.ToString()
                                          select new Container
                                          {
                                              ItemCatalogue = item,
                                              DisbursementDetail = dd,
                                              RequestDetail = rd,
                                              Request = rd.Request,
                                              StockInfo = stock
                                          }).ToList();
            return containers;
        }

        public List<GroupedContainer> GetGroupedContainers(List<Container> containers)
        {
            List<GroupedContainer> groupedContainers = (from container in containers
                                                        group container by container.ItemCatalogue.ItemCatalogueId into grp
                                                        select new GroupedContainer
                                                        {
                                                            Quantity = grp.Sum(g => g.RequestDetail.Quantity),
                                                            ItemDes = grp.First().ItemCatalogue.ItemDes,
                                                            ItemLocation = grp.First().StockInfo.ItemLocation
                                                        }).ToList();
            return groupedContainers;
        }

    }
}