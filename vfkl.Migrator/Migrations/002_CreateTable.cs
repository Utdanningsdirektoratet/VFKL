using FluentMigrator;

namespace vfkl.Migrator.Migrations
{
    [Migration(2, BreakingChange = false)]
    public class CreateTable : Migration
    {
        public override void Up()
        {
            var sqlStatement = "Scripts/002_CreateTable_Up.sql";
            Execute.Script(sqlStatement);
        }

        public override void Down()
        {

        }
    }
}
