namespace ADProject.Models
{
    public class DisbursementStatus
    {
        public int DisbursementStatusId { get; set; }
        public string Description { get; set; }

        public DisbursementStatus()
        {
            //
        }

        public DisbursementStatus(string Description)
        {
            this.Description = Description;
        }
    }
}