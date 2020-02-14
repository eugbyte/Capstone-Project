using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace ADProject.Data
{
    public class ADProjectDbInitializer<T> : CreateDatabaseIfNotExists <ADProjectDb>
    {
        
        protected override void Seed(ADProjectDb context)
        {
            //SeedDepartmentRelatedEntites.SeedEntities(context);
            //SeedClerkRelatedEntites.SeedEntities(context);
            //SeedDisbursementRelatedEntities.SeedEntities(context);
            //SeedAdjustmentVoucherRelatedEntities.SeedEntities(context);

            base.Seed(context);
        }

   
        
    }
}