using ADProject.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using static ADProject.Controllers.DataAnalyticsController;

namespace ADProject.Services.DataAnalytics
{
    public class DataAnalyticService : IDataAnalytics
    {
        public List<Container> GetContainers(ADProjectDb db)
        {
            List<Container> containers = (from rd in db.RequestDetail
                                                  group rd by new { rd.ItemCatalogue.CategoryId, rd.Request.RequestDate }
                                                  into grp
                                                  select new Container
                                                  {
                                                      RequestDate = grp.Key.RequestDate,
                                                      Quantity = grp.Sum(rd => rd.Quantity),
                                                      CategoryDescription = grp.FirstOrDefault().ItemCatalogue.Category.CategoryDescription,
                                                      CategoryId = grp.Key.CategoryId
                                                  }).ToList();
            return containers;
        }

        public async Task<string> GetJsonStringContentFromResponse(HttpClient client, List<Container> containers,  DateTime dateToPredict)
        {
            string jsonContent = null;

            JsonContainer jsonContainer = new JsonContainer();
            jsonContainer.DateToPredict = dateToPredict;
            jsonContainer.DepartmentRequests = containers;
            client.BaseAddress = new Uri("http://127.0.0.1:5000");

            //HTTP POST
            //The base address is http://127.0.0.1:5000, so now need need to append /request to it
            var postTask = await client.PostAsJsonAsync("request", jsonContainer);

            //Logic to receive the results
            if (postTask.IsSuccessStatusCode)
            {
                //Logic to convert the json bytes into an image and save to Content/Images
                jsonContent = await postTask.Content.ReadAsStringAsync();
            }
            return jsonContent;
            
        }

        public List<ReqContainer> GetAllContainers(ADProjectDb db)
        {
            List<ReqContainer> containers = (from rd in db.RequestDetail
                                             join SI in db.StockInfo
                                             on rd.ItemCatalogueId equals SI.ItemCatalogueId
                                             select new ReqContainer()
                                             {
                                               ApprovedDate = rd.Request.ApprByDate,
                                               Quantity = rd.Quantity,
                                               ItemDescription = rd.ItemCatalogue.ItemDes,
                                               ItemId = rd.ItemCatalogueId,
                                               CategoryId =rd.ItemCatalogue.CategoryId,
                                               StockLevel = SI.StockQuantity
                                             }).ToList();
            return containers;
        }

        public async Task<string> GetJsonContentFromResponse(HttpClient client, List<ReqContainer> containers, DateTime dateToPredict)
        {
            string jsonContent = null;

            ReqJsonContainer jsonContainer = new ReqJsonContainer();
            jsonContainer.DateToPredict = dateToPredict;
            jsonContainer.DepartmentRequests = containers;
            client.BaseAddress = new Uri("http://127.0.0.1:5000");

            //HTTP POST
            //The base address is http://127.0.0.1:5000, so now need need to append /request to it
            var postTask = await client.PostAsJsonAsync("demandAnalysis", jsonContainer);

            //Logic to receive the results
            if (postTask.IsSuccessStatusCode)
            {
                //Logic to convert the json bytes into an image and save to Content/Images
                jsonContent = await postTask.Content.ReadAsStringAsync();
            }
            return jsonContent;

        }
    }
}