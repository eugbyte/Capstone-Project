using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.Data
{
    public class SeedDepartmentRelatedEntites
    {
        public static void SeedEntities(ADProjectDb context)
        {
            List<Role> roles = new List<Role>()
            {
                new Role("DEPARTMENT_HEAD"),
                new Role("EMPLOYEE")
            };
            Department department = new Department();
            Employee employee = new Employee();
            employee.Role = roles[0];
            Employee departmentHead = new Employee();
            departmentHead.Role = roles[1];
            department.Employees = new List<Employee>();
            department.Employees.Add(employee);
            department.Employees.Add(departmentHead);

            RequestStatus approvedStatus = new RequestStatus();
            approvedStatus.RequestStatusDescription = "APPROVED";

            Request request = new Request();
            request.ApprByEmp = employee;
            request.Department = department;
            request.ApprByEmp = null;

            context.Employee.Add(employee);
            context.Department.Add(department);
            context.Role.AddRange(roles);
            context.RequestStatus.Add(approvedStatus);

            context.SaveChanges();
        }
    }
}