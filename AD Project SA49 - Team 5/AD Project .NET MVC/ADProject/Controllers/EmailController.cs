using ADProject.Data;
using ADProject.Models;
using ADProject.Services.Order;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace ADProject.Controllers
{
    public class EmailController : Controller
    {
        //Dependency injection
        private IOrder orderService;

        public EmailController()
        {
            orderService = new OrderService();
        }
        // GET: Email
        public ActionResult Index()
        {
            return View();
        }

        // send email to supplier regarding order
        public ActionResult EmailSupplier(int supplierId, int orderId, string intention)
        {
            Employee employee = Session["employee"] as Employee;
            //string for Email
            string opening = "";
            string subject = "";
            if (intention == "Enquire")
            {
                opening = "<p>Please check for me whether {0} is able " +
                     "to supply the following items to us.</p>";
                subject = "Enquiry about Stock";
            }
            else if (intention == "Purchase")
            {
                opening = "<p>On behalf on Logic University, I am ordering from {0} the " +
                          "following items. Please also " +
                      "indicate the expected delivery date for them.</p>";
                subject = "Purchase Order";
            }



            //  Create Supplier variable
            Supplier supplierToEmail;

            // Information to retrieve
            string supplierEmail;
            string supplierName;
            string supplierContact;
            List<string> Description = new List<string>();
            List<int> Quantity = new List<int>();
            List<string> Unit = new List<string>();
            List<double> Price = new List<double>();

            using (var db = new ADProjectDb())
            {
                if (intention == "Enquire")
                {
                    orderService.ChangeOrderStatus(db,orderId,2);
                }
                else if (intention == "Purchase")
                {
                    orderService.ChangeOrderStatus(db, orderId, 3);
                }

                //Get Supplier from database
                supplierToEmail = db.Supplier.Where(x => x.SupplierId == supplierId).FirstOrDefault();
                supplierName = supplierToEmail.SupplierName;
                supplierContact = supplierToEmail.SupplierContact;
                supplierEmail = supplierToEmail.SupplierEmail;

                //Get list of information for the email query
                var orderDetailList = from IC in db.ItemCatalogue
                                      join OD in db.OrderDetail
                                      on IC.ItemCatalogueId equals OD.ItemId
                                      join SC in db.SupplierCatalogue
                                      on IC.ItemCatalogueId equals SC.ItemId
                                      where (OD.OrderId == orderId) && (SC.SupplierId == supplierId)
                                      orderby OD.ItemId
                                      select new
                                      {
                                          description = IC.ItemDes,
                                          quantity = OD.OrderQuantity,
                                          unit = IC.UnitOfMeasure,
                                          price = SC.ItemPrice
                                      };

                foreach (var row in orderDetailList)
                {
                    Description.Add(row.description);
                    Quantity.Add(row.quantity);
                    Unit.Add(row.unit);
                    Price.Add(row.price);
                }

            }

            // Use Smtp to send email via gmail server

            SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
            client.Credentials = new System.Net.NetworkCredential
            ("issad1234c@gmail.com", "letmepass1");
            client.EnableSsl = true;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            MailMessage mm = new MailMessage("issad1234c@gmail.com", "chengxiangliou@gmail.com");

            // Build up email message
            mm.Subject = subject;
            StringBuilder mailBody = new StringBuilder();
            mailBody.AppendFormat("Dear {0},", supplierContact);
            mailBody.AppendFormat("<br />");
            mailBody.AppendFormat(opening, supplierName);
            mailBody.AppendFormat("<br />");
            mailBody.AppendFormat("<table cellpadding='10'><tr> <th>No</th> <th>Description</th> <th>Quantity</th> <th>Unit</th> <th>Price</th> <th>Amount</th> </tr>");

            for (int counter = 0; counter < Description.Count; counter++)
            {
                double amount = (double)Quantity[counter] * Price[counter];
                mailBody.AppendFormat("<tr> <td>{0}</td> <td>{1}</td> <td>{2}</td> <td>{3}</td> <td>${4}</td> <td>${5}</td> </tr>", counter + 1, Description[counter], Quantity[counter], Unit[counter], Price[counter], amount);

            }
            mailBody.AppendFormat("<br />");
            mailBody.AppendFormat("</table>");
            mailBody.AppendFormat("<br />");
            mailBody.AppendFormat("Warmest Regards<br/>");
            mailBody.AppendFormat(employee.FirstName + " " +employee.LastName);


            mm.Body = mailBody.ToString();
            mm.IsBodyHtml = true;
            client.Send(mm);

            return RedirectToAction("ViewPO", "Order", new { orderId = orderId });
        }
    }
}