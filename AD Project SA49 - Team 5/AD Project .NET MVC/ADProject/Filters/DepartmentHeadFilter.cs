using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using static ADProject.StatusEnums;

namespace ADProject.Filters
{
    public class DepartmentHeadFilter : ActionFilterAttribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            Employee employee = filterContext.HttpContext.Session["employee"] as Employee;
            using(var db = new ADProjectDb())
            {
                string role = employee.Role.RoleDescription;
                if (role != EmployeeRoleStatusEnum.DEPARTMENT_HEAD.ToString())
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