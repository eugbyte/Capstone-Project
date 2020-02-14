using ADProject.Data;
using ADProject.Models;
using ADProject.Services.Representative;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using static ADProject.Controllers.RequestController;
using static ADProject.StatusEnums;

//Eugene
namespace ADProject.Services.Requests
{
    public class RequestService : IRequest
    {
        
        

        public List<Container> GetContainersForIndex(ADProjectDb db, int? employeeId = null)
        {
            using (db) {
                Employee employee = null;

                if (employeeId == null)
                    employee = GetEmployee(db);
                else
                {
                    employee = db.Employee.Where(emp => emp.EmployeeId == employeeId).SingleOrDefault();
                }

                List<Container> containers = (from rd in db.RequestDetail
                                              join item in db.ItemCatalogue
                                              on rd.ItemCatalogue.ItemCatalogueId equals item.ItemCatalogueId
                                              where rd.Request.Department.DepartmentId == employee.DepartmentId
                                              where rd.Request.RequestStatus.RequestStatusDescription != RequestStatusEnum.DELIVERED.ToString()
                                              select new Container
                                              {
                                                  RequestDetail = rd,
                                                  Request = rd.Request,
                                                  RequestStatus = rd.Request.RequestStatus,
                                                  ItemCatalogue = item,
                                                  Category = item.Category,
                                                  CollectionPoint = rd.Request.CollectionPoint
                                              }).ToList();
                return containers;
            }
            
        }

        public string GetUnitOfMeasure(ADProjectDb db, int? itemCatalogueId)
        {
            string unitOfMeasure = db.ItemCatalogue
                .Where(ic => ic.ItemCatalogueId == itemCatalogueId)
                .Select(ic => ic.UnitOfMeasure)
                .SingleOrDefault();
            return unitOfMeasure;
        }

        public List<Container> GetAndFilterContainersForCreateOrUpdate(ADProjectDb db, int? categoryId)
        {
            List<Container> containers = (from item in db.ItemCatalogue
                                          select new Container()
                                          {
                                              ItemCatalogue = item,
                                              Category = item.Category
                                          }).ToList();
            if (categoryId != null)
            {
                containers = containers.Where(ce => ce.Category.CategoryId == categoryId).ToList();
            }
            return containers;
        }

        public void SaveRequest(ADProjectDb db, int itemCatalogueId, int quantity, bool? isUpdate, int? requestId)
        {
            using (db)
            {
                Employee employee = GetEmployee(db);

                RequestStatus requestStatus = db.RequestStatus.Where(rs => rs.RequestStatusDescription == StatusEnums.RequestStatusEnum.PENDING.ToString()).SingleOrDefault();
                ItemCatalogue itemCatalogue = db.ItemCatalogue.Where(ic => ic.ItemCatalogueId == itemCatalogueId).SingleOrDefault();

                Request request = new Request();
                RequestDetail requestDetail = new RequestDetail();

                //if update instead of create...
                isUpdate = (isUpdate == null ? false : isUpdate);
                if ((bool)isUpdate)
                {
                    request = db.Request.Where(r => r.RequestId == requestId).SingleOrDefault();
                    requestDetail = db.RequestDetail.Where(rd => rd.Request.RequestId == requestId).SingleOrDefault();
                }

                
                request.Department = employee.Department;
                request.RaisedByEmployee = employee;
                request.RequestDate = DateTime.Today;
                request.RequestStatus = requestStatus;

                RepresentativeService representativeService = new RepresentativeService();
                CollectionPoint collectionPoint = representativeService.GetLatestCollectionPoint(db);
                request.CollectionPoint = collectionPoint;

                requestDetail.ItemCatalogue = itemCatalogue;
                requestDetail.Quantity = quantity;

                requestDetail.Request = request;

                if (isUpdate == false)
                {
                    db.Request.Add(request);
                    db.RequestDetail.Add(requestDetail);
                }

                db.SaveChanges();

                Request lastestAddedRequest = db.Request.OrderByDescending(r => r.RequestId).FirstOrDefault();
            }
            
        }

        public Employee GetEmployee(ADProjectDb db)
        {
            try
            {
                Employee sessionEmployee = HttpContext.Current.Session["employee"] as Employee;
                int employeeId = sessionEmployee.EmployeeId;
                //Employee from Session is from different context, so need to get a new one
                Employee employee = db.Employee.Where(emp => emp.EmployeeId == employeeId).SingleOrDefault();
                Department department = db.Employee.Where(emp => emp.DepartmentId == employee.DepartmentId)
                    .Select(emp => emp.Department).FirstOrDefault();

                employee.Department = department;
                return employee;
            } catch (Exception e)
            {
                //For testing purposes
                Debug.WriteLine(e);
                return db.Employee.Where(emp => emp.Username == "employee").FirstOrDefault();
            }
            
        }

        public void DeleteRequest(ADProjectDb db, int requestId)
        {
            Request request = db.Request
                .Where(r => r.RequestId == requestId)
                .SingleOrDefault();
            db.Request.Remove(request);
            db.SaveChanges();
        }


        
    }
}