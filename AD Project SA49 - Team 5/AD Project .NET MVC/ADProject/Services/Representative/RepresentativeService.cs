using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using static ADProject.Controllers.RepresentativeController;
using static ADProject.StatusEnums;

namespace ADProject.Services.Representative
{
    public class RepresentativeService : IRepresentative
    {
        public List<Container> GetContainers(ADProjectDb db)
        {
            Employee employee = GetEmployee(db);
            List<Container> containers = (from rd in db.RequestDetail
                                          join item in db.ItemCatalogue
                                          on rd.ItemCatalogue.ItemCatalogueId equals item.ItemCatalogueId
                                          where rd.Request.Department.DepartmentId == employee.DepartmentId
                                          where rd.Request.RequestStatus.RequestStatusDescription != RequestStatusEnum.DELIVERED.ToString()
                                          select new Container
                                          {
                                              RequestDetail = rd,
                                              Request = rd.Request,
                                              ItemCatalogue = item,
                                              RequestStatus = rd.Request.RequestStatus,
                                              CollectionPoint = rd.Request.CollectionPoint
                                          }).ToList();
            return containers;
        }

        public CollectionPoint GetLatestCollectionPoint(ADProjectDb db, int? employeeId = null)
        {
            Employee employee = null;
            if (employeeId == null)
                employee = GetEmployee(db);
            else
                employee = db.Employee.Where(emp => emp.EmployeeId == employeeId).SingleOrDefault();

            int departmentId = (int)employee.DepartmentId;
            CollectionPoint collectionPoint = db.Request
                .OrderByDescending(r => r.RequestId)
                .Where(r => r.CollectionPoint != null)
                .Where(r => r.DepartmentId == departmentId)
                .Select(r => r.CollectionPoint)
                .FirstOrDefault();
            return collectionPoint;
        }

        public void UpdateCollectionPointForAllRequest(ADProjectDb db, int collectionPointId, int? employeeId = null)
        {
           
            int departmentId = (int)GetEmployee(db).DepartmentId;

            if (employeeId != null)
            {
                departmentId = (int)db.Employee
                    .Where(emp => emp.EmployeeId == employeeId)
                    .Select(emp => emp.DepartmentId)
                    .FirstOrDefault();
            }



            List<Request> requests = db.Request.Where(r => r.DepartmentId == departmentId).ToList();

            CollectionPoint collectionPoint = db.CollectionPoint
                .Where(cp => cp.CollectionPointId == collectionPointId)
                .SingleOrDefault();

            requests.ForEach(r => r.CollectionPoint = collectionPoint);

            List<Disbursement> disbursements = db.DisbursementDetail
                .Where(dd => dd.DisbursementStatus.Description != DisbursementStatusEnum.READY_FOR_COLLECTION.ToString())
                .Select(dd => dd.Disbursement)
                .ToList();

            disbursements.ForEach(d => d.CollectionPoint = collectionPoint);

            db.SaveChanges();
        }

        public List<Container> GetCollectRequestedItems(ADProjectDb db, int? employeeId = null)
        {
            
            Employee employee;
            if (employeeId == null)
                employee = GetEmployee(db);
            else
                employee = db.Employee.Where(emp => emp.EmployeeId == employeeId).SingleOrDefault();

            List<Container> containers = (from dd in db.DisbursementDetail
                                            join rd in db.RequestDetail
                                            on dd.Disbursement.RequestId equals rd.RequestId
                                            where rd.Request.DepartmentId == employee.DepartmentId
                                            where dd.DisbursementStatus.Description == DisbursementStatusEnum.READY_FOR_COLLECTION.ToString()
                                            where rd.Request.RequestStatus.RequestStatusDescription != RequestStatusEnum.DELIVERED.ToString()
                                            select new Container
                                            {
                                                DisbursementDetail = dd,
                                                RequestDetail = rd,
                                                Request = rd.Request,
                                                RequestStatus = rd.Request.RequestStatus,
                                                ItemCatalogue = rd.ItemCatalogue,
                                                CollectionPoint = dd.Disbursement.CollectionPoint,
                                                DisbursementStatus = dd.DisbursementStatus
                                            }).ToList();
            return containers;
            

        }
        public void SetRequestStatusToDelivered(ADProjectDb db, int requestId)
        {
            Request request = db.Request.Where(r => r.RequestId == requestId).SingleOrDefault();
            RequestStatus requestStatus = db.RequestStatus.Where(rs => rs.RequestStatusDescription == RequestStatusEnum.DELIVERED.ToString()).SingleOrDefault();
            request.RequestStatus = requestStatus;
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