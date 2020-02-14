using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class Employee
    {
        
        public int EmployeeId { get; set; }

        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string EmpPhone { get; set; }
        public string EmpFax { get; set; }

        public string Username { get; set; }
        public string Password { get; set; }

        public string EmpEmail { get; set; }

        //1 Employee to 1 Role
        public int RoleId { get; set; }
        public virtual Role Role { get; set; }

        //1 Employee to Many Department
        public int?  DepartmentId { get; set; }
        public Department Department { get; set; }

        //1 Employee to 1 AssignedRole
        public virtual AssignRole AssignRole { get; set; }
    }
}