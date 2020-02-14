using ADProject.Data;
using ADProject.ViewModels;
using ADProject.Services.DataAnalytics;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace ADProject.Controllers
{
    public class DataAnalyticsController : Controller
    {
        private IDataAnalytics dataAnalyticService;

        public DataAnalyticsController()
        {
            dataAnalyticService = new DataAnalyticService();
        }

        public class Container
        {
            public DateTime? RequestDate { get; set; }
            public int Quantity { get; set; }
            public string CategoryDescription { get; set; }
            public int CategoryId { get; set; }
        }

        public ActionResult Index()
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = dataAnalyticService.GetContainers(db);
                ViewData["containers"] = containers;
                CreateSelectListItem_Category(containers);

            }
            return View();
        }

        public class JsonContainer
        {
            public DateTime DateToPredict { get; set; }
            public List<Container> DepartmentRequests { get; set; }
        }
        [HttpPost]
        public async Task<ActionResult> PostToFlask(DateTime? startDate, int categoryId)
        {
            List<Container> containers = null;
            DateTime dateToPredict = startDate.GetValueOrDefault();

            using (var db = new ADProjectDb())
            {
                containers = dataAnalyticService.GetContainers(db);
                containers = containers.Where(ce => ce.CategoryId == categoryId).ToList();        
            }
            using (var client = new HttpClient())
            {
                string jsonContent = await dataAnalyticService.GetJsonStringContentFromResponse(client, containers, dateToPredict);

                if (jsonContent != null)
                {
                    //Logic to convert the json bytes into an image and save to Content/Images
                    JObject json = JObject.Parse(jsonContent);
                    string image = (string)json.GetValue("img");
                    double predictedQty = (double)json.GetValue("requested_pred_quantity");
                    double rsquare = (double)json.GetValue("rsquare");

                    string fileName = "graph.png";
                    SaveImageToFile(image, fileName);


                    //Display the results to the razor page
                    ViewData["predictedQty"] = predictedQty;
                    ViewData["rsquare"] = rsquare;
                    ViewData["image"] = fileName;
                    
                }
            }
            return View();
        }

        public void SaveImageToFile(string image, string fileName)
        {
            byte[] bytes = Convert.FromBase64String(image);

            Image graph;
            using (MemoryStream ms = new MemoryStream(bytes))
            {
                graph = Image.FromStream(ms);
                string folderPath = Server.MapPath("~/Content/Images/");
                string imagePath = folderPath + fileName;
                graph.Save(imagePath, System.Drawing.Imaging.ImageFormat.Png);
            }
        }

        public void CreateSelectListItem_Category(List<Container> jsonContainers)
        {
            List<Container> groupedJsonContainers = jsonContainers
                .GroupBy(ce => ce.CategoryId)
                .Select(grp => grp.First()).ToList();

            List<SelectListItem> selectListCategory = jsonContainers
                .GroupBy(ce => ce.CategoryId)
                .Select(grp => grp.First())
                .Select(ce => new SelectListItem
                {
                    Value = ce.CategoryId.ToString(),
                    Text = ce.CategoryDescription
                }).ToList();
            ViewData["selectListCategory"] = selectListCategory;
        }

        public class ReqContainer
        {
            public DateTime? ApprovedDate { get; set; }
            public int Quantity { get; set; }
            public string ItemDescription { get; set; }
            public int ItemId { get; set; }
            public int StockLevel { get; set; }
            public int CategoryId { get; set; }
        }

        public class ReqJsonContainer
        {
            public DateTime DateToPredict { get; set; }
            public List<ReqContainer> DepartmentRequests { get; set; }
        }

        public ActionResult AnalyticPage()
        {
            using (var db = new ADProjectDb())
            {
                List<Container> containers = dataAnalyticService.GetContainers(db);
                ViewData["containers"] = containers;
                CreateSelectListItem_Category(containers);

            }
            return View();
        }

        [HttpPost]
        public async Task<ActionResult> DemandAnalysis(DateTime? StartDate, int categoryId)
        {
            // Use current date to query the demand for same 4 weeks period last year
            List<ReqContainer> containers = null;
            DateTime dateToPredict = StartDate.GetValueOrDefault();
            DateTime dateLastYear = dateToPredict.AddYears(-1);
            DateTime dateLastYearPlus1Mth = dateLastYear.AddMonths(1);
            string Category;
            using (var db = new ADProjectDb())
            {
                Category = db.Categories.Where(x => x.CategoryId == categoryId).FirstOrDefault().CategoryDescription;
                containers = dataAnalyticService.GetAllContainers(db);
                containers = containers.Where(ce => ce.CategoryId == categoryId)
                                       .Where(ce => ce.ApprovedDate >= dateLastYear && ce.ApprovedDate <= dateLastYearPlus1Mth)
                                       .ToList();
            }
            using (var client = new HttpClient())
            {
                string jsonContent = await dataAnalyticService.GetJsonContentFromResponse(client, containers, dateToPredict);

                if (jsonContent != null)
                {
                    //Logic to convert the json bytes into an image and save to Content/Images
                    JObject json = JObject.Parse(jsonContent);
                    JArray analyticsResult = (JArray)json.SelectToken("AnalyticsResult");
                  //  JArray analyticsResult = JArray.Parse((string)json.GetValue("AnalyticsResult"));
                    string image = (string)json.GetValue("img");
                    List < ViewAnalyticsResult > viewAnalyticsResults= new List<ViewAnalyticsResult>();
                    foreach (JObject item in analyticsResult)
                    {
                        ViewAnalyticsResult newEntry = new ViewAnalyticsResult()
                        {
                            itemId = (int)item.GetValue("ItemId"),
                            itemDescription = (string)item.GetValue("ItemDescription"),
                            predictedDemand = (int)item.GetValue("PredictedDemand"),
                            stockLevel = (int)item.GetValue("Stock Level")
                        };
                        viewAnalyticsResults.Add(newEntry);
                    }

                    string fileName = "graph.png";
                    SaveImageToFile(image, fileName);
                    //Display the results to the razor page
                    ViewData["viewAnalyticsResults"] = viewAnalyticsResults;
                    ViewData["image"] = fileName;
                    ViewData["Date"] = dateToPredict.ToShortDateString();
                    ViewData["Category"] = Category;

                }
            }
            return View();
        }
    }
}