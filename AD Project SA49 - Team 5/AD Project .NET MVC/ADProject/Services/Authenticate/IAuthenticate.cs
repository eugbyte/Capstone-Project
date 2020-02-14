using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ADProject.Services.Authenticate
{
    interface IAuthenticate
    {
        Employee GetAuthenticatedEmployee(ADProjectDb db, string username, string password);
    }
}
