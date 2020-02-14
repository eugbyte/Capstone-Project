using ADProject.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;


namespace ADProject.Data
{
    public class ADProjectDb : DbContext
    {
        public ADProjectDb() : base("Server=" + UrlStorage.MSSQL_NAME + ";" +
                "Database=AD_Project; Integrated Security=true")
        {
            Database.SetInitializer(new ADProjectDbInitializer<ADProjectDb>());
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            //To create inherited class

            //Configure 1 Disbursement to 1 DisbursementDetail relationship
            //FAILED
            //modelBuilder.Entity<Disbursement>()
            //    .HasRequired(d => d.DisbursementDetail)
            //    .WithRequiredPrincipal(dd => dd.Disbursement);
        }

        
        public DbSet<Order> Order { get; set; }
        public DbSet<OrderDetail> OrderDetail { get; set; }
        public DbSet<OrderStatus> OrderStatus { get; set; }

        public DbSet<Supplier> Supplier { get; set; }
        public DbSet<SupplierCatalogue> SupplierCatalogue { get; set; }

        public DbSet<ItemCatalogue> ItemCatalogue { get; set; }
        public DbSet<Category> Categories { get; set; }

        public DbSet<Department> Department { get; set; }
        public DbSet<Employee> Employee { get; set; }
        public DbSet<Role> Role { get; set; }
        public DbSet<AssignRole> AssignRole { get; set; }
        
                
        public DbSet<Request> Request { get; set; }
        public DbSet<RequestDetail> RequestDetail { get; set; }
        public DbSet<RequestStatus> RequestStatus { get; set; }

        public DbSet<Disbursement> Disbursement { get; set; }
        public DbSet<CollectionPoint> CollectionPoint { get; set; }
        public DbSet<DisbursementDetail> DisbursementDetail { get; set; }
        public DbSet<DisbursementStatus> DisbursementStatus { get; set; }

        public DbSet<StockInfo> StockInfo { get; set; }
        public DbSet<StockCard> stockCard { get; set; }

        public DbSet<AdjustmentDetail> AdjustmentDetail { get; set; }
        public DbSet<AdjustmentVoucher> AdjustmentVoucher { get; set; }
        public DbSet<AdjustmentStatus> AdjustmentStatus { get; set; }



    }
}