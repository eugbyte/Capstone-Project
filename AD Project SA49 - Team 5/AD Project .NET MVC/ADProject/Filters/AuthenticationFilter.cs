using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Filters;
using System.Web.Routing;

namespace ADProject.Filters
{
    public class AuthenticationFilter : ActionFilterAttribute, IAuthenticationFilter
    {
        public void OnAuthentication(AuthenticationContext filterContext)
        {
            bool isAuth = false;
            try
            {
                isAuth = (bool)filterContext.HttpContext.Session["isAuth"];
            }
            catch (NullReferenceException error)
            {
                Debug.WriteLine(error);
            }

            if (isAuth == false)
            {
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary
                        {
                            {"controller", "Authentication" },
                            {"action", "Login" }
                        }
                    );
            }
        }

        public void OnAuthenticationChallenge(AuthenticationChallengeContext filterContext)
        {
            Debug.WriteLine("Direct route access attempted");
        }
    }
}