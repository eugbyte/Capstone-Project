namespace ADProject.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AssignRole_FK : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.AssignRoles", "RoleId", c => c.Int());
            CreateIndex("dbo.AssignRoles", "RoleId");
            AddForeignKey("dbo.AssignRoles", "RoleId", "dbo.Roles", "RoleId");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.AssignRoles", "RoleId", "dbo.Roles");
            DropIndex("dbo.AssignRoles", new[] { "RoleId" });
            DropColumn("dbo.AssignRoles", "RoleId");
        }
    }
}
