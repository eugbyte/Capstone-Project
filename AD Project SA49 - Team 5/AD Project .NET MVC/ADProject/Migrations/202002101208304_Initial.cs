namespace ADProject.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Initial : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.AdjustmentDetails",
                c => new
                    {
                        AdjustmentVoucherId = c.Int(nullable: false),
                        ItemCatalogueId = c.Int(nullable: false),
                        Quantity = c.Int(nullable: false),
                        Cost = c.Double(nullable: false),
                        Reason = c.String(),
                    })
                .PrimaryKey(t => new { t.AdjustmentVoucherId, t.ItemCatalogueId })
                .ForeignKey("dbo.AdjustmentVouchers", t => t.AdjustmentVoucherId, cascadeDelete: true)
                .ForeignKey("dbo.ItemCatalogues", t => t.ItemCatalogueId, cascadeDelete: true)
                .Index(t => t.AdjustmentVoucherId)
                .Index(t => t.ItemCatalogueId);
            
            CreateTable(
                "dbo.AdjustmentVouchers",
                c => new
                    {
                        AdjustmentVoucherId = c.Int(nullable: false, identity: true),
                        RaiseDate = c.DateTime(),
                        ApproveDate = c.DateTime(),
                        AdjustmentStatusId = c.Int(nullable: false),
                        AdjustmentDetailId = c.Int(nullable: false),
                        ApprovedByEmployee_EmployeeId = c.Int(),
                        RaisedByEmployee_EmployeeId = c.Int(),
                    })
                .PrimaryKey(t => t.AdjustmentVoucherId)
                .ForeignKey("dbo.AdjustmentStatus", t => t.AdjustmentStatusId, cascadeDelete: true)
                .ForeignKey("dbo.Employees", t => t.ApprovedByEmployee_EmployeeId)
                .ForeignKey("dbo.Employees", t => t.RaisedByEmployee_EmployeeId)
                .Index(t => t.AdjustmentStatusId)
                .Index(t => t.ApprovedByEmployee_EmployeeId)
                .Index(t => t.RaisedByEmployee_EmployeeId);
            
            CreateTable(
                "dbo.AdjustmentStatus",
                c => new
                    {
                        AdjustmentStatusId = c.Int(nullable: false, identity: true),
                        Description = c.String(),
                    })
                .PrimaryKey(t => t.AdjustmentStatusId);
            
            CreateTable(
                "dbo.Employees",
                c => new
                    {
                        EmployeeId = c.Int(nullable: false, identity: true),
                        FirstName = c.String(),
                        LastName = c.String(),
                        EmpPhone = c.String(),
                        EmpFax = c.String(),
                        Username = c.String(),
                        Password = c.String(),
                        EmpEmail = c.String(),
                        RoleId = c.Int(nullable: false),
                        DepartmentId = c.Int(),
                        AssignRole_AssignRoleId = c.Int(),
                    })
                .PrimaryKey(t => t.EmployeeId)
                .ForeignKey("dbo.AssignRoles", t => t.AssignRole_AssignRoleId)
                .ForeignKey("dbo.Departments", t => t.DepartmentId)
                .ForeignKey("dbo.Roles", t => t.RoleId, cascadeDelete: true)
                .Index(t => t.RoleId)
                .Index(t => t.DepartmentId)
                .Index(t => t.AssignRole_AssignRoleId);
            
            CreateTable(
                "dbo.AssignRoles",
                c => new
                    {
                        TempRoleId = c.Int(nullable: false, identity: true),
                        EmployeeId = c.Int(nullable: false),
                        StartDate = c.DateTime(nullable: false),
                        EndDate = c.DateTime(nullable: false),
                        AssignedBy_EmployeeId = c.Int(),
                    })
                .PrimaryKey(t => t.TempRoleId)
                .ForeignKey("dbo.Employees", t => t.AssignedBy_EmployeeId)
                .ForeignKey("dbo.Employees", t => t.EmployeeId, cascadeDelete: true)
                .Index(t => t.EmployeeId)
                .Index(t => t.AssignedBy_EmployeeId);
            
            CreateTable(
                "dbo.Departments",
                c => new
                    {
                        DepartmentId = c.Int(nullable: false, identity: true),
                        DepName = c.String(),
                    })
                .PrimaryKey(t => t.DepartmentId);
            
            CreateTable(
                "dbo.Requests",
                c => new
                    {
                        RequestId = c.Int(nullable: false, identity: true),
                        DepartmentId = c.Int(nullable: false),
                        ApprByDate = c.DateTime(),
                        RequestStatusId = c.Int(nullable: false),
                        RequestComment = c.String(),
                        DepHeadComment = c.String(),
                        RequestDate = c.DateTime(),
                        ApprByEmp_EmployeeId = c.Int(),
                        CollectionPoint_CollectionPointId = c.Int(),
                        RaisedByEmployee_EmployeeId = c.Int(),
                        Disbursement_DisbursementId = c.Int(),
                    })
                .PrimaryKey(t => t.RequestId)
                .ForeignKey("dbo.Employees", t => t.ApprByEmp_EmployeeId)
                .ForeignKey("dbo.CollectionPoints", t => t.CollectionPoint_CollectionPointId)
                .ForeignKey("dbo.Departments", t => t.DepartmentId, cascadeDelete: true)
                .ForeignKey("dbo.Employees", t => t.RaisedByEmployee_EmployeeId)
                .ForeignKey("dbo.RequestStatus", t => t.RequestStatusId, cascadeDelete: true)
                .ForeignKey("dbo.Disbursements", t => t.Disbursement_DisbursementId)
                .Index(t => t.DepartmentId)
                .Index(t => t.RequestStatusId)
                .Index(t => t.ApprByEmp_EmployeeId)
                .Index(t => t.CollectionPoint_CollectionPointId)
                .Index(t => t.RaisedByEmployee_EmployeeId)
                .Index(t => t.Disbursement_DisbursementId);
            
            CreateTable(
                "dbo.CollectionPoints",
                c => new
                    {
                        CollectionPointId = c.Int(nullable: false, identity: true),
                        EmployeeId = c.Int(nullable: false),
                        Location = c.String(),
                        CollectionTime = c.DateTime(),
                    })
                .PrimaryKey(t => t.CollectionPointId)
                .ForeignKey("dbo.Employees", t => t.EmployeeId, cascadeDelete: true)
                .Index(t => t.EmployeeId);
            
            CreateTable(
                "dbo.RequestDetails",
                c => new
                    {
                        RequestDetailId = c.Int(nullable: false, identity: true),
                        RequestId = c.Int(nullable: false),
                        ItemCatalogueId = c.Int(nullable: false),
                        Quantity = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.RequestDetailId)
                .ForeignKey("dbo.ItemCatalogues", t => t.ItemCatalogueId, cascadeDelete: true)
                .ForeignKey("dbo.Requests", t => t.RequestId, cascadeDelete: true)
                .Index(t => t.RequestId)
                .Index(t => t.ItemCatalogueId);
            
            CreateTable(
                "dbo.ItemCatalogues",
                c => new
                    {
                        ItemId = c.Int(nullable: false, identity: true),
                        ItemDes = c.String(),
                        UnitOfMeasure = c.String(),
                        CategoryId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.ItemId)
                .ForeignKey("dbo.Categories", t => t.CategoryId, cascadeDelete: true)
                .Index(t => t.CategoryId);
            
            CreateTable(
                "dbo.Categories",
                c => new
                    {
                        CategoryId = c.Int(nullable: false, identity: true),
                        CategoryDescription = c.String(),
                    })
                .PrimaryKey(t => t.CategoryId);
            
            CreateTable(
                "dbo.StockInfoes",
                c => new
                    {
                        StockInfoId = c.Int(nullable: false),
                        ItemCatalogueId = c.Int(nullable: false),
                        ItemLocation = c.String(),
                        ReOrderLevel = c.Int(nullable: false),
                        ReOrderQuantity = c.Int(nullable: false),
                        StockQuantity = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.StockInfoId)
                .ForeignKey("dbo.ItemCatalogues", t => t.StockInfoId)
                .Index(t => t.StockInfoId);
            
            CreateTable(
                "dbo.RequestStatus",
                c => new
                    {
                        RequestStatusId = c.Int(nullable: false, identity: true),
                        RequestStatusDescription = c.String(),
                    })
                .PrimaryKey(t => t.RequestStatusId);
            
            CreateTable(
                "dbo.Roles",
                c => new
                    {
                        RoleId = c.Int(nullable: false, identity: true),
                        RoleDescription = c.String(),
                    })
                .PrimaryKey(t => t.RoleId);
            
            CreateTable(
                "dbo.Disbursements",
                c => new
                    {
                        DisbursementId = c.Int(nullable: false, identity: true),
                        DepartmentId = c.Int(nullable: false),
                        CollectionPointId = c.Int(nullable: false),
                        RequestId = c.Int(nullable: false),
                        DisburseDate = c.DateTime(),
                        Employee_EmployeeId = c.Int(),
                    })
                .PrimaryKey(t => t.DisbursementId)
                .ForeignKey("dbo.CollectionPoints", t => t.CollectionPointId, cascadeDelete: true)
                .ForeignKey("dbo.Departments", t => t.DepartmentId, cascadeDelete: true)
                .ForeignKey("dbo.Employees", t => t.Employee_EmployeeId)
                .Index(t => t.DepartmentId)
                .Index(t => t.CollectionPointId)
                .Index(t => t.Employee_EmployeeId);
            
            CreateTable(
                "dbo.DisbursementDetails",
                c => new
                    {
                        DisbursementDetailId = c.Int(nullable: false, identity: true),
                        DisbursementId = c.Int(nullable: false),
                        ItemCatalogueId = c.Int(nullable: false),
                        DisburseQuantity = c.Int(nullable: false),
                        DisbursementStatusId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.DisbursementDetailId)
                .ForeignKey("dbo.Disbursements", t => t.DisbursementId, cascadeDelete: true)
                .ForeignKey("dbo.DisbursementStatus", t => t.DisbursementStatusId, cascadeDelete: true)
                .ForeignKey("dbo.ItemCatalogues", t => t.ItemCatalogueId, cascadeDelete: true)
                .Index(t => t.DisbursementId)
                .Index(t => t.ItemCatalogueId)
                .Index(t => t.DisbursementStatusId);
            
            CreateTable(
                "dbo.DisbursementStatus",
                c => new
                    {
                        DisbursementStatusId = c.Int(nullable: false, identity: true),
                        Description = c.String(),
                    })
                .PrimaryKey(t => t.DisbursementStatusId);
            
            CreateTable(
                "dbo.Orders",
                c => new
                    {
                        OrderId = c.Int(nullable: false, identity: true),
                        SupplierId = c.Int(nullable: false),
                        EmpId = c.Int(nullable: false),
                        OrderDate = c.DateTime(),
                        Employee_EmployeeId = c.Int(),
                        OrderStatus_OrderStatusId = c.Int(),
                    })
                .PrimaryKey(t => t.OrderId)
                .ForeignKey("dbo.Employees", t => t.Employee_EmployeeId)
                .ForeignKey("dbo.OrderStatus", t => t.OrderStatus_OrderStatusId)
                .ForeignKey("dbo.Suppliers", t => t.SupplierId, cascadeDelete: true)
                .Index(t => t.SupplierId)
                .Index(t => t.Employee_EmployeeId)
                .Index(t => t.OrderStatus_OrderStatusId);
            
            CreateTable(
                "dbo.OrderDetails",
                c => new
                    {
                        OrderId = c.Int(nullable: false),
                        ItemId = c.Int(nullable: false),
                        OrderQuantity = c.Int(nullable: false),
                        ExpDelDate = c.DateTime(),
                        ActDelDate = c.DateTime(),
                        ReceiveQuantity = c.Int(nullable: false),
                        ItemCatalogue_ItemCatalogueId = c.Int(),
                    })
                .PrimaryKey(t => new { t.OrderId, t.ItemId })
                .ForeignKey("dbo.ItemCatalogues", t => t.ItemCatalogue_ItemCatalogueId)
                .ForeignKey("dbo.Orders", t => t.OrderId, cascadeDelete: true)
                .Index(t => t.OrderId)
                .Index(t => t.ItemCatalogue_ItemCatalogueId);
            
            CreateTable(
                "dbo.OrderStatus",
                c => new
                    {
                        OrderStatusId = c.Int(nullable: false, identity: true),
                        OrderDes = c.String(),
                    })
                .PrimaryKey(t => t.OrderStatusId);
            
            CreateTable(
                "dbo.Suppliers",
                c => new
                    {
                        SupplierId = c.Int(nullable: false, identity: true),
                        SupplierName = c.String(),
                        SupplierContact = c.String(),
                        SupplierPhone = c.String(),
                        SupplierFax = c.String(),
                        SupplierAddress = c.String(),
                        SupplierEmail = c.String(),
                        SupplierGST = c.String(),
                    })
                .PrimaryKey(t => t.SupplierId);
            
            CreateTable(
                "dbo.StockCards",
                c => new
                    {
                        StockCardId = c.Int(nullable: false, identity: true),
                        ItemCatalogueId = c.Int(nullable: false),
                        ChangeDate = c.DateTime(),
                        ChangeDescription = c.String(),
                        ChangeQuantity = c.Int(nullable: false),
                        StockInfo_StockInfoId = c.Int(),
                    })
                .PrimaryKey(t => t.StockCardId)
                .ForeignKey("dbo.ItemCatalogues", t => t.ItemCatalogueId, cascadeDelete: true)
                .ForeignKey("dbo.StockInfoes", t => t.StockInfo_StockInfoId)
                .Index(t => t.ItemCatalogueId)
                .Index(t => t.StockInfo_StockInfoId);
            
            CreateTable(
                "dbo.SupplierCatalogues",
                c => new
                    {
                        SupplierId = c.Int(nullable: false),
                        ItemId = c.Int(nullable: false),
                        ItemPrice = c.Double(nullable: false),
                        SupplierRank = c.Int(nullable: false),
                        ItemCatalogue_ItemCatalogueId = c.Int(),
                    })
                .PrimaryKey(t => new { t.SupplierId, t.ItemId })
                .ForeignKey("dbo.ItemCatalogues", t => t.ItemCatalogue_ItemCatalogueId)
                .ForeignKey("dbo.Suppliers", t => t.SupplierId, cascadeDelete: true)
                .Index(t => t.SupplierId)
                .Index(t => t.ItemCatalogue_ItemCatalogueId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.SupplierCatalogues", "SupplierId", "dbo.Suppliers");
            DropForeignKey("dbo.SupplierCatalogues", "ItemCatalogue_ItemCatalogueId", "dbo.ItemCatalogues");
            DropForeignKey("dbo.StockCards", "StockInfo_StockInfoId", "dbo.StockInfoes");
            DropForeignKey("dbo.StockCards", "ItemCatalogueId", "dbo.ItemCatalogues");
            DropForeignKey("dbo.Orders", "SupplierId", "dbo.Suppliers");
            DropForeignKey("dbo.Orders", "OrderStatus_OrderStatusId", "dbo.OrderStatus");
            DropForeignKey("dbo.OrderDetails", "OrderId", "dbo.Orders");
            DropForeignKey("dbo.OrderDetails", "ItemCatalogue_ItemCatalogueId", "dbo.ItemCatalogues");
            DropForeignKey("dbo.Orders", "Employee_EmployeeId", "dbo.Employees");
            DropForeignKey("dbo.DisbursementDetails", "ItemCatalogueId", "dbo.ItemCatalogues");
            DropForeignKey("dbo.DisbursementDetails", "DisbursementStatusId", "dbo.DisbursementStatus");
            DropForeignKey("dbo.DisbursementDetails", "DisbursementId", "dbo.Disbursements");
            DropForeignKey("dbo.Requests", "Disbursement_DisbursementId", "dbo.Disbursements");
            DropForeignKey("dbo.Disbursements", "Employee_EmployeeId", "dbo.Employees");
            DropForeignKey("dbo.Disbursements", "DepartmentId", "dbo.Departments");
            DropForeignKey("dbo.Disbursements", "CollectionPointId", "dbo.CollectionPoints");
            DropForeignKey("dbo.AdjustmentDetails", "ItemCatalogueId", "dbo.ItemCatalogues");
            DropForeignKey("dbo.AdjustmentVouchers", "RaisedByEmployee_EmployeeId", "dbo.Employees");
            DropForeignKey("dbo.AdjustmentVouchers", "ApprovedByEmployee_EmployeeId", "dbo.Employees");
            DropForeignKey("dbo.Employees", "RoleId", "dbo.Roles");
            DropForeignKey("dbo.Requests", "RequestStatusId", "dbo.RequestStatus");
            DropForeignKey("dbo.RequestDetails", "RequestId", "dbo.Requests");
            DropForeignKey("dbo.RequestDetails", "ItemCatalogueId", "dbo.ItemCatalogues");
            DropForeignKey("dbo.StockInfoes", "StockInfoId", "dbo.ItemCatalogues");
            DropForeignKey("dbo.ItemCatalogues", "CategoryId", "dbo.Categories");
            DropForeignKey("dbo.Requests", "RaisedByEmployee_EmployeeId", "dbo.Employees");
            DropForeignKey("dbo.Requests", "DepartmentId", "dbo.Departments");
            DropForeignKey("dbo.Requests", "CollectionPoint_CollectionPointId", "dbo.CollectionPoints");
            DropForeignKey("dbo.CollectionPoints", "EmployeeId", "dbo.Employees");
            DropForeignKey("dbo.Requests", "ApprByEmp_EmployeeId", "dbo.Employees");
            DropForeignKey("dbo.Employees", "DepartmentId", "dbo.Departments");
            DropForeignKey("dbo.Employees", "AssignRole_AssignRoleId", "dbo.AssignRoles");
            DropForeignKey("dbo.AssignRoles", "EmployeeId", "dbo.Employees");
            DropForeignKey("dbo.AssignRoles", "AssignedBy_EmployeeId", "dbo.Employees");
            DropForeignKey("dbo.AdjustmentVouchers", "AdjustmentStatusId", "dbo.AdjustmentStatus");
            DropForeignKey("dbo.AdjustmentDetails", "AdjustmentVoucherId", "dbo.AdjustmentVouchers");
            DropIndex("dbo.SupplierCatalogues", new[] { "ItemCatalogue_ItemCatalogueId" });
            DropIndex("dbo.SupplierCatalogues", new[] { "SupplierId" });
            DropIndex("dbo.StockCards", new[] { "StockInfo_StockInfoId" });
            DropIndex("dbo.StockCards", new[] { "ItemCatalogueId" });
            DropIndex("dbo.OrderDetails", new[] { "ItemCatalogue_ItemCatalogueId" });
            DropIndex("dbo.OrderDetails", new[] { "OrderId" });
            DropIndex("dbo.Orders", new[] { "OrderStatus_OrderStatusId" });
            DropIndex("dbo.Orders", new[] { "Employee_EmployeeId" });
            DropIndex("dbo.Orders", new[] { "SupplierId" });
            DropIndex("dbo.DisbursementDetails", new[] { "DisbursementStatusId" });
            DropIndex("dbo.DisbursementDetails", new[] { "ItemCatalogueId" });
            DropIndex("dbo.DisbursementDetails", new[] { "DisbursementId" });
            DropIndex("dbo.Disbursements", new[] { "Employee_EmployeeId" });
            DropIndex("dbo.Disbursements", new[] { "CollectionPointId" });
            DropIndex("dbo.Disbursements", new[] { "DepartmentId" });
            DropIndex("dbo.StockInfoes", new[] { "StockInfoId" });
            DropIndex("dbo.ItemCatalogues", new[] { "CategoryId" });
            DropIndex("dbo.RequestDetails", new[] { "ItemCatalogueId" });
            DropIndex("dbo.RequestDetails", new[] { "RequestId" });
            DropIndex("dbo.CollectionPoints", new[] { "EmployeeId" });
            DropIndex("dbo.Requests", new[] { "Disbursement_DisbursementId" });
            DropIndex("dbo.Requests", new[] { "RaisedByEmployee_EmployeeId" });
            DropIndex("dbo.Requests", new[] { "CollectionPoint_CollectionPointId" });
            DropIndex("dbo.Requests", new[] { "ApprByEmp_EmployeeId" });
            DropIndex("dbo.Requests", new[] { "RequestStatusId" });
            DropIndex("dbo.Requests", new[] { "DepartmentId" });
            DropIndex("dbo.AssignRoles", new[] { "AssignedBy_EmployeeId" });
            DropIndex("dbo.AssignRoles", new[] { "EmployeeId" });
            DropIndex("dbo.Employees", new[] { "AssignRole_AssignRoleId" });
            DropIndex("dbo.Employees", new[] { "DepartmentId" });
            DropIndex("dbo.Employees", new[] { "RoleId" });
            DropIndex("dbo.AdjustmentVouchers", new[] { "RaisedByEmployee_EmployeeId" });
            DropIndex("dbo.AdjustmentVouchers", new[] { "ApprovedByEmployee_EmployeeId" });
            DropIndex("dbo.AdjustmentVouchers", new[] { "AdjustmentStatusId" });
            DropIndex("dbo.AdjustmentDetails", new[] { "ItemCatalogueId" });
            DropIndex("dbo.AdjustmentDetails", new[] { "AdjustmentVoucherId" });
            DropTable("dbo.SupplierCatalogues");
            DropTable("dbo.StockCards");
            DropTable("dbo.Suppliers");
            DropTable("dbo.OrderStatus");
            DropTable("dbo.OrderDetails");
            DropTable("dbo.Orders");
            DropTable("dbo.DisbursementStatus");
            DropTable("dbo.DisbursementDetails");
            DropTable("dbo.Disbursements");
            DropTable("dbo.Roles");
            DropTable("dbo.RequestStatus");
            DropTable("dbo.StockInfoes");
            DropTable("dbo.Categories");
            DropTable("dbo.ItemCatalogues");
            DropTable("dbo.RequestDetails");
            DropTable("dbo.CollectionPoints");
            DropTable("dbo.Requests");
            DropTable("dbo.Departments");
            DropTable("dbo.AssignRoles");
            DropTable("dbo.Employees");
            DropTable("dbo.AdjustmentStatus");
            DropTable("dbo.AdjustmentVouchers");
            DropTable("dbo.AdjustmentDetails");
        }
    }
}
