using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class AssignRole
    {
        [Column("TempRoleId")]
        public int AssignRoleId { get; set; }

        [ForeignKey("Employee")]
        public int EmployeeId { get; set; }
        public virtual Employee Employee { get; set; }

        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

        public virtual Employee AssignedBy { get; set; }

        public int? RoleId { get; set; }
        public Role Role { get; set; }

    }


}