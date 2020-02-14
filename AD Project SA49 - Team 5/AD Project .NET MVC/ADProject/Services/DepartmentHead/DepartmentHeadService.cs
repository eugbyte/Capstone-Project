using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using static ADProject.Controllers.DepartmentHeadController;
using System.Web.SessionState;
using static ADProject.StatusEnums;

//Eugene
namespace ADProject.Services.DepartmentHead
{
    public class DepartmentHeadService : IDepartmentHead
    {
        public List<Container> GetAllContainers(ADProjectDb db)
        {
            Employee employee = GetEmployee(db);

            List<Container> containers = (from rd in db.RequestDetail
                                          join item in db.ItemCatalogue
                                          on rd.ItemCatalogue.ItemCatalogueId equals item.ItemCatalogueId
                                          where rd.Request.Department.DepartmentId == employee.DepartmentId
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

        public List<Container> GetPendingRequestContainers(ADProjectDb db)
        {
            List<Container> containers = GetAllContainers(db);
            containers = containers
                .Where(ce => ce.RequestStatus.RequestStatusDescription == RequestStatusEnum.PENDING.ToString())
                .ToList();
            return containers;
        }

        public List<Container> GetNonPendingRequestContainers(ADProjectDb db)
        {
            List<Container> containers = GetAllContainers(db);
            containers = containers
                .Where(ce => ce.RequestStatus.RequestStatusDescription != RequestStatusEnum.PENDING.ToString())
                .ToList();
            return containers;
        }

        public void CreateDisbursementForApprovedRequest(ADProjectDb db, int requestId, int? collectionPointId, int quantity, int itemCatalogueId)
        {
            Employee sessionEmployee = GetEmployee(db);
            Disbursement disbursement = new Disbursement();
            DisbursementDetail disbursementDetail = new DisbursementDetail();
            CollectionPoint collectionPoint = db.CollectionPoint.Where(cp => cp.CollectionPointId == collectionPointId).SingleOrDefault();
            Employee employee = sessionEmployee;
            DisbursementStatus disbursementStatus = db.DisbursementStatus.Where(ds => ds.Description == "PENDING").SingleOrDefault();
            ItemCatalogue itemCatalogue = db.ItemCatalogue.Where(ic => ic.ItemCatalogueId == itemCatalogueId).SingleOrDefault();
            Request request = db.Request.Where(r => r.RequestId == requestId).SingleOrDefault();

            disbursement.CollectionPoint = collectionPoint;
            disbursement.Department = employee.Department;
            disbursement.Employee = employee;
            disbursement.RequestId = requestId;

            disbursementDetail.DisbursementStatus = disbursementStatus;
            disbursementDetail.DisburseQuantity = quantity;
            disbursementDetail.Disbursement = disbursement;
            disbursementDetail.ItemCatalogue = itemCatalogue;

            request.CollectionPoint = collectionPoint;

            db.Disbursement.Add(disbursement);
            db.DisbursementDetail.Add(disbursementDetail);

            db.SaveChanges();
        }

        public void UpdateDisbursementForApprovedRequest(ADProjectDb db, int requestId, int collectionPointId)
        {
            Disbursement disbursement = db.DisbursementDetail
                        .Where(dd => dd.Disbursement.RequestId == requestId)
                        .Select(dd => dd.Disbursement)
                        .FirstOrDefault();
            Request request = db.Request.Where(r => r.RequestId == requestId).SingleOrDefault();

            CollectionPoint collectionPoint = db.CollectionPoint.Where(cp => cp.CollectionPointId == collectionPointId).SingleOrDefault();
            request.CollectionPoint = collectionPoint;
            disbursement.CollectionPoint = collectionPoint;
            db.SaveChanges();
        }

        public void DeleteDisbursementForDisapprovedRequest(ADProjectDb db, int requestId)
        {
            Disbursement disbursement = db.DisbursementDetail
                        .Where(dd => dd.Disbursement.RequestId == requestId)
                        .Select(dd => dd.Disbursement)
                        .FirstOrDefault();
            db.Disbursement.Remove(disbursement);
            db.SaveChanges();
        }

        public void UpdateCollectionPointOnlyForRequest(ADProjectDb db, int requestId, int collectionPointId)
        {
            Request targetRequest = db.Request.Where(r => r.RequestId == requestId).SingleOrDefault();
            CollectionPoint collectionPoint = db.CollectionPoint.Where(cp => cp.CollectionPointId == collectionPointId).SingleOrDefault();
            targetRequest.CollectionPoint = collectionPoint;
            db.SaveChanges();
        }

        public Employee GetEmployee(ADProjectDb db)
        {

            Employee sessionEmployee = HttpContext.Current.Session["employee"] as Employee;
            
            //For testing purpose
            if (sessionEmployee == null)
            {
                sessionEmployee = db.Employee.Where(emp => emp.Username == "employee").SingleOrDefault();
            }

            //Need to get employee from same db context, not session
            Employee employee = db.Employee.Where(emp => emp.EmployeeId == sessionEmployee.EmployeeId).SingleOrDefault();

            Department department = db.Employee.Where(emp => emp.DepartmentId == employee.DepartmentId)
                .Select(emp => emp.Department).FirstOrDefault();

            employee.Department = department;
            return employee;
        }

        

    }
}