using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ADProject.Validation
{
    public class StartDate : ValidationAttribute
    {
        public StartDate()
        {
            //
        }
        public override bool IsValid(object value)
        {
            DateTime dateTime = (DateTime)value;
            if (dateTime > DateTime.Now)
            {
                return true;
            }
            return false;
        }
    }
}