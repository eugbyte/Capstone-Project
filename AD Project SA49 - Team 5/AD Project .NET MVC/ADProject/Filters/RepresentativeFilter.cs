using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using static ADProject.StatusEnums;

namespace ADProject.Filters
{
    public class RepresentativeFilter : ActionFilterAttribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationContext filterContext)
        { 
            Employee employee = filterContext.HttpContext.Session["employee"] as Employee;
            using (var db = new ADProjectDb())
            {
                string role = employee.Role.RoleDescription;
                
                bool isValid = false;
                if (role == EmployeeRoleStatusEnum.DEPARTMENT_REP.ToString())
                    isValid = true;

                AssignRole assignRole = employee.AssignRole;
                try
                {
                    if (assignRole.Role.RoleDescription == EmployeeRoleStatusEnum.DEPARTMENT_REP.ToString()
                        && employee.AssignRole.EndDate >= DateTime.Now
                        && employee.AssignRole.StartDate <= DateTime.Now)
                        isValid = true;
                } catch (Exception exception)
                {
                    Debug.WriteLine(exception);
                }
           
                if (isValid == false)
                {
                    filterContext.HttpContext.Session["authorizationErrorMessage"] = "you are not authorized";
                    filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary
                        {
                            {"controller", "Authentication" },
                            {"action", "Login" }
                        });
                }

            }
        }
    
    
    }
}