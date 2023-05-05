using FluentMigrator;

namespace vfkl.Migrator.Migrations
{
    [Migration(1, BreakingChange = false)]
    public class InitializeDatabase : Migration
    {
        public override void Up()
        {
            var sqlStatement = "Scripts/001_Initialize_Database_Up.sql";
            Execute.Script(sqlStatement);
        }

        public override void Down()
        {
            var sqlStatement = "Scripts/001_Initialize_Database_Down.sql";
            Execute.Script(sqlStatement);
        }
    }
}
