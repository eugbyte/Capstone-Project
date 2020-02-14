using ADProject.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ADProject.Controllers.StoreRetrievalController;

namespace ADProject.Services.StoreRetrieval
{
    interface IStoreRetrieval
    {
        List<Container> GetContainers(ADProjectDb db);
        List<GroupedContainer> GetGroupedContainers(List<Container> containers);
    }
}
