using ADProject.Data;
using ADProject.Models;
using ADProject.Services.Authenticate;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace ADProject.Controllers.APIs
{
    [System.Web.Http.Route("api/authentication")]
    public class AuthenticationRestController : ApiController
    {
        //Dependency injection
        private IAuthenticate authenticationServices;
        public AuthenticationRestController()
        {
            authenticationServices = new AuthenticateServices();
        }

        public IHttpActionResult GetCredential(string username, string password)
        {
            using (var db = new ADProjectDb())
            {
                LoginResponse loginResponse;
                Employee validatedEmployee = authenticationServices.GetAuthenticatedEmployee(db, username, password);

                if (validatedEmployee != null)
                {
                    loginResponse = new LoginResponse() {authenticationStatus = "Authenticated" , role =validatedEmployee.Role.RoleDescription, username = validatedEmployee.Username,password = validatedEmployee.Password, empId = validatedEmployee.EmployeeId};
                }
                else
                {
                    loginResponse = new LoginResponse() { authenticationStatus = "Unauthenticated" };
                }

                return Ok(loginResponse);
            }
        }

    }

    public class LoginResponse
    {
        public string authenticationStatus { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public string role { get; set; }
        public int empId { get; set; }
    }
}
