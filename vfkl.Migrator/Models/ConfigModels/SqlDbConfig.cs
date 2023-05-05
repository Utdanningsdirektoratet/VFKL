namespace vfkl.Migrator.Models.ConfigModels
{
    public class SqlDbConfig
    {
        public const string SectionName = "SqlDbConfig";

        public string ConnectionString { get; set; }
    }
}