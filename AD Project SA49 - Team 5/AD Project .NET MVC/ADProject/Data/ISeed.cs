using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ADProject.Data
{
    interface ISeed
    {
        void SeedEntities(DbContext context);
    }
}
