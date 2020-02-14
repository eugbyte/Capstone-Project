using ADProject.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using static ADProject.Controllers.DataAnalyticsController;


namespace ADProject.Services.DataAnalytics
{
    interface IDataAnalytics
    {
        List<Container> GetContainers(ADProjectDb db);
        Task<string> GetJsonStringContentFromResponse(HttpClient client, List<Container> containers, DateTime dateToPredict);
        List<ReqContainer> GetAllContainers(ADProjectDb db);
        Task<string> GetJsonContentFromResponse(HttpClient client, List<ReqContainer> containers, DateTime dateToPredict);
    }
}
