using ADProject.Data;
using ADProject.Filters;
using ADProject.Models;
using ADProject.Services.AdjustmentVouchers;
using ADProject.ViewModels;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ADProject.Controllers
{
    [AuthenticationFilter]
    [StoreClerkFilter]
    public class AdjustmentVoucherController : Controller
    {
        private IAdjustmentVoucher adjustmentVoucherServices;

        public AdjustmentVoucherController()
        {
            adjustmentVoucherServices = new AdjustmentVoucherServices();
        }

        // GET: AdjustmentVoucher
        public ActionResult Index()
        {
            return View();
        }

        public class RequisitionInfo
        {
            public int RequisitionNo { get; set; }
            public int ItemId { get; set; }
            public string Description { get; set; }
            public int Quantity { get; set; }
            public string Unit { get; set; }
            public string DepartmentName { get; set; }
            public int DepartmentId { get; set; }
            public string RaisedBy { get; set; }
            public string Status { get; set; }
            public DateTime? RequestDate { get; set; }

        }
        public ActionResult ViewPastRecord(int? page, string searchstring, string status)
        {
            ViewData["searchstring"] = searchstring;
            ViewData["status"] = status;
            int pageSize = 3;
            int pageNumber = (page ?? 1);
            string type = "";
            var db = new ADProjectDb();
            List<RequisitionInfo> requisitionInfos = adjustmentVoucherServices.GetRequisitionInfos(db);

            if (searchstring != null)
            {
                if (searchstring != "")
                {
                    requisitionInfos = requisitionInfos.Where(re => re.DepartmentName.ToLower().Contains(searchstring.ToLower())).ToList();
                }
            }
            if (status != null)
            {
                requisitionInfos = requisitionInfos.Where(re => re.Status == status).ToList();
            }
            if (requisitionInfos.Count() == 0)
            {
                type = "zero";
            }
            ViewData["type"] = type;
            return View(requisitionInfos.ToPagedList(pageNumber, pageSize));

        }

        public ActionResult CreateVoucher(string itemdes, string quantity, string reason, string cost, int? categoryId, bool? isSubmit)
        {
            var db = new ADProjectDb();
            //-------Eugene's change
            List<SelectListItem> selectListCategory = db.Categories
                .Select(c => new SelectListItem
                {
                    Text = c.CategoryDescription,
                    Value = c.CategoryId.ToString()
                }).ToList();
            ViewData["selectListCategory"] = selectListCategory;
            //------------

            List <ItemCatalogue> items = (from Item in db.ItemCatalogue
                                         select Item).ToList();

            //---Eugene's change
            if (categoryId != null)
            {
                items = items.Where(item => item.CategoryId == categoryId).ToList();
            }
            ViewData["itemdes"] = itemdes;

            if (itemdes != null)
            {
                double unitPrice = adjustmentVoucherServices.getUnitPrice(db, itemdes);
                ViewData["unitPrice"] = unitPrice;
            }
            //----------

            ViewData["items"] = items;

            List<AdjustmentDetail> details = new List<AdjustmentDetail>();
            List<string> des = new List<string>();

            Employee currentUser = Session["employee"] as Employee;
            int employeeId = currentUser.EmployeeId;

            AdjustmentVoucher NewVoucher = adjustmentVoucherServices.CreateAdjustmentVoucher(db, employeeId);
            ViewData["newvoucher"] = NewVoucher;          
            
            if (Session["detail"] == null)
            {
                Session["detail"] = details;
                Session["des"] = des;
            }

            if (Session["detail"] != null && isSubmit == true)
            {
                if (itemdes != null && quantity != null && reason != null && cost != null)
                {
                    ItemCatalogue item = db.ItemCatalogue.Where(ite => ite.ItemDes == itemdes).SingleOrDefault();

                    AdjustmentDetail detail = new AdjustmentDetail()
                    {

                        ItemCatalogueId = item.ItemCatalogueId,
                        Quantity = Convert.ToInt32(quantity),
                        AdjustmentVoucherId = NewVoucher.AdjustmentVoucherId,
                        Reason = reason,
                        Cost = Convert.ToDouble(cost)
                    };

                    ((List<AdjustmentDetail>)Session["detail"]).Add(detail);
                    ((List<string>)Session["des"]).Add(itemdes);
                    Session["details"] = Session["detail"];
                    NewVoucher.AdjustmentDetail = (List<AdjustmentDetail>)Session["detail"];
                    Session["newvoucher"] = NewVoucher;
                    return RedirectToAction("ViewVoucherDetail", "AdjustmentVoucher");

                }
                return View();
            }
            return View();
        }
        public ActionResult ViewVoucherDetail(string deleteid, string issubmit)
        {
            var db = new ADProjectDb();
            AdjustmentVoucher adjustment = (AdjustmentVoucher)Session["newvoucher"];
            List<AdjustmentDetail> details = (List<AdjustmentDetail>)Session["details"];
            List<string> items = (List<string>)Session["des"];

            if (deleteid != null)
            {
                for (int i = 0; i < details.Count; i++)
                {
                    if (details[i].ItemCatalogueId.ToString() == deleteid)
                    {
                        details.Remove(details[i]);
                        items.Remove(items[i]);
                    }
                }
            }

            if (issubmit == "yes")
            {
                db.AdjustmentVoucher.Add(adjustment);
                for (int i = 0; i < details.Count(); i++) { db.AdjustmentDetail.Add(details[i]); }
                db.SaveChanges();
                Session["detail"] = null;
                Session["newvoucher"] = null;
                return RedirectToAction("ViewAllVouchers", "AdjustmentVoucher");
            }
            ViewData["details"] = details;
            ViewData["itemdes"] = items;
            return View();
        }

        public class VoucherInfo
        {
            public int VoucherNo { get; set; }
            public string ApprovedBy { get; set; }
            public DateTime? RequestDate { get; set; }
            public double TotalCost { get; set; }
            public string Status { get; set; }
        }
        public ActionResult ViewAllVouchers(int? page, string status)
        {
            var db = new ADProjectDb();
            List<SelectListItem> selectListAdjustmentStatus = db.AdjustmentStatus.Select(s => new SelectListItem
            {
                Text = s.Description,
                Value = s.Description
            }).ToList();
            ViewData["selectListAdjustmentStatus"] = selectListAdjustmentStatus;
            
            ViewData["status"] = status;
            List<VoucherInfo> adjustments = adjustmentVoucherServices.GetAllVoucherInfo(db);

            if (string.IsNullOrEmpty(status) == false)
            {
                adjustments = adjustments.Where(x => x.Status == status).ToList();
            }
            if (adjustments.Count == 0)
            {
                string type = "zero";
                ViewData["type"] = type;
            }
            int pageSize = 3;
            int pageNumber = (page ?? 1);
            return View(adjustments.ToPagedList(pageNumber, pageSize));
        }

        public ActionResult ViewVoucher(int VoucherId, string returnController = "AdjustmentVoucher", string returnMethod = "ViewAllVouchers")
        {
            ViewBag.returnController = returnController;
            ViewBag.returnMethod = returnMethod;
            using (var db = new ADProjectDb())
            {

                List<ViewAdjustmentDetail> viewAdjustmentDetails = adjustmentVoucherServices.GetViewAdjustmentDetailList(db, VoucherId);
                ViewBag.viewAdjustmentDetails = viewAdjustmentDetails;
                AdjustmentVoucher Voucher = adjustmentVoucherServices.GetOrder(db, VoucherId);
                //Send Order object to the view
                return View(Voucher);
            }

        }

        public ActionResult submitVoucher(int VoucherId)
        {
            using (var db = new ADProjectDb())
            {
                // Get adjustment voucher
                AdjustmentVoucher Voucher = adjustmentVoucherServices.GetOrder(db, VoucherId);
                Voucher.AdjustmentStatus = db.AdjustmentStatus.Where(x => x.AdjustmentStatusId == 4).FirstOrDefault();
                Voucher.RaiseDate = DateTime.Today;
                db.SaveChanges();
                return Redirect("ViewAllVouchers");
            }

        }
    }
}