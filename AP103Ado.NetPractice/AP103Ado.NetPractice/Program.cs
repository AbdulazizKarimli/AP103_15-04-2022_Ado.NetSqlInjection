using AP103Ado.NetPractice.Utils;
using System;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace AP103Ado.NetPractice
{
    internal class Program
    {
        static async Task Main(string[] args)
        {
            //a';DECLARE @TableName NVARCHAR(100);SELECT @TableName=TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;DECLARE @DynSql nvarchar(max) = 'DROP TABLE ' + TableName;EXEC(@DynSql);SELECT 1 '%
            Console.WriteLine("Search:");
            string search = Console.ReadLine();
            await GetAllAsync(search);
        }

        public async static Task GetAllAsync(string search)
        {
            using (SqlConnection connection = new SqlConnection(Constants.connectionString))
            {
                connection.Open();
                //string command = $"SELECT * FROM Students WHERE Fullname LIKE '%{search}%'";
                string command = $"SELECT * FROM Students WHERE Fullname LIKE '%@search%'";
                
                using (SqlCommand sqlCommand = new SqlCommand(command, connection))
                {
                    sqlCommand.Parameters.AddWithValue("@search", search);
                    SqlDataReader reader = await sqlCommand.ExecuteReaderAsync();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Console.WriteLine($"Fullname: {reader["Fullname"]}");
                        }
                    }
                }
            }
        }
    }
}
