using ADProject.Data;
using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ADProject.Controllers.DelegateAuthorityController;

//Eugene
namespace ADProject.Services.DelegateAuthorities
{
    interface IDelegateAuthority
    {
        List<CustomEmployee> GetCustomEmployeesForIndex(ADProjectDb db);
        void SaveDelegation(ADProjectDb db, int delegatedEmployeeId, DateTime startDate, DateTime endDate, int assignedRoleId);
        void DeleteDelegation(ADProjectDb db, int employeeId);
        Employee getTargetEmployeeWithAssignedRole(ADProjectDb db, int employeeId);

    }
}
