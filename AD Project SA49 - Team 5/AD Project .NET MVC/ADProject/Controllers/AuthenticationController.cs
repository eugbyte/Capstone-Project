using ADProject.Data;
using ADProject.Models;
using ADProject.Services.Authenticate;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using static ADProject.StatusEnums;
using ADProject.Filters;

namespace ADProject.Controllers
{
    public class AuthenticationController : Controller
    {
        //Dependency injection
        private IAuthenticate authenticationServices;
        public AuthenticationController()
        {
            authenticationServices = new AuthenticateServices();
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Verify(Employee employee)
        {
            string username = employee.Username;
            string password = employee.Password;
            Session["loginErrorMessage"] = "";
            Session["authorizationErrorMessage"] = "";

            using (var db = new ADProjectDb())
            {
                Employee validatedEmployee = authenticationServices.GetAuthenticatedEmployee(db, username, password);

                if (validatedEmployee != null)
                {
                    Session["isAuth"] = true;
                }
                Session["employee"] = validatedEmployee;

                if (validatedEmployee == null)
                {
                    Session["loginErrorMessage"] = "username or password is incorrect";
                    return View("Login");
                }
                else if (validatedEmployee.Role.RoleDescription == EmployeeRoleStatusEnum.EMPLOYEE.ToString())
                {
                    return RedirectToAction("DepartmentEmployee_WelcomePage", "Authentication");
                }
                else if (validatedEmployee.Role.RoleDescription == EmployeeRoleStatusEnum.DEPARTMENT_HEAD.ToString())
                {
                    return RedirectToAction("DepartmentHead_WelcomePage", "Authentication");
                }
                else if (validatedEmployee.Role.RoleDescription == EmployeeRoleStatusEnum.STORE_CLERK.ToString())
                {
                    return RedirectToAction("StoreClerk_WelcomePage", "Authentication");
                } else if (validatedEmployee.Role.RoleDescription == EmployeeRoleStatusEnum.DEPARTMENT_REP.ToString())
                {
                    return RedirectToAction("Representative_WelcomePage", "Authentication");
                }

                    return View("Login");
            }          
            
        }

        [AuthenticationFilter]
        [EmployeeFilter]
        public ActionResult DepartmentEmployee_WelcomePage ()
        {
            return View();
        }

        [AuthenticationFilter]
        [DepartmentHeadFilter]
        public ActionResult DepartmentHead_WelcomePage ()
        {
            return View();
        }

        [AuthenticationFilter]
        [StoreClerkFilter]
        public ActionResult StoreClerk_WelcomePage ()
        {
            return View();
        }

        [AuthenticationFilter]
        [RepresentativeFilter]
        public ActionResult Representative_WelcomePage()
        {
            return View();
        }

        [AuthenticationFilter]
        public ActionResult Logout()
        {
            Session.Abandon();
            return RedirectToAction("Login", "Authentication");
        }
    }
}