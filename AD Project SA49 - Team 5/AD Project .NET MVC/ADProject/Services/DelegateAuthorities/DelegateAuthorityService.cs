using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using static ADProject.Controllers.DelegateAuthorityController;
using static ADProject.StatusEnums;

//Eugene
namespace ADProject.Services.DelegateAuthorities
{
    public class DelegateAuthorityService : IDelegateAuthority
    {
        
        public List<CustomEmployee> GetCustomEmployeesForIndex(ADProjectDb db)
        {
            
            Employee departmentHead = GetDepartmentHead(db);
            List<CustomEmployee> customEmployees = (from emp in db.Employee
                                        where emp.DepartmentId == departmentHead.DepartmentId
                                        where emp.EmployeeId != departmentHead.EmployeeId
                                        select new CustomEmployee()
                                        {
                                            Employee = emp,
                                            FullName = emp.FirstName + " " + emp.LastName,
                                            RoleDescription = emp.Role.RoleDescription,
                                            IsDelegated = (emp.AssignRole == null ? false : true),
                                            AssignRole = emp.AssignRole,
                                            AssignRole_Role = emp.AssignRole.Role
                                        }).ToList();
            return customEmployees;
        }

        public Employee getTargetEmployeeWithAssignedRole(ADProjectDb db, int employeeId)
        {
            Employee targetEmployee = db.Employee
                .Where(e => e.EmployeeId == employeeId)
                .SingleOrDefault();
            AssignRole assignRole = db.Employee
                .Where(e => e.EmployeeId == employeeId)
                .Select(e => e.AssignRole).FirstOrDefault();
            
            Role assignedRole_Role = null;
            try
            {
                assignedRole_Role = db.AssignRole.Where(ar => ar.EmployeeId == employeeId)
                .Select(ar => ar.Role).FirstOrDefault();
                assignRole.Role = assignedRole_Role;
            }
            catch (Exception exception)
            {
                Debug.WriteLine(exception);
            }

            targetEmployee.AssignRole = assignRole;
            return targetEmployee;
        }

        public void SaveDelegation(ADProjectDb db, int delegatedEmployeeId, DateTime startDate, DateTime endDate, int assignedRoleId)
        {
            AssignRole assignRole = new AssignRole();
            Employee delegatedEmployee = db.Employee
                .Where(emp => emp.EmployeeId == delegatedEmployeeId)
                .FirstOrDefault();

            //One employee can only have 1 assigned role at a time
            if (delegatedEmployee.AssignRole != null)
                DeleteDelegation(db, delegatedEmployeeId);

            Employee departmentHead = GetDepartmentHead(db);

            assignRole.Employee = delegatedEmployee;
            assignRole.EmployeeId = delegatedEmployee.EmployeeId;
            assignRole.AssignedBy = departmentHead;
            assignRole.StartDate = startDate;
            assignRole.EndDate = endDate;
            assignRole.RoleId = assignedRoleId;

            delegatedEmployee.AssignRole = assignRole;

            db.SaveChanges();
                     
        }

        public void DeleteDelegation(ADProjectDb db, int employeeId)
        {
            AssignRole assignRole = db.Employee
                .Where(emp => emp.EmployeeId == employeeId)
                .Select(emp => emp.AssignRole)
                .SingleOrDefault();

            Employee employee = db.Employee
                .Where(emp => emp.EmployeeId == employeeId)
                .SingleOrDefault();

            employee.AssignRole = null;

            db.AssignRole.Remove(assignRole);
            db.SaveChanges();
        }

        public Employee GetDepartmentHead(ADProjectDb db)
        {
            Employee sessionDepartmentHead = HttpContext.Current.Session["employee"] as Employee;

            //Need to get a fresh Employee form the same dbContext
            Employee departmentHead = db.Employee.Where(emp => emp.EmployeeId == sessionDepartmentHead.EmployeeId).SingleOrDefault();

            return departmentHead;
        }
    }
}