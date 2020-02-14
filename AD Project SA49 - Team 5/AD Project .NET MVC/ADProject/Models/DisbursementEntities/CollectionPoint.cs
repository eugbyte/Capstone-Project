using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ADProject.Models
{
    public class CollectionPoint
    {

        public int CollectionPointId { get; set; }

        //1 CollectionPoint 
        public int EmployeeId { get; set; }
        public virtual Employee Employee { get; set; }

        public string Location { get; set; }
        public DateTime? CollectionTime { get; set; }

    }
}