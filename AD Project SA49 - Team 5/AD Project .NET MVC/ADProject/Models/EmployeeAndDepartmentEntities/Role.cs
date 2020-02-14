using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADProject.Models
{
    public class Role
    {
        public int RoleId { get; set; }
        public string RoleDescription { get; set; }

        public Role()
        {
            //
        }

        public Role(string RoleDes)
        {
            this.RoleDescription = RoleDes;
        }
    }
}