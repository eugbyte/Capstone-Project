using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class Department
    {

        public int DepartmentId { get; set; }
        public String DepName { get; set; }

        //1 Department to many Employees;
        public ICollection<Employee> Employees { get; set; }
        //1 Departments to many Requests
        public ICollection<Request> Requests { get; set; }
    }
}