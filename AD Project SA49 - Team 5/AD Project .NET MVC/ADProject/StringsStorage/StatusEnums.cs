using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject
{
    public class StatusEnums
    {
        public enum RequestStatusEnum { PENDING, REJECTED, APPROVED, DELIVERED }

        public enum OrderStatusEnum { PENDING, DELIVERED }

        public enum DisbursementStatusEnum { PENDING, READY_FOR_COLLECTION, COLLECTED}

        public enum AdjustmentStatusEnum { PENDING, APPROVED_MINOR, APPROVED_MAJOR}

        public enum EmployeeRoleStatusEnum { DEPARTMENT_HEAD, DEPARTMENT_HEAD_TEMP, EMPLOYEE , STORE_CLERK, DEPARTMENT_REP }

    }
}