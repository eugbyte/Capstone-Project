using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ADProject.Validation
{
    public class Validator
    {
        //Utilize generics, which will accept all elements
        //if arguments are a mix of primritives and objects,
        //new [] {int 1, object} will be boxed to object[]
        public static bool IsValid <T> (T[] arr) 
        {

            bool isValid = true;
            foreach (var element in arr)
            {
                if (element == null || element.Equals(0))
                    isValid = false;
            }
            return isValid;
        }

        
    }
}