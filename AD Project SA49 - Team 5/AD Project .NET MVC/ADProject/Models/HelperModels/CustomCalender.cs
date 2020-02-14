using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

//Helper Model - not populated
namespace ADProject.Models.HelperModels
{
    public class CustomCalender
    {
        [Display(Name="Start Date")]
        [DataType(DataType.Date)]
        [Required]
        public DateTime ? StartDate { get; set; }

        [Display(Name = "End Date")]
        [DataType(DataType.Date)]
        [Required]
        public DateTime? EndDate { get; set; }
    }
}