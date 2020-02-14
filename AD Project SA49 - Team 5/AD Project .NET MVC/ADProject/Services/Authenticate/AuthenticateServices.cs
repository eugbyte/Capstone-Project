using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;

namespace ADProject.Services.Authenticate
{
    public class AuthenticateServices : IAuthenticate
    {
        public Employee GetAuthenticatedEmployee(ADProjectDb db, string username, string password)
        {
            Employee validatedEmployee = null; 
            List<Employee> employees = db.Employee.ToList();
            foreach (var emp in employees)
            {
                if (emp.Username == username && emp.Password == password)
                {
                   validatedEmployee = emp;
                    break;
                }
            }

            if (validatedEmployee == null)
                return validatedEmployee;

            //To handle lazy loading of EmployeeRole and AssignedRole
            Role role = db.Employee.Where(e => e.EmployeeId == validatedEmployee.EmployeeId)
                     .Select(e => e.Role).SingleOrDefault();           
            AssignRole assignRole = db.Employee.Where(e => e.EmployeeId == validatedEmployee.EmployeeId)
                .Select(e => e.AssignRole).SingleOrDefault();
            Role assignedRole_Role = null;
            try
            {
                assignedRole_Role = db.AssignRole.Where(ar => ar.EmployeeId == validatedEmployee.EmployeeId)
                .Select(ar => ar.Role).FirstOrDefault();
                assignRole.Role = assignedRole_Role;
            } catch (Exception exception)
            {
                Debug.WriteLine(exception);
            }                        

            validatedEmployee.Role = role;
            validatedEmployee.AssignRole = assignRole;
            return validatedEmployee;
        }
    }
}