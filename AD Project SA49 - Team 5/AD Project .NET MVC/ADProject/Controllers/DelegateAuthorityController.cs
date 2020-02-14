using ADProject.Data;
using ADProject.Filters;
using ADProject.Models;
using ADProject.Services.DelegateAuthorities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using static ADProject.StatusEnums;

namespace ADProject.Controllers
{
    [AuthenticationFilter]
    [DepartmentHeadFilter]
    public class DelegateAuthorityController : Controller
    {
        //Dependency injection
        private IDelegateAuthority delegateAuthorityService;
        public DelegateAuthorityController()
        {
            delegateAuthorityService = new DelegateAuthorityService();
        }

        public class CustomEmployee
        {
            public Employee Employee { get; set; }
            public string FullName { get; set; }
            public string RoleDescription { get; set; }
            public bool IsDelegated { get; set; }
            public AssignRole AssignRole { get; set; }
            public Role AssignRole_Role { get; set; }
        }

        

        public ActionResult Index()
        {
            using(var db = new ADProjectDb())
            {
                List<CustomEmployee> employees = delegateAuthorityService.GetCustomEmployeesForIndex(db);
                ViewData["employees"] = employees;
                return View();
            }           
        }
        public ActionResult Edit(Employee employee)
        {
            //For now, just assume department head is the first
            using (var db = new ADProjectDb())
            {
                Employee targetEmployee = delegateAuthorityService.getTargetEmployeeWithAssignedRole(db, employee.EmployeeId);

                CreateSelectListItems_AssignedRoles(db);

                ViewData["employee"] = targetEmployee;
                return View();
            }            
        }

        public ActionResult Save(Employee employee, DateTime startDate, DateTime endDate, int roleId)
        {
            using (var db = new ADProjectDb())
            {
                Employee departmentHead = Session["employee"] as Employee;
                int delegatedEmployeeId = employee.EmployeeId;

                delegateAuthorityService.SaveDelegation(db, delegatedEmployeeId, startDate, endDate, roleId);
                return RedirectToAction("Index", "DelegateAuthority");
            }
                
        }

        public ActionResult Delete(int employeeId)
        {
            using (var db = new ADProjectDb())
            {
                delegateAuthorityService.DeleteDelegation(db, employeeId);
                return RedirectToAction("Index", "DelegateAuthority");
            }
                
        }

        public void CreateSelectListItems_AssignedRoles (ADProjectDb db)
        {
            List<Role> tempHeadAndDepRepRoles = db.Role.Where(r => r.RoleDescription == EmployeeRoleStatusEnum.DEPARTMENT_HEAD_TEMP.ToString()
                || r.RoleDescription == EmployeeRoleStatusEnum.DEPARTMENT_REP.ToString())
                    .ToList();

            List<SelectListItem> selectListRolesForAssignment = tempHeadAndDepRepRoles.Select(r => new SelectListItem
            {
                Text = r.RoleDescription,
                Value = r.RoleId.ToString()
            }).ToList();
            ViewData["selectListRolesForAssignment"] = selectListRolesForAssignment;
        }

        
    }
}
